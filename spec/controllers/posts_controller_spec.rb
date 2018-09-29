require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  let(:valid_attributes) {
    attributes_for(:post)
  }

  let(:invalid_attributes) {
    attributes_for(:post,title: nil)
  }

  describe "GET #index" do
    it "returns a success response" do
      login_user(:user)
      get :index, params: {}
      expect(response).to be_success
    end
  end

  describe "GET #show" do
    before do
      login_user(:user)
      @post = User.last.posts[0]
    end

    it "assign the requested post to @post" do
      get :show, params: {id: @post.to_param}
      expect(assigns(:post)).to eq @post
    end

    it "returns a success response" do
      get :show, params: {id: @post.to_param}
      expect(response).to be_success
    end

  end

  describe "GET #new" do
    before do
      login_user(:user)
    end

    it "assign a new Post to @post" do
      get :new
      expect(assigns(:post)).to be_a_new(Post)
    end

    it "returns a success response" do
      get :new, params: {}
      expect(response).to be_success
    end
  end

  describe "GET #edit" do    
    before do
      login_user(:user)
      @post = User.last.posts[0]
    end

    it "assign the requested post to @post" do
      get :edit, params: {id: @post.to_param}
      expect(assigns(:post)).to eq @post
    end

    it "returns a success response" do
      get :edit, params: {id: @post.to_param}
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    before do
      login_user(:user)
    end

    context "with valid params" do
      pending "creates a new Post" do
        expect {
          post :create, params: {post: attributes_for(:post)}
        }.to change(Post, :count).by(2)
      end

      pending "redirects to the created post" do
        post :create, params: {post: attributes_for(:post)}
        expect(response).to redirect_to(Post.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {post: invalid_attributes}
        expect(response).to be_success
      end
    end
  end

  describe "PUT #update" do
    before do
      login_user(:user)
      @post = User.last.posts[0]
    end

    context "with valid params" do
      let(:new_attributes) {
        attributes_for(:post, title: 'update post name')
      }

      it "updates the requested post" do
        put :update, params: {id: @post.to_param, post: new_attributes}
        @post.reload
        expect(@post.title).to eq('update post name')
      end

      it "redirects to the post" do
        put :update, params: {id: @post.to_param, post: attributes_for(:post)}
        @post.reload
        expect(response).to redirect_to(@post)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        put :update, params: {id: @post.to_param, post: invalid_attributes}
        expect(response).to be_success
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      login_user(:user)
      @post = User.last.posts[0]
    end

    it "destroys the requested post" do
      post = Post.create! valid_attributes
      expect {
        delete :destroy, params: {id: @post.to_param}
      }.to change(Post, :count).by(-1)
    end

    it "redirects to the posts list" do
      post = Post.create! valid_attributes
      delete :destroy, params: {id: @post.to_param}
      expect(response).to redirect_to(posts_url)
    end
  end
end
