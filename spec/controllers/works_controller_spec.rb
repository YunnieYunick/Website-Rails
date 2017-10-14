require 'rails_helper'

RSpec.describe WorksController, type: :controller do
  let(:valid_attributes) {
    attributes_for(:work)
  }

  let(:invalid_attributes) {
    attributes_for(:work, start_datetime: nil)
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # WorksController. Be sure to keep this updated too.

  describe "GET #index" do
    before do
      login_user(:user)
    end

    it "returns a success response" do
      work = Work.create! valid_attributes
      get :index, params: {}
      expect(response).to be_success
    end

  end

  describe "GET #show" do
    before do
      login_user(:user)
    end

    it "returns a success response" do
      work = Work.create! valid_attributes
      get :show, params: {id: work.to_param}
      expect(response).to be_success
    end
  end

  describe "GET #new" do
    before do
      login_user(:user)
    end

    it "returns a success response" do
      get :new, params: {}
      expect(response).to be_success
    end
  end

  describe "GET #edit" do
    before do
      login_user(:user)
    end

    it "returns a success response" do
      work = Work.create! valid_attributes
      get :edit, params: {id: work.to_param}
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    before do
      login_user(:user)
      User.first.works << create(:work)
    end

    let(:post_attributes) {
      attributes_for(:work, date_y: "2020", date_m: "01", date_d: "01")
    }

    let(:post_invalid_attributes) {
      attributes_for(:work, date_y: "2020", date_m: "01", date_d: nil)
    }

    context "with valid params" do
      it "creates a new Work" do
        expect {
          post :create, params: {work: post_attributes}
        }.to change(Work, :count).by(1)
      end

      it "redirects to the created work" do
        post :create, params: {work: post_attributes}
        expect(response).to redirect_to(Work.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {work: post_invalid_attributes}
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
        attributes_for(:work, end_datetime: Time.mktime(2020, 12, 24, 00, 00, 00))
      }

      it "updates the requested work" do
        work = Work.create! valid_attributes
        put :update, params: {id: work.to_param, work: new_attributes}
        work.reload
        expect(work.end_datetime).to eq(Time.mktime(2020, 12, 24, 00, 00, 00))
      end

      it "redirects to the work" do
        work = Work.create! valid_attributes
        put :update, params: {id: work.to_param, work: valid_attributes}
        expect(response).to redirect_to(work)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        work = Work.create! valid_attributes
        put :update, params: {id: work.to_param, work: invalid_attributes}
        expect(response).to be_success
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      login_user(:user)
    end

    it "destroys the requested work" do
      work = Work.create! valid_attributes
      expect {
        delete :destroy, params: {id: work.to_param}
      }.to change(Work, :count).by(-1)
    end

    it "redirects to the works list" do
      work = Work.create! valid_attributes
      delete :destroy, params: {id: work.to_param}
      expect(response).to redirect_to(works_url)
    end
  end
end
