require 'rails_helper'

RSpec.describe BlogController, type: :controller do
  describe "GET #index" do
    before do
      @post = create(:post)
    end

    it "returns a success response" do
      get :index, params: {}
      expect(response).to be_success
    end

    it "is published post" do
      get :index, params: {}
      expect(@post.published(Time.now)).to eq(true)
    end

    it "shows locale ja" do
      get :index, params: {}
      expect(I18n.locale).to eq :ja
    end

    it "shows locale en" do
      get :index, params: {locale: 'en'}
      expect(I18n.locale).to eq :en
    end

    it "has search params" do
      get :index, params: {id: @post.to_param, search: 'search post'}
      expect(controller.params[:search]).to eq 'search post'
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      @post = create(:post)
      get :show, params: {id: @post.to_param}
      expect(response).to be_success
    end
  end

  describe "GET #archives" do
    it "returns a success response" do
      @post = create(:post)
      get :archives, params: {id: @post.to_param}
      expect(response).to be_success
    end
  end
end
