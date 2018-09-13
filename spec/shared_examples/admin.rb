RSpec.shared_examples "a protected resource" do
  context "when no login/passwrd are provided" do
    let(:headers) { {} }

    it "responds with 401" do
      get url, headers: headers

      expect(response.status).to eql(401)
    end
  end

  context "when login/password are provided" do
    let(:login) { "admin" }
    let(:authorization_header) do
      ActionController::HttpAuthentication::Basic
        .encode_credentials(login, password)
    end
    let(:headers) { { "HTTP_AUTHORIZATION" => authorization_header} }

    context "and password is invalid" do
      let(:password) { "an-invalid-password" }

      it "responds with 401" do
        get url, headers: headers

        expect(response.status).to eql(401)
      end
    end

    context "and login/password are valid" do
      let(:password) { ENV.fetch("ADMIN_PASSWORD") }

      it "responds with 200" do
        get url, headers: headers

        expect(response.status).to eql(200)
      end
    end
  end
end
