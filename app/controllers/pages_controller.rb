class PagesController < ApplicationController
  include Dashboards
  include Blog
  before_action :get_dashboard, only: [:index, :about]
  before_action :get_latest_topic, only: [:index]
  before_action :published_items, only: [:index]

  def index
  end

  def about
  end
end
