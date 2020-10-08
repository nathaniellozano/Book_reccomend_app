# spec/app_spec.rb
require File.expand_path '../spec_helper.rb', __FILE__

describe User do
    it { should have_property           :id }
    it { should have_property           :email }
    it { should have_property           :password }
    it { should have_property           :profile_image_url }
    it { should have_property           :role_id }
    it { should have_property           :created_at }
end
describe Library do
    it { should have_property           :id }
    it { should have_property           :name }
    it { should have_property           :user_id }
    it { should have_property           :created_at }
end
describe Book do
    it { should have_property           :id }
    it { should have_property           :ISBN }
    it { should have_property           :name }
    it { should have_property           :author }
    it { should have_property           :genre }
    it { should have_property           :image_url }
    it { should have_property           :created_at }
end

describe BookLikes do
    it { should have_property           :id }
    it { should have_property           :user_id }
    it { should have_property           :book_id }
    it { should have_property           :created_at }
end
describe GenreLikes do
    it { should have_property           :id }
    it { should have_property           :user_id }
    it { should have_property           :genre }
    it { should have_property           :created_at }
end
describe AuthorLikes do
    it { should have_property           :id }
    it { should have_property           :user_id }
    it { should have_property           :author }
    it { should have_property           :created_at }
end
describe LibraryLikes do
    it { should have_property           :id }
    it { should have_property           :book_id }
    it { should have_property           :library_id }
    it { should have_property           :created_at }
end

# add yours below