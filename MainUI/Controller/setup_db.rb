require 'rubygems'
require 'sqlite3'
      
      @data_base = SQLite3::Database.new( "resource.db" )
      @data_base.execute("create table resource_pairs (resource_key INTEGER PRIMARY KEY, save_Fkey INTEGER, resx_set_key INTEGER, name TEXT, value TEXT)")
      @data_base.execute("create table resource_set (resource_set_key INTEGER PRIMARY KEY, set_name TEXT) ")
      @data_base.execute("create table save (save_key INTEGER PRIMARY KEY, resource_key INTEGER, set_key INTEGER, save_file TEXT, active_save INTEGER)")