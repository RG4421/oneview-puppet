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
oneview_logical_enclosure{'logical_enc0':
     ensure  => 'present',
     data    => {
       name                      =>  'e10',
       enclosureUris             =>  ['/rest/enclosures/0000000000A66101',
                                      '/rest/enclosures/0000000000A66102',
                                      '/rest/enclosures/0000000000A66103'],
       enclosureGroupUri         =>  '/rest/enclosure-groups/9f450e4a-52a7-4b67-9bfe-6b0dcf2a358e',
       firmwareBaselineUri       =>  'null',
       forceInstallFirmware       =>  'false',
     }
}

oneview_logical_enclosure{'logical_enc1':
    ensure => 'reapplay_configuration',
    data   => {
      name                      =>  'e10',
    }
}


oneview_logical_enclosure{'logical_enc2':
    ensure => 'get_script',
    data   => {
      name                      =>  'e10',
    }
}

oneview_logical_enclosure{'logical_enc3':
    ensure => 'set_script',
    data   => {
      name   =>  'e10',
      script =>  'This is a script example',
    }
}

oneview_logical_enclosure{'logical_enc4':
    ensure => 'get_script',
    data   => {
      name                      =>  'e10',
    }
}

oneview_logical_enclosure{'logical_enc5':
    ensure => 'updated_from_group',
    data   => {
      name                      =>  'e10',
    }
}

oneview_logical_enclosure{'logical_enc6':
    ensure => 'generate_support_dump',
    data   => {
      name =>  'e10',
      dump =>
        {
          errorCode            => 'Mydump',
          excludeApplianceDump => false
        }
    }
}
