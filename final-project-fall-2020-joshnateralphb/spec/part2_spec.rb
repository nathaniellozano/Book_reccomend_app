# spec/app_spec.rb
require File.expand_path '../spec_helper.rb', __FILE__
require 'jwt'
# add yours below
describe "As an admin, I should: "do
before(:all) do 
    @u = User.new
    @u.email = "admin@admin.com"
    @u.password = "admin"
    @u.role_id= 0
    @u.save


    
    get "/api/login?username=admin@admin.com&password=admin"
    expect(last_response.status).to eq(200)	
      @token = JSON.parse(last_response.body)["token"]
      header "AUTHORIZATION", "bearer #{@token}"
      @u = User.first(email: "admin@admin.com")
end

it "be able to add to the master book list" do
    post "/api/admin/books/1?name=testing1"
    expect(last_response.status).to eq(201)
    #end
end
it "be able to edit a book master in the master book list" do
    patch "/api/admin/books/1?name=testing2"
        expect(last_response.status).to eq(200)
    #end
end
end



# add yours below
