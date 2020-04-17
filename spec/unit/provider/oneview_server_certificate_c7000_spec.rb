################################################################################
# (C) Copyright 2020 Hewlett Packard Enterprise Development LP
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

provider_class = Puppet::Type.type(:oneview_server_certificate).provider(:c7000)
api_version = 800
resource_type = OneviewSDK.resource_named(:ServerCertificate, api_version, :C7000)

describe provider_class, unit: true do
  include_context 'shared context'

  let(:resource) do
    Puppet::Type.type(:oneview_server_certificate).new(
      name: 'sc1',
      data:
          {
            'type' => 'CertificateInfoV2'
          },
      provider: 'c7000'
    )
  end

  let(:provider) { resource.provider }

  let(:instance) { provider.class.instances.first }

  let(:test) { resource_type.new(@client, resource['data']) }

  context 'given the min parameters' do
    before(:each) do
      allow(resource_type).to receive(:find_by).and_return([test])
      provider.exists?
    end

    it 'should be an instance of the provider Ruby' do
      expect(provider).to be_an_instance_of Puppet::Type.type(:oneview_server_certificate).provider(:c7000)
    end

    it 'should be able to import certificates' do
      allow(resource_type).to receive(:find_by).and_return([test])
      expect(provider.import).to be
    end

    it 'should be able to get certificates' do
      allow_any_instance_of(resource_type).to receive(:name_servers).and_return(test)
      expect(provider.get_certificate).to be
    end

    it 'should be able to get the types filtered by a name' do
      allow(resource_type).to receive(:update).and_return(test)
      expect(provider.update).to be
    end

    it 'should be able to get the statistics' do
      allow_any_instance_of(resource_type).to receive(:remove).and_return([])
      expect(provider.remove).to be
    end
  end
end
