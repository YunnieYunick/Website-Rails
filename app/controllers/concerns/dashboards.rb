module Dashboards
  def get_dashboard
    @dashboard = Dashboard.first
  end

  def get_latest_topic
    if Topic.present?
      @topics = Topic.order(params[:id]).reverse_order.limit(3)
    end
  end
end
