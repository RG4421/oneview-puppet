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

server_certificate{'sc1 Get Certificates from RemoteIP':
    ensure => 'get_certificate',
    data   => {
      remoteIp => '172.18.13.11'
    }
}

server_certificate{'sc2 Import':
    ensure  => 'import',
    require => server_certificate['sc1 Get Certificates from RemoteIP'],
    data    => {
      storage_system_ip => '172.18.11.11'
    }
}

server_certificate{'sc2 Update':
    ensure  => 'update',
    require => server_certificate['sc2 Import']
}

server_certificate{'sc3 Delete':
    ensure  => 'remove',
    require => server_certificate['sc2 Update'],
    data    => {
      alias => '172.18.11.11'
    }
}
