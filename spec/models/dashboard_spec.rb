require 'rails_helper'

RSpec.describe Dashboard, type: :model do
  it "is valid with a site_name, site_description" do
    expect(build(:dashboard)).to be_valid
  end

  it "is invalid without a site_name" do
    dashboard = build(:dashboard, site_name: nil)
    dashboard.valid?
    expect(dashboard).to be_invalid
  end

  it "is invalid without a site_description" do
    dashboard = build(:dashboard, site_description: nil)
    dashboard.valid?
    expect(dashboard).to be_invalid  
  end
end
