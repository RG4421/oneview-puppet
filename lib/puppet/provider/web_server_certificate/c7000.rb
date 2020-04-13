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

require_relative '../oneview_resource'

Puppet::Type.type(:web_server_certificate).provide :c7000, parent: Puppet::OneviewResource do
  desc 'Provider for Web Server Certificate using the C7000 variant of the OneView API'

  confine feature: :oneview
  confine true: login[:hardware_variant] == 'C7000'

  mk_resource_methods

  # Creates a new self-signed appliance certificate based on the certificate data provided
  def create_self_signed
    resource_type = OneviewSDK.resource_named('WebServerCertificate', api_version, resource_variant)
    pretty resource_type.create_self_signed
  end

  def create
    webservercertificate = get_single_resource_instance
    @options = webservercertificate.create_self_signed
    @data[:base64Data] = @options.delete('base64Data')
    pretty webservercertificate.create
  end

  def get_certificate
    webservercertificate = get_single_resource_instance
    storage_system_ip = @data.delete('storage_system_ip')
    pretty webservercertificate.get_certificate(@client, storage_system_ip)
  end
end


