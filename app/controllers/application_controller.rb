class ApplicationController < ActionController::Base
  include DeviseWhitelistConcern
  include SetVisitorOriginConcern
  include CurrentUserConcern
end
