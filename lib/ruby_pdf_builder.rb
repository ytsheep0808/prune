# coding:utf-8
#--
# Ruby Pdf Builder(Library to create a pdf document in Ruby.)
# Copyright (C) 2009 Yusuke Tomojiri
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
#++

$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require "pdf_constants"
require "pdf_errors"
require "pdf_types"
require "pdf_objects"
require "pdf_handlers"
require "pdf_fonts"
require "pdf_functions"
require "pdf"

module RubyPdfBuilder
  VERSION = '0.0.1'
end
