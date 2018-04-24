class PagesController < ApplicationController
  include Dashboards
  before_action :get_dashboard, only: [:index, :about]
  before_action :get_latest_topic, only: [:index]

  def index
  end

  def about
  end
end
