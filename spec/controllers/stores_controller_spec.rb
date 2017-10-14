require 'rails_helper'

RSpec.describe StoresController, type: :controller do
  let(:valid_attributes) {
    attributes_for(:store)
  }

  let(:invalid_attributes) {
    attributes_for(:store, name: nil)
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # StoresController. Be sure to keep this updated too.

  describe "GET #index" do
    it "returns a success response" do
      store = Store.create! valid_attributes
      get :index, params: {}
      expect(response).to be_success
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      store = Store.create! valid_attributes
      get :show, params: {id: store.to_param}
      expect(response).to be_success
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}
      expect(response).to be_success
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      store = Store.create! valid_attributes
      get :edit, params: {id: store.to_param}
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Store" do
        expect {
          post :create, params: {store: valid_attributes}
        }.to change(Store, :count).by(1)
      end

      it "redirects to the created store" do
        post :create, params: {store: valid_attributes}
        expect(response).to redirect_to(Store.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {store: invalid_attributes}
        expect(response).to be_success
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        attributes_for(:store, name: "John Store")
      }

      it "updates the requested store" do
        store = Store.create! valid_attributes
        put :update, params: {id: store.to_param, store: new_attributes}
        store.reload
        expect(store.name).to eq("John Store")
      end

      it "redirects to the store" do
        store = Store.create! valid_attributes
        put :update, params: {id: store.to_param, store: valid_attributes}
        expect(response).to redirect_to(store)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        store = Store.create! valid_attributes
        put :update, params: {id: store.to_param, store: invalid_attributes}
        expect(response).to be_success
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested store" do
      store = Store.create! valid_attributes
      expect {
        delete :destroy, params: {id: store.to_param}
      }.to change(Store, :count).by(-1)
    end

    it "redirects to the stores list" do
      store = Store.create! valid_attributes
      delete :destroy, params: {id: store.to_param}
      expect(response).to redirect_to(stores_url)
    end
  end
end
