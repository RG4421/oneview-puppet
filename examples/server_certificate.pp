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

# Retrives certificate from specified IpAddress as 'AliasName'
oneview_server_certificate{'sc1 Retrieve Certificates':
    ensure => 'retrieve',
    data   => {
      aliasName => '172.18.13.11'
    }
}

# Gets Certificate from remoteIp
oneview_server_certificate{'Get Certificates from RemoteIP':
    ensure => 'get_certificate',
    data   => {
      remoteIp  => '172.18.13.11',
      aliasName => '172.18.13.11'
    }
}

oneview_server_certificate{'Import Certificates from RemoteIP':
    ensure => 'import',
    data   => {
      remoteIp  => '172.18.13.11',
      aliasName => '172.18.13.11'
    }
}

oneview_server_certificate{'Update Certificates from RemoteIP':
    ensure => 'present',
    data   => {
      remoteIp  => '172.18.13.11',
      aliasName => '172.18.13.11'
    }
}

oneview_server_certificate{'Removes Certificates from RemoteIP':
    ensure => 'remove',
    data   => {
      remoteIp  => '172.18.13.11',
      aliasName => '172.18.13.11'
    }
}
