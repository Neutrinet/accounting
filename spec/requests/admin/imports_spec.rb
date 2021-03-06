require "rails_helper"
require "shared_examples/admin"

RSpec.describe Admin::ImportsController, :type => :request do
  let(:url) { "/admin/imports/new" }

  it_behaves_like "a protected resource"
end
