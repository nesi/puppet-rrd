# Class: rrd::tool
#
# This module manages the rrd tools packages (rrdtool).
#
# Note: This class does not require the rrd class, as the rrd
# libraries will be installed as dependencies.
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#   include rrd::tool

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
class rrd::tool (
  $ensure = 'present'
) inherits rrd::params {

  package{$rrd::params::tool_package:
    ensure => $ensure,
  }

}