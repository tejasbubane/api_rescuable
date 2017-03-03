class ApiController < ApplicationController

  # ActiveRecord
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :handle_record_invalid

  # Strong Params
  rescue_from ActiveModel::ForbiddenAttributesError, with: :handle_forbidden_attributes
  rescue_from ActionController::ParameterMissing, with: :handle_parameter_missing

  # Authorization
  rescue_from CanCan::AccessDenied, with: :handle_forbidden_attributes

  private

  def handle_record_not_found
    render json: { description: 'Not Found',
                   messages: [] },
           status: :not_found
  end

  def handle_record_invalid(exception)
    render json: { description: 'Invalid entity',
                   messages: [exception.to_s] },
           status: :unprocessable_entity
  end

  def handle_forbidden_attributes(exception)
    render json: { description: 'Forbidden attribute(s)',
                   messages: [exception.to_s] },
           status: :bad_request
  end

  def handle_parameter_missing(exception)
    render json: { description: 'Missing Param',
                   messages: [exception.to_s] },
           status: :bad_request
  end

  def handle_unauthorized_access(exception)
    render json: { description: 'You are not authorized for that action',
                   messages: [] },
           status: :unauthorized
  end

end
