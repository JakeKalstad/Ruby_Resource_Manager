require File.dirname(__FILE__) + "/../View/MainUI"
 @data_base = SQLite3::Database.new( "resource.db" )
 p @data_base.execute("select * from save")
p @data_base.execute("select * from resource_set")
p @data_base.execute("select * from resource_pairs")
MainForm.new.main_loop