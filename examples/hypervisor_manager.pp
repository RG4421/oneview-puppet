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
oneview_hypervisor_manager{'hm Create':
    ensure => 'present',
    data   => {
      name        => '172.18.13.11',
      username    => 'dcs',
      password    => 'dcs',
      displayName => 'Test Puppet Hypervisor Manager'
    }
}

oneview_hypervisor_manager{'hm Update':
    ensure  => 'present',
    require => Oneview_hypervisor_manager['hm Create'],
    data    => {
      name        => '172.18.13.11',
      username    => 'dcs',
      password    => 'dcs',
      displayName => 'Test HM'
    }
}

oneview_hypervisor_manager{'hm Found':
    ensure  => 'found',
    require => Oneview_hypervisor_manager['hm Update'],
    data    => {
      name     => '172.18.13.11'
    }
}

oneview_hypervisor_manager{'hm Delete':
    ensure  => 'absent',
    require => Oneview_hypervisor_manager['hm Found'],
    data    => {
      name     => '172.18.13.11'
    }
}
