class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  include RackSession
  def create
    build_resource(sign_up_params)
    resources.save
    sign_in(resource_name, resource)
    render json: resource, status: :ok
  end
end
