require 'sqlite3'
requre_relative '../lib/song.rb'

DB = {:conn => SQLite3::Database.new("db/music.db")}

class SONG

  attr_accessor :name, :album, :id
  
  def initialize(name, album, id=nil)
    @name = name
    @id = id
    @album = album
  end
  
  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS songs (
    id INTEGER PRIMARY KEY,
    name TEXT,
    album TEXT)
    SQL
    DB[:conn].execute(sql)
  end
  
  def save
    sql = <<-SQL
      INSERT INTO songs (name, album) 
      VALUES (?, ?)
    SQL
 
 DB[:conn].execute(sql, self.name, self.album)
 @id = DB[:conn].execute("SELECT last_insert_rowid()FROM songs")[0][0]
  end
end