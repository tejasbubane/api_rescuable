require "action_controller/railtie"
require "active_record"

module CanCan
  class AccessDenied < StandardError; end
end
module ActiveModel
  class ForbiddenAttributesError < StandardError; end
end

class ApiController < ActionController::Base
  include ApiRescuable

  rescue_from_api ActiveRecord::RecordNotFound,
                  ActiveRecord::RecordInvalid,
                  ActiveModel::ForbiddenAttributesError,
                  ActionController::ParameterMissing,
                  CanCan::AccessDenied

  def index
    render json: {}
  end

  def record_not_found
    raise ActiveRecord::RecordNotFound
  end

  def record_invalid
    raise ActiveRecord::RecordInvalid
  end

  def forbidden_attributes
    raise ActiveModel::ForbiddenAttributesError
  end

  def parameter_missing
    raise ActionController::ParameterMissing.new({})
  end

  def access_denied
    raise CanCan::AccessDenied
  end
end
