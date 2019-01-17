class Admin::ApplicationController < ApplicationController
  private
  def policy_scope(scope)
    super([:admin, scope])
  end

  def authorize(record)
    super([:admin, record])
  end
end
