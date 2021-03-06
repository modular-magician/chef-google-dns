
# Copyright 2017 Google Inc.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# ----------------------------------------------------------------------------
#
#     ***     AUTO GENERATED CODE    ***    AUTO GENERATED CODE     ***
#
# ----------------------------------------------------------------------------
#
#     This file is automatically generated by Magic Modules and manual
#     changes will be clobbered when the file is regenerated.
#
#     Please read more about how to change this file in README.md and
#     CONTRIBUTING.md located at the root of this package.
#
# ----------------------------------------------------------------------------

# An example Chef recipe that creates a Google Cloud Computing DNS Managed Zone
# in a project.

# Defines a credential to be used when communicating with Google Cloud
# Platform. The title of this credential is then used as the 'credential'
# parameter in the gdns_project type.
#
# For more information on the gauth_credential parameters and providers please
# refer to its detailed documentation at:
#
# For the sake of this example we set the parameter 'path' to point to the file
# that contains your credential in JSON format. And for convenience this example
# allows a variable named $cred_path to be provided to it. If running from the
# command line you can pass it via the command line:
#
#   CRED_PATH=/path/to/my/cred.json \
#     chef-client -z --runlist \
#       "recipe[gdns::examples~managed_zone]"
#
# For convenience you optionally can add it to your ~/.bash_profile (or the
# respective .profile settings) environment:
#
#   export CRED_PATH=/path/to/my/cred.json
#
# TODO(nelsonjr): Add link to documentation on Supermarket / Github
# ________________________

raise "Missing parameter 'CRED_PATH'. Please read docs at #{__FILE__}" \
  unless ENV.key?('CRED_PATH')

gauth_credential 'mycred' do
  action :serviceaccount
  path ENV['CRED_PATH'] # e.g. '/path/to/my_account.json'
  scopes [
    'https://www.googleapis.com/auth/ndev.clouddns.readwrite'
  ]
end

gdns_managed_zone 'testzone-3-com' do
  action :create
  dns_name 'test.somewild-example.com.'
  description 'Test Example Zone'

  # You can also set output-only values as well. Chef will ignore the values
  # when creating the resource, but will assert that its value matches what you
  # specified.
  #
  # This important to ensure that, for example, the top-level registrar is using
  # the correct DNS server names. Although this can cause failures in a run from
  # a clean project, it is useful to ensure that there are no mismatches in the
  # different services.
  #
  # id 579_667_184_320_567_887
  # name_servers [
  #   'ns-cloud-b1.googledomains.com.',
  #   'ns-cloud-b2.googledomains.com.',
  #   'ns-cloud-b3.googledomains.com.',
  #   'ns-cloud-b4.googledomains.com.'
  # ]
  # creation_time '2016-12-02T04:59:24.333Z'

  project 'google.com:graphite-playground'
  credential 'mycred'
end
