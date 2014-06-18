class RegistrationsController < Devise::RegistrationsController
	before_filter :update_sanitized_params, if: :devise_controller?
	before_action :configure_permitted_parameters, if: :devise_controller?

	def update_sanitized_params
		devise_parameter_sanitizer.for(:sign_up) 				{ |u| u.permit(:name, :email, :password, :password_confirmation, :company, :role_type, :celp_no, :approval, :authorize) }
		devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :password_confirmation, :current_password, :company, :role_type, :celp_no, :approval, :authorize) }
	end

	def resource_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation, :company, :role_type, :celp_no, :approval, :authorize)
	end

	def create
		super
	end

	def configure_permitted_parameters
	  devise_parameter_sanitizer.for(:sign_up) { |u| u.permit({ roles: [] }, :email, :password) }
	end


	private :resource_params
end




