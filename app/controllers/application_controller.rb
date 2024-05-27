class ApplicationController < ActionController::API
        before_action :configure_permitted_parameters, if: :devise_controller?
        #devise_token_auth_group :member, contains: [:user, :admin]
        include DeviseTokenAuth::Concerns::SetUserByToken


        protected
        def configure_permitted_parameters
                devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :name, :image, :email, :password, :password_confirmation])
                #devise_parameter_sanitizer.for(:sign_up){|u|u.permit(:email,:password,:password_confirmation)}
        end
end
