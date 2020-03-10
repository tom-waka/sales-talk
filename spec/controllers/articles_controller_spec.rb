require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  describe "#index" do
    it "正常なレスポンス" do
      get :index
      expect(response).to be_success
    end
  end

end
