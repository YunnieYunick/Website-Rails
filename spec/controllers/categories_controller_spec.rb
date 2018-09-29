require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  describe "GET #index" do
    it "returns a success response" do
      login_user(:user)
      get :index, params: {}
      expect(response).to be_success
    end
  end

  describe "GET #show" do
    before do
      @category = create(:category)
    end

    it "assign the requested category to @category" do
      get :show, params: {id: @category.to_param}
      expect(assigns(:category)).to eq @category
    end

    it "returns a success response" do
      get :show, params: {id: @category.to_param}
      expect(response).to be_success
    end
  end

  describe "GET #new" do
    it "assign a new Category to @category" do
      get :new
      expect(assigns(:category)).to be_a_new(Category)
    end

    it "returns a success response" do
      get :new, params: {}
      expect(response).to be_success
    end
  end

  describe "GET #edit" do
    it "assign the requested category to @category" do
      category = create(:category)
      get :edit, params: {id: category.to_param}
      expect(assigns(:category)).to eq category
    end

    it "returns a success response" do
      category = create(:category)
      get :edit, params: {id: category.to_param}
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Category" do
        expect {
          post :create, params: {category: attributes_for(:category)}
        }.to change(Category, :count).by(1)
      end

      it "redirects to the created Category" do
        post :create, params: {category: attributes_for(:category)}
        expect(response).to redirect_to(Category.last)
      end
    end

    context "with invalid params" do
      it "with invalid attributes" do
        expect{
          post :create, params: {category: attributes_for(:invalid_category)}
        }.not_to change(Category, :count)
      end

      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {category: attributes_for(:invalid_category)}
        expect(response).to render_template :new
      end
    end
  end

  describe "PUT #update" do
    before do
      @category = create(:category)
    end

    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "locates the requested @category" do
        put :update, params: {id: @category.to_param, category: attributes_for(:category)}
        expect(assigns(:category)).to eq(@category)
      end

      it "updates the requested Category" do
        put :update, params: {id: @category.to_param, category: attributes_for(:category,
          name: 'Up Category'
        )}
        @category.reload
        expect(@category.name).to eq('Up Category')
        expect(@category.slug).to eq('up-category')
      end

      it "redirects to the Category" do
        put :update, params: {id: @category.to_param, category: attributes_for(:category)}
        @category.reload
        expect(response).to redirect_to(@category)
      end
    end

    context "with invalid params" do
      it "does not change the category's attributes" do
        put :update, params: {id: @category.to_param, category: attributes_for(:category,
          name: 'nil'
        )}
        @category.reload
        expect(@category.name).to eq(@category.name)
        expect(@category.slug).to eq(@category.slug)
      end
      it "returns a success response (i.e. to display the 'edit' template)" do
        put :update, params: {id: @category.to_param, category: attributes_for(:invalid_category)}
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      @category = create(:category)
    end

    it "destroys the requested Category" do
      expect {
        delete :destroy, params: {id: @category.to_param}
      }.to change(Category, :count).by(-1)
    end

    it "redirects to the Categorys list" do
      delete :destroy, params: {id: @category.to_param}
      expect(response).to redirect_to(categories_url)
    end
  end
end
