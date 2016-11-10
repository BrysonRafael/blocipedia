require 'rails_helper'

RSpec.describe Wiki, type: :model do
  let(:wiki) { Wiki.create!(title: "New Wiki Title", body: "New Wiki Body", private: false, user: current_user) }

  describe "attributes" do
    it "has title, body, private, and user attributes" do
      expect(wiki).to have_attributes(title: "New Wiki Title", body: "New Wiki Body", private: false, user: current_user)
    end
  end
end
