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

Puppet::Type.newtype(:server_certificate) do
    desc "server certificate"
  
    # :nocov:
    # Get methods
    ensurable do
      defaultvalues
  
      newvalue(:import) do
        provider.import
      end
      # :nocov:
    end
  
    newparam(:name, namevar: true) do
      desc 'erver certificate'
    end
  
    newproperty(:data) do
      desc 'server certificate data hash containing all specifications'
      validate do |value|
        raise 'Inserted value for data is not valid' unless value.class == Hash
      end
    end
  end
  