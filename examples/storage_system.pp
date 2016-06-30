################################################################################
# (C) Copyright 2016 Hewlett Packard Enterprise Development LP
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

oneview_storage_system{'storage_system_1':
    ensure  => 'present',
    data    => {
      name         => 'OneViewSDK Test Storage System',
      managedDomain => 'TestDomain',
      credentials => {
        ip_hostname  => '172.18.11.11',
        username     => 'dcs',
        password     => 'dcs',
      }
    }
}

oneview_storage_system{'storage_system_2':
    ensure  => 'present',
    require => Oneview_storage_system['storage_system_1'],
    data    => {
      name         => 'OneViewSDK Test Storage System',
      credentials => {
        ip_hostname  => '172.18.11.11',
      }
    }
}

oneview_storage_system{'storage_system_3':
    ensure  => 'found',
    require => Oneview_storage_system['storage_system_2'],
    data    => {
      credentials => {
        ip_hostname  => '172.18.11.11',
      }
    }
}

oneview_storage_system{'storage_system_4':
    ensure  => 'get_storage_pools',
    require => Oneview_storage_system['storage_system_3'],
    data    => {
      credentials => {
        ip_hostname  => '172.18.11.11',
      }
    }
}

oneview_storage_system{'storage_system_5':
    ensure  => 'get_managed_ports',
    require => Oneview_storage_system['storage_system_4'],
    data    => {
      credentials => {
        ip_hostname  => '172.18.11.11',
      }
    }
}

oneview_storage_system{'storage_system_6':
    ensure  => 'get_host_types',
    require => Oneview_storage_system['storage_system_5'],
    data    => {
      credentials => {
        ip_hostname  => '172.18.11.11',
      }
    }
}
oneview_storage_system{'storage_system_7':
    ensure  => 'absent',
    require => Oneview_storage_system['storage_system_6'],
    data    => {
      credentials => {
        ip_hostname  => '172.18.11.11',
      }
    }
}