require 'data_mapper' # metagem, requires common plugins too.
require "active_support/core_ext/hash/except"

# need install dm-sqlite-adapter
# if on heroku, use Postgres database
# if not use sqlite3 database I gave you
if ENV['DATABASE_URL']
  DataMapper::setup(:default, ENV['DATABASE_URL'] || 'postgres://localhost/mydb')
else
  DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/app.db")
end

class User
    include DataMapper::Resource
    property :id, Serial
    property :email, Text
    property :password, Text
    property :profile_image_url, Text
    property :created_at, DateTime
    property :role_id, Integer, default: 1

    def administrator?
        return role_id == 0
    end 

    def user?
        return role_id != 0
    end
    
    def login(password)
    	return self.password == password
    end
end

class Library
  include DataMapper::Resource
  property :id, Serial
  property :name, Text
  property :user_id, Integer
  property :created_at, DateTime
end
class Book
  include DataMapper::Resource
  property :id, Serial
  property :ISBN, Text
  property :name, Text
  property :author, Text
  property :genre, Text
  property :image_url, Text
  property :created_at, DateTime
end
class BookLikes
  include DataMapper::Resource
    property :id, Serial
    property :user_id,Integer
    property :book_id, Integer
    property :created_at,DateTime
end
class GenreLikes
  include DataMapper::Resource
    property :id, Serial
    property :user_id, Integer
    property :genre, Text
    property :created_at, DateTime 
end
class AuthorLikes
  include DataMapper::Resource
    property :id, Serial
    property :user_id, Integer
    property :author, Text
    property :created_at, DateTime 
end
class LibraryLikes
  include DataMapper::Resource
  property :id, Serial
  property :book_id, Integer
  property :library_id, Integer
  property :created_at, DateTime
end

# Perform basic sanity checks and initialize all relationships
# Call this when you've defined all your models
DataMapper.finalize

# automatically create the post table
User.auto_upgrade!
Library.auto_upgrade!
Book.auto_upgrade!
BookLikes.auto_upgrade!
GenreLikes.auto_upgrade!
AuthorLikes.auto_upgrade!
LibraryLikes.auto_upgrade!

DataMapper::Model.raise_on_save_failure = true  # globally across all models