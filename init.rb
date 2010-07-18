require File.dirname(__FILE__) + "/MainUI/View/MainUI"
require File.dirname(__FILE__) + "/setup_db"

Setup_DB.call_forth_the_beast if not File.exist? File.dirname(__FILE__) + "/resource.db"
 @data_base = SQLite3::Database.new( "resource.db" )
#uncomment for debugging data
#p '~~~~~~~~~~~~~~DB OUTPUT ~~~~~~~~~~~~~~~~~~~~~'
#p @data_base.execute("select * from save")
#p @data_base.execute("select * from resource_pairs")
#p '~~~~~~~~~~~~~~DB OUTPUT ~~~~~~~~~~~~~~~~~~~~~'

MainForm.new.main_loop
