class ApplicationController < ActionController::Base
  protect_from_forgery
  
  enable_fast_search
end
