# Class: rrd
#
# This module manages the core rrd libraries. It should be used when
# only the installation of the librarie are required (e.g. when
# installing the Ganglia metadata daemon `gmetad`)
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#   include rrd

# This file is part of the rrd Puppet module.
#
#     The rrd Puppet module is free software: you can redistribute it and/or modify
#     it under the terms of the GNU General Public License as published by
#     the Free Software Foundation, either version 3 of the License, or
#     (at your option) any later version.
#
#     The rrd Puppet module is distributed in the hope that it will be useful,
#     but WITHOUT ANY WARRANTY; without even the implied warranty of
#     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#     GNU General Public License for more details.
#
#     You should have received a copy of the GNU General Public License
#     along with the rrd Puppet module.  If not, see <http://www.gnu.org/licenses/>.

# [Remember: No empty lines between comments and class definition]
class rrd (
  $ensure = 'installed'
) inherits rrd::params {

  package{$rrd::params::lib_package:
    ensure => $ensure
  }

}
