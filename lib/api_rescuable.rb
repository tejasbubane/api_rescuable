module ApiRescuable
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

  public

  def self.included(base)
    base.send :extend, ClassMethods
  end

  module ClassMethods
    def rescue_from_api(*klasses)
      rescuer = {
        # ActiveRecord
        ActiveRecord::RecordNotFound => :handle_record_not_found,
        ActiveRecord::RecordInvalid => :handle_record_invalid,

        # Strong Params
        ActiveModel::ForbiddenAttributesError => :handle_forbidden_attributes,
        ActionController::ParameterMissing => :handle_parameter_missing,

        # Authorization
        CanCan::AccessDenied => :handle_unauthorized_access,
      }

      # Add ActiveSupport's rescue_from for all classes given in the list
      klasses.each do |klass|
        rescue_from klass, with: rescuer[klass]
      end

      # Undefine the handlers for classes not given in the list
      (rescuer.keys - klasses).each do |klass|
        undef_method rescuer[klass]
      end
    end
  end
end
