require "sinatra"
require "sinatra/namespace"
require_relative 'models.rb'
require_relative "api_authentication.rb"
require "json"
#creating an admin account
#for you, if you have no accounts
if User.all.count == 0
	u = User.new
	u.email = "admin@admin.com"
	u.password = "admin"
	u.role_id = 0
	u.save
end

def api_admin_only!
	api_authenticate!
	halt 401, {message: "Admins only"}.to_json if !current_user.administrator?
end

namespace '/api' do
	before do
		content_type 'application/json'
	end

	get "/admin" do
		api_admin_only!
		halt 200, {message: "super secret admin stuff"}.to_json
	end
	post "/admin/books/:id" do
		api_admin_only!
		n= params["name"]
		if (n!=nil)
			b= Book.new
			b.name= n
			b.save
			halt 201, {message: "super secret admin stuff"}.to_json
		else
			halt 422, {message: "Unable to create Library"}.to_json
		end
	end
	patch "/admin/books/:id" do
		api_admin_only!
		n= params["name"]
		b= Book.get(params["id"])
		if (n!=nil)
			b.name= n
			b.save
			halt 200, {message: "super secret admin stuff"}.to_json
		else
			halt 404, {message: "Unable to create Library"}.to_json
		end
	end

	get "/hello" do
		api_authenticate!
		halt 200, {message: "hello, #{current_user.email}"}.to_json
	end
	get "/my_library" do
		api_authenticate!
		c=current_user
		l =Library.all(user_id: c.id)
		if(l== nil)
			halt 404, {message: "no library found"}.to_json
		else
			halt 200, l.to_json
		end
	end
	post "/library" do
		api_authenticate!
		n=params["name"]
		if(n !=nil)
		l=Library.new()
		l.user_id=current_user.id
		l.name=n
		l.save
		halt 201, {"message" => "added library"}.to_json
		else
		halt 422, {message: "Unable to create Library"}.to_json
		end
	end
	patch "/library" do
		api_authenticate!
		c=current_user
		l=Library.first(user_id: c.id)
		if(l!=nil)
			n= params["name"]
			if(n!= nil)
				l.name=n
			end
			l.save
			halt 200, l.to_json
		else
			halt 404, {message: "Library not found"}.to_json
		end
	end
	delete "/library" do
		api_authenticate!
		c=current_user
		l=Library.first(user_id: c.id)
		if(l !=nil)
			
			l.destroy
			halt 200, {message: "Library deleted" }.to_json
		else
			halt 404, {message: "Library not found"}.to_json
		end
	end
	

	get "/my_reccomendations" do
		api_authenticate!
		c=current_user
		b = Book.all
		halt 200, b.to_json
	end

	get "/search" do
		api_authenticate!
		if params["author"] != nil && params["name"] == nil
			b = Book.all[author: params["author"]]
			halt 200, b.to_json
		end
		if params["name"] != nil
			b = Book.first[name: params["name"]]
			halt 200, b.to_json
		end
	end


	patch "/my_account/profile_image" do
		api_authenticate!
		if params[:image] && params[:image][:tempfile] && params[:image][:filename]
            begin
                token = "Bearer "
                file = params[:image][:tempfile]
                response = HTTParty.post("https://nameless-forest-80107.herokuapp.com/api/images", body: { image: file },  :headers => { "Authorization" => token} )
                data = JSON.parse(response.body)
 
                #make post
                current_user.profile_image_url = data["url"]
                current_user.save
                halt 200, {"message" => "Image updated"}.to_json
            rescue => e
                puts e.message
				halt 422, {message: "Unable to create image"}.to_json
			end
		end

	end

	patch "/preferences/book" do
		api_authenticate!
		newBook = Book.first(name: params["name"])
		if(newBook !=nil)
		newlike = BookLikes.new
		newlike.book_id = newBook.id
		newlike.user_id = current_user.id
		newlike.save
		halt 200, newlike.to_json
		else
			halt 422, {message: "unable to update"}.to_json
		end
	end

	
	patch "/preferences/author" do
		api_authenticate!
		b = params["name"]

		newlike = AuthorLikes.new
		newlike.author = b
		newlike.user_id = current_user.id
		newlike.save
		halt 200, newlike.to_json
	end

	patch "/preferences/genre" do
		api_authenticate!
		b = params["name"]

		newlike = GenreLikes.new
		newlike.genre = b
		newlike.user_id = current_user.id
		newlike.save
		halt 200, newlike.to_json
	end








end
