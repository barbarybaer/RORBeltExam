require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  describe "GET #bright_ideas" do
    it "returns http success" do
      get :bright_ideas
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #delete" do
    it "returns http success" do
      get :delete
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #create" do
    it "returns http success" do
      get :create
      expect(response).to have_http_status(:success)
    end
  end

end
