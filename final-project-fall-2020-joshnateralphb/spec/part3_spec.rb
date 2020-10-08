# spec/app_spec.rb
require File.expand_path '../spec_helper.rb', __FILE__
require 'jwt'

def has_status_200
	expect(last_response.status).to eq(200)
end

def has_status_201
	expect(last_response.status).to eq(201)
end

def has_status_404
	expect(last_response.status).to eq(404)
end

def has_status_unauthorized
	expect(last_response.status).to eq(401)
end

def has_status_unprocessable
	expect(last_response.status).to eq(422)
end

def has_status_created
	expect(last_response.status).to eq(201)
end

def valid_json?(json)
    JSON.parse(json)
    return true
  rescue JSON::ParserError => e
    return false
end

def is_valid_token?(encoded_token)
	begin
	JWT.decode encoded_token, "lasjdflajsdlfkjasldkfjalksdjflk", true, { algorithm: 'HS256' }
	return true
	rescue
	return false
	end
end

def get_user_id_from_token(encoded_token)
	begin
	decoded = JWT.decode encoded_token, "lasjdflajsdlfkjasldkfjalksdjflk", true, { algorithm: 'HS256' }
	return decoded[0]["user_id"]
	rescue
	return nil
	end
end

# add yours below
describe "As a user I should be able to: " do
    before(:all) do 
        @u = User.new
        @u.email = "p1@p1.com"
        @u.password = "p1"
        @u.save
  
        @u2 = User.new
        @u2.email = "p2@p2.com"
        @u2.password = "p2"
        @u2.save

        @l = Library.new
  	    @l.name = "okay"
        @l.user_id = @u.id
        @l.save

        @b1 = Book.new
        @b1.ISBN = "123456789876543213456"
        @b1.name = "A_Book"
        @b1.author = "A_Book_Author"
        @b1.genre = "a_Genre"
        @b1.save
        
        @b2 = Book.new
        @b2.ISBN = "12345765432213456"
        @b2.name = "Another Book"
        @b2.author = "A Different Book Author"
        @b2.genre = "a Different Genre"
        @b2.save
    
        @bl = BookLikes.new
        @bl.user_id = User.first.id
        @bl.book_id = Book.first.id
        @bl.save
        @gl = GenreLikes.new
        @gl.user_id = User.first.id
        @gl.genre = Book.first.genre
        @gl.save
    
        @al = AuthorLikes.new
        @al.user_id = User.first.id
        @al.author = Book.first.author
        @al.save
        get "/api/login?username=p1@p1.com&password=p1"
	  	has_status_200	
	  	@token = JSON.parse(last_response.body)["token"]
		  header "AUTHORIZATION", "bearer #{@token}"
		  @u = User.first(email: "p1@p1.com")
    end
    
    it "Look at my library." do
        get "/api/my_library"
        has_status_200
    end

    it "Create a library folder" do
        post "/api/library?name=test1"
        has_status_201
    end

    it "Edit my library" do
        patch "/api/library?name=test2"
        has_status_200
    end

    it "Delete a library" do
        delete "/api/library"
        has_status_200
    end

    it "Look at my reccomendations" do
        get "/api/my_reccomendations"
        has_status_200
    end

    it "Add a new book to my prefrences" do
        patch "/api/preferences/book?name=A_Book"
        has_status_200
    end
    it "Add a new genre to the profile" do
        patch "/api/preferences/genre"
        has_status_200
    end
    it "add  a new book prefrerence" do
        patch "/api/preferences/author"
        has_status_200
    end

    it "Search for new books to read" do
        get "/api/search"
        has_status_200
    end


end
