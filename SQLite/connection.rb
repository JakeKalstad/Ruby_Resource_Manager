require 'rubygems'
gem 'sqlite3-ruby'
require 'sqlite3'

class Connection
       attr_accessor :data_base
  def initialize
       @data_base = Schema.new.data_base
  end
end

class Schema
  attr_accessor :data_base
 def initialize
      @data_base = SQLite3::Database.new( "resource.db" )
      return if File.exists? 'resource.db'
      create_schema

 end

 def create_schema
     save_table
     resource_table
 end

 def resource_table
     @data_base.execute("create table resource_pairs (resource_key INTEGER PRIMARY KEY, resx_set_key INTEGER, name TEXT, value TEXT)")
     @data_base.execute("create table resource_set (resource_set_key INTEGER PRIMARY KEY, set_name TEXT) ")
 end

 def save_table
     @data_base.execute("create table save (save_key INTEGER PRIMARY KEY, save_file TEXT)")
 end
end

Connection.new