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

server_certificate{'sc1 Create':
    ensure => 'import',
    data   => {
      type               => 'CertificateInfoV2'
      certificateDetails  => 
      {
          'type' => 'CertificateDetailV2',
      }
    }
}

server_certificate{'sc2 Update':
    ensure  => 'present',
    require => server_certificate['sc1 Create'],
    data    => {
      country: 'BR',
      locality: 'Fortaleza',
      organization: 'HPE',
      state: 'Ceara',
      type: 'CertificateDtoV2',
      commonName: 'thetemplate.example.com'
    }
}


server_certificate{'sc3 Delete':
    ensure  => 'absent',
    require => server_certificate['sc2 Update'],
    data    => {
      type  => 'CertificateInfoV2'
    }
}
