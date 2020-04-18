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
api_version = 600
resource_type = OneviewSDK.resource_named(:ServerCertificate, api_version, :C7000)

describe provider_class, unit: true do
  include_context 'shared context Oneview API 800'

  let(:resource) do
    Puppet::Type.type(:oneview_server_certificate).new(
      name: 'sc1',
      data:
          {
            'aliasName' => 'hostname-Test'
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
  end

  context 'given the minimum parameters' do
    let(:resource) do
      Puppet::Type.type(:oneview_server_certificate).new(
        name: 'ServerCertificate',
        ensure: 'get_certificate',
        data:
            {
              'remoteIp' => '172.18.13.11'
            },
        provider: 'c7000'
      )
    end

    before(:each) do
      provider.exists?
    end

    it 'should be able to get the certificate request' do
      provider.exists?
      expect(provider.get_certificate).to be
    end
  end
end
