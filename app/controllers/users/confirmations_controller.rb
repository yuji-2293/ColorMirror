# frozen_string_literal: true

class Users::ConfirmationsController < Devise::ConfirmationsController
    # GET /resource/confirmation/new
    # def new
    #   super
    # end

    # POST /resource/confirmation
    # def create
    #   super
    # end

    def resend
      self.resource = User.find_by(email: params[:user][:email])
      if resource&.needs_confirmation?
        resource.send_confirmation_instructions
          flash[:notice] = "認証メールを送信しました!!"
            if request.referer&.include?("sign_in")
              redirect_to new_session_path(resource_name)
            elsif request.referer&.include?("sign_up")
              redirect_to new_registration_path(resource_name)
            end
      else
          flash[:alert] = "メールアドレスが見つからないか、すでに認証済みです"
            if request.referer&.include?("sign_in")
              redirect_to new_session_path(resource_name)
            elsif request.referer&.include?("sign_up")
              redirect_to new_registration_path(resource_name)
            end
      end
    end

    def confirm
      self.resource = resource_class.new
      respond_to do |format|
        format.turbo_stream
      end
    end

  # GET /resource/confirmation?confirmation_token=abcdef
  # def show
  #   super
  # end

  # protected

  # The path used after resending confirmation instructions.
  # def after_resending_confirmation_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

  # The path used after confirmation.
  # def after_confirmation_path_for(resource_name, resource)
  #   super(resource_name, resource)
  # end
end
