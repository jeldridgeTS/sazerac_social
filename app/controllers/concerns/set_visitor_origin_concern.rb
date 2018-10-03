module SetVisitorOriginConcern
  extend ActiveSupport::Concern

  included do
    before_action :set_visitor_origin
  end

  def set_visitor_origin
    session[:visitor_origin] = params[:visitor_origin] if params[:visitor_origin]
  end
end
