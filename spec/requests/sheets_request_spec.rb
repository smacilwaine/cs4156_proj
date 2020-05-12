require 'rails_helper'

RSpec.describe "Sheets", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/sheets/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/sheets/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/sheets/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/sheets/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
