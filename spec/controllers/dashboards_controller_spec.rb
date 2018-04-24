require 'rails_helper'

RSpec.describe DashboardsController, type: :controller do
  let(:valid_attributes) {
    attributes_for(:dashboard)
  }

  let(:invalid_attributes) {
    attributes_for(:dashboard, site_name: nil)
  }
  
  describe "Get #index" do
    before do
      login_user(:user)
    end

    it "renders the :index template"  do
      dashboard = Dashboard.create! valid_attributes
      get :index, params: {}
      expect(response).to be_success
    end
  end

  describe "Get #show" do
    before do
      login_user(:user)
    end

    it "return a success response" do
      dashboard = Dashboard.create! valid_attributes
      get :show, params: {id: dashboard.to_param }
      expect(response).to be_success
    end
  end

  describe "Get #new" do
    before do
      login_user(:user)
    end

    it "returns a success response" do
      get :new, params: {}
      expect(response).to be_success
    end
  end

  describe "Get #edit" do
    before do
      login_user(:user)
    end

    it "returns a success response" do
      dashboard = Dashboard.create! valid_attributes
      get :edit, params: {id: dashboard.to_param }
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    before do
      login_user(:user)
    end

    context "with valid params" do
      it "creates a new Dashboard" do
        expect {
          post :create, params: {dashboard: valid_attributes}
        }.to change(Dashboard, :count).by(1)
      end

      it "redirects to the created dashboard" do
        post :create, params: {dashboard: valid_attributes}
        expect(response).to redirect_to(Dashboard.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {dashboard: invalid_attributes}
        expect(response).to be_success
      end
    end
  end

  describe "PUT #update" do
    before do
      login_user(:user)
    end

    context "with valid params" do
      let(:new_attributes) {
        attributes_for(:dashboard, site_name: "New Site")
      }

      it "updates the requested store" do
        dashboard = Dashboard.create! valid_attributes
        put :update, params: {id: dashboard.to_param, dashboard: new_attributes}
        dashboard.reload
        expect(dashboard.site_name).to eq("New Site")
      end

      it "redirects to the dashboard" do
        dashboard = Dashboard.create! valid_attributes
        put :update, params: {id: dashboard.to_param, dashboard: valid_attributes}
        expect(response).to redirect_to(dashboard)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        dashboard = Dashboard.create! valid_attributes
        put :update, params: {id: dashboard.to_param, dashboard: invalid_attributes}
        expect(response).to be_success
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      login_user(:user)
    end

    it "destroys the requested dashboard" do
      dashboard = Dashboard.create! valid_attributes
      expect {
        delete :destroy, params: {id: dashboard.to_param}
      }.to change(Dashboard, :count).by(-1)
    end

    it "redirects to the dashboards list" do
      dashboard = Dashboard.create! valid_attributes
      delete :destroy, params: {id: dashboard.to_param}
      expect(response).to redirect_to(dashboards_url)
    end
  end
end
