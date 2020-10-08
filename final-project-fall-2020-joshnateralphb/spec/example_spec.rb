require File.expand_path '../spec_helper.rb', __FILE__

describe "When not signed in, API" do
    it "should not let me access /api/hello" do
        get "/api/hello"
        expect(last_response.status).to eq(401)
    end

    it "should not let me access /api/admin" do
        get "/api/admin"
        expect(last_response.status).to eq(401)
    end
end

describe "When signed in as a regular user, API" do
    before(:all) do
        #make a user account
        @u = User.new
        @u.email = "user@user.com"
        @u.password = "user"
        @u.save

        #sign in as the account that was just created
        header "AUTHORIZATION", "Bearer #{@u.token}"
    end

    it "should tell me hello, user@user.com" do
        get "/api/hello"

        #status should be ok
        expect(last_response.status).to eq(200)
        #parse the json response
        json = JSON.parse(last_response.body)

        #server responds back with hello, user@user.com
        my_email = @u.email
        expect(json["message"]).to eq("hello, #{my_email}")
    end

    it "should not let me access /api/admin" do
        get "/api/admin"
        expect(last_response.status).to eq(401)
    end
 end

 describe "When signed in as an admin, API" do
    before(:all) do
        @admin = User.new
        @admin.email = "admin@admin.com"
        @admin.password = "admin"
        @admin.role_id = 0
        @admin.save

        header "AUTHORIZATION", "Bearer #{@admin.token}"
    end
    
    it "should let me access /api/admin" do
        get "/api/admin"
        expect(last_response.status).to eq(200)
    end
 end