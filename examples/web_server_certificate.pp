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

# NOTE: As with all resources, the found ensurable accepts a data as an optional filter field.

web_server_certificate{'wc1':
    ensure => 'create_self_signed',
}

web_server_certificate{'wc2':
    ensure  => 'create',
    require => web_server_certificate['wc1'],
}

web_server_certificate{'wc3':
    ensure  => 'found',
    require => web_server_certificate['wc2'],
    data    => {
      name                    => 'Updated OneViewSDK Test FC Network',
      autoLoginRedistribution => true,
      fabricType              => 'FabricAttach',
    }
}
