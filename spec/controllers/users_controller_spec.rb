require 'rails_helper'

describe UsersController, type: :controller do
  describe "GET new_import" do
    it "has a 200 status code" do
      get :new_import
      expect(response.status).to eq(200)
    end
  end
  describe "POST import" do
    context "File is relevant" do
      it "should return status 0" do
        path = 'spec/fixtures/sample_input_data.txt'
        params = { "file" => Rack::Test::UploadedFile.new(path, 'application/text', true) }
        post :import, params: params
        expect(response.status).to eq(0)
      end
    end
    context "File is irrelevant or buggy" do
      it 'Should return status 1' do
        path = 'spec/fixtures/buggy_input_data.txt'
        params = { "file" => Rack::Test::UploadedFile.new(path, 'application/text', true) }
        post :import, params: params
        expect(response.status).to eq(-1)
      end
    end
  end
end
