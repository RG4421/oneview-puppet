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

oneview_interconnect{'Interconnect Get Types':
  ensure => 'get_types',
  # data   => {
  #   name => 'Encl2, interconnect 1'
  # }
}

oneview_interconnect{'Interconnect Found':
  ensure => 'found',
  data   => {
    name => 'Encl2, interconnect 1'
  }
}

oneview_interconnect{'Interconnect Found All':
    ensure => 'found'
}

oneview_interconnect{'Interconnect Get Statistics':
    ensure => 'get_statistics',
    data   => {
      name => 'Encl2, interconnect 1'
    }
}

oneview_interconnect{'Interconnect Get Specific Statistics':
    ensure => 'get_statistics',
    data   => {
      name       => 'Encl2, interconnect 1',
      statistics =>
      {
        portName => 'X1'
        # subportNumber => ''
      }
    }
}

oneview_interconnect{'Interconnect Get Name Servers':
    ensure => 'get_name_servers',
    data   => {
      name => 'Encl2, interconnect 1'
    }
}

oneview_interconnect{'Interconnect Patch Interconnect':
    ensure => 'present',
    data   => {
      name  => 'Encl2, interconnect 1',
      patch =>
      {
        op    => 'replace',
        path  => '/uidState',
        value => 'Off'
      }
    }
}

oneview_interconnect{'Interconnect Reset Port Protection':
    ensure => 'reset_port_protection',
    data   => {
      name => 'Encl2, interconnect 1',
    }
}

oneview_interconnect{'Interconnect Update Ports':
    ensure => 'update_ports',
    data   =>
    {
      name  => 'Encl2, interconnect 1',
      ports =>
        [
          {
            name       => 'X1',
            attributes =>
            {
              enabled => true
            }
          },
          {
            name       => 'X2',
            attributes =>
            {
              enabled => true
            }
          }
        ]
    }
}