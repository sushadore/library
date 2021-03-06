require 'pg'
require 'pry'

module Library

  DB = PG.connect({:dbname => 'library_test'})

  class Book

    def self.add(title,author)
    DB.exec("INSERT INTO books VALUES (uuid_generate_v4(), '#{title}', '#{author}') RETURNING id;")
    end

    def self.all
      DB.exec("SELECT * FROM books;")
    end


    def self.find_by(field, value)
      DB.exec("SELECT * FROM books WHERE #{field} = '#{value}';")
    end

    def self.delete(id)
      DB.exec("DELETE FROM books WHERE id = '#{id}';")
    end

    def self.update(field, value, conditions)
      DB.exec("UPDATE books SET #{field} = '#{value}' WHERE #{conditions};").to_a
    end
  end
end
