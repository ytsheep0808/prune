# coding:utf-8

# Path of the library
prune_path = File.join(File.dirname(__FILE__), "prune")
prune_fullpath = File.expand_path(prune_path)

# Add to the load path of ruby
$:.unshift(prune_path) unless
  $:.include?(prune_path) || $:.include?(prune_fullpath)

# require needed libraries
require "version"
require "pdf_constants"
require "pdf_errors"
require "pdf_types"
require "pdf_objects"
require "pdf_handlers"
require "pdf_fonts"
require "pdf_functions"
require "pdf"
