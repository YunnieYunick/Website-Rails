require 'rails_helper'

RSpec.describe TagsController, type: :controller do
  let(:valid_attributes) {
    attributes_for(:tag)
  }

  let(:invalid_attributes) {
    attributes_for(:invalid_tag)
  }

  describe "GET #index" do
    before do
      login_user(:user)
    end

    it "returns a success response" do
      tag = Tag.create! valid_attributes
      get :index, params: {}
      expect(response).to be_success
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      tag = Tag.create! valid_attributes
      get :show, params: {id: tag.to_param}
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
      tag = Tag.create! valid_attributes
      get :edit, params: {id: tag.to_param}
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Tag" do
        expect {
          post :create, params: {tag: valid_attributes}
        }.to change(Tag, :count).by(1)
      end

      it "redirects to the created tag" do
        post :create, params: {tag: valid_attributes}
        expect(response).to redirect_to(Tag.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {tag: invalid_attributes}
        expect(response).to be_success
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        attributes_for(:tag, name: 'update tag name')
      }

      it "updates the requested tag" do
        tag = Tag.create! valid_attributes
        put :update, params: {id: tag.to_param, tag: new_attributes}
        tag.reload
        expect(tag.name).to eq('update tag name')
      end

      it "redirects to the tag" do
        tag = Tag.create! valid_attributes
        put :update, params: {id: tag.to_param, tag: valid_attributes}
        expect(response).to redirect_to(tag)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        tag = Tag.create! valid_attributes
        put :update, params: {id: tag.to_param, tag: invalid_attributes}
        expect(response).to be_success
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested tag" do
      tag = Tag.create! valid_attributes
      expect {
        delete :destroy, params: {id: tag.to_param}
      }.to change(Tag, :count).by(-1)
    end

    it "redirects to the tags list" do
      tag = Tag.create! valid_attributes
      delete :destroy, params: {id: tag.to_param}
      expect(response).to redirect_to(tags_url)
    end
  end
end
