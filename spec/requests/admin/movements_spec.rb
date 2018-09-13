require "rails_helper"
require "shared_examples/admin"

RSpec.describe Admin::MovementsController, :type => :request do
  let(:url) { "/admin/movements" }

  it_behaves_like "a protected resource"
end
