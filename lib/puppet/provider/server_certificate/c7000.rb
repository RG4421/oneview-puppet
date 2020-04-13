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
require_relative 'web_server_certificate/c7000.rb'

Puppet::Type.type(:server_certificate).provide :c7000, parent: Puppet::OneviewResource do
  desc 'Provider for Server Certificate using the C7000 variant of the OneView API'

  confine feature: :oneview
  confine true: login[:hardware_variant] == 'C7000'
  server_certificate = OneviewSDK.resource_named('ServerCertificate', api_version, resource_variant)
  web_server_certificate = OneviewSDK.resource_named('WebServerCertificate', api_version, resource_variant)
  mk_resource_methods

  def import
    @options =  web_server_certificate.get_certificate
    @data[:certificateDetails][0]base64Data] = @options.delete('base64Data')
    super(:create)
  end
 

