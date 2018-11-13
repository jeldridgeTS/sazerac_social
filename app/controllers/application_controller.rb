class ApplicationController < ActionController::Base
  include Pundit
  include DeviseWhitelistConcern
  include SetVisitorOriginConcern
  include CurrentUserConcern
end
