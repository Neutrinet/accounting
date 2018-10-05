require "rails_helper"
require "shared_examples/admin"

RSpec.describe Admin::MovementsController, :type => :request do
  let(:url) { "/admin/movements" }

  it_behaves_like "a protected resource"
  
  context "admin protection" do
    it "post responds with 401" do
      post url, headers: headers

      expect(response.status).to eql(401)
    end

    it "patch responds with 401" do
      patch url + "/id", headers: headers

      expect(response.status).to eql(401)
    end

    it "put responds with 401" do
      put url + "/id", headers: headers

      expect(response.status).to eql(401)
    end

    it "delete responds with 401" do
      delete url + "/id", headers: headers

      expect(response.status).to eql(401)
    end
  end
end
