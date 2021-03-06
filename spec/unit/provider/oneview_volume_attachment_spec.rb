################################################################################
# (C) Copyright 2016-2017 Hewlett Packard Enterprise Development LP
#
# Licensed under the Apache License, Version 2.0 (the "License");
# You may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
################################################################################

require 'spec_helper'

provider_class = Puppet::Type.type(:oneview_volume_attachment).provider(:c7000)
api_version = login[:api_version] || 200
resource_type = OneviewSDK.resource_named(:VolumeAttachment, api_version, :C7000)

describe provider_class, unit: true do
  include_context 'shared context'

  let(:resource) do
    Puppet::Type.type(:oneview_volume_attachment).new(
      name: 'VA',
      ensure: 'found',
      data:
          {
            'name' => 'Server Profile Attachment Demo, volume-attachment-demo'
          },
      provider: 'c7000'
    )
  end

  let(:provider) { resource.provider }

  let(:instance) { provider.class.instances.first }

  let(:test) { resource_type.new(@client, resource['data']) }

  context 'given the minimum parameters' do
    before(:each) do
      allow(resource_type).to receive(:find_by).with(anything, resource['data']).and_return([test])
      provider.exists?
    end

    it 'should able to find the specific VA' do
      resource['data']['sanStorage'] = { 'volumeAttachments' => [{ 'volumeUri' => 'fake uri' }] }
      resource['data']['uri'] = 'fake uri'
      test = resource_type.new(@client, resource['data'])
      resource['data'].delete('sanStorage')
      resource['data'].delete('uri')
      allow(resource_type).to receive(:find_by).with(anything, resource['data']).and_return([test])
      allow(OneviewSDK::ServerProfile).to receive(:find_by).with(anything, name: 'Server Profile Attachment Demo').and_return([test])
      allow(OneviewSDK::Volume).to receive(:find_by).with(anything, name: 'volume-attachment-demo').and_return([test])
      expect(provider.found).to be
    end

    it 'should raise an error if there is no name for server profile' do
      resource['data'].delete('name')
      error_raised = "A 'name' tag must be specified within data, containing the server profile name and/or server profile "\
                     'name/volume name to find a specific storage volume attachment'
      expect { provider.find_for_server_profile }.to raise_error(error_raised)
    end

    it 'should be able to get a list of extra unmanaged volumes' do
      expect(resource_type).to receive(:get_extra_unmanaged_volumes).and_return('members' => ['uri' => '/rest/fake'])
      expect(provider.get_extra_unmanaged_volumes).to be
    end

    it 'should be able to remove the extra unmanaged volumes' do
      allow(OneviewSDK::ServerProfile).to receive(:find_by).with(anything, name: resource['data']['name']).and_return([test])
      expect(resource_type).to receive(:remove_extra_unmanaged_volume)
      expect(provider.remove_extra_unmanaged_volume).to be
    end
  end

  context 'given no data' do
    let(:resource) do
      Puppet::Type.type(:oneview_volume_attachment).new(
        name: 'VA',
        ensure: 'found',
        provider: 'c7000'
      )
    end

    it 'should able to find all VAs' do
      test = resource_type.new(@client, {})
      allow(resource_type).to receive(:find_by).with(anything, {}).and_return([test])
      expect(provider.found).to be
    end
  end

  context 'given the get paths attributes' do
    let(:resource) do
      Puppet::Type.type(:oneview_volume_attachment).new(
        name: 'VA',
        ensure: 'get_paths',
        data:
            {
              'name' => 'ONEVIEW_PUPPET_TEST VA1',
              'id'   => 'fake'
            },
        provider: 'c7000'
      )
    end

    it 'should be able to get all paths if no id is provided' do
      resource['data'] = { 'name' => 'ONEVIEW_PUPPET_TEST VA1' }
      resource['data']['uri'] = '/rest/fake'
      test = resource_type.new(@client, resource['data'])
      allow(resource_type).to receive(:find_by).with(anything, resource['data']).and_return([test])
      expect_any_instance_of(resource_type).to receive(:get_paths).and_return(['/rest/fake1', '/rest/fake2'])
      provider.exists?
      expect(provider.get_paths).to be
    end

    it 'should be able to get a path by id if id is provided' do
      allow(resource_type).to receive(:find_by).with(anything, resource['data']).and_return([test])
      expect_any_instance_of(resource_type).to receive(:get_path).and_return(['/rest/fake1'])
      provider.exists?
      expect(provider.get_paths).to be
    end
  end
end
