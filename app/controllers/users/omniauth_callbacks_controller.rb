# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token, only: :google_oauth2
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/heartcombo/devise#omniauth

  def google_oauth2
    auth = request.env["omniauth.auth"]
    type = request.env["omniauth.params"]["type"]

  # Googleアカウント情報を署名付きCookieに保存（有効期限1時間）
  cookies.signed[:google_auth_data] = {
    value: {
      email: auth.info.email,
      provider: auth.provider,
      uid: auth.uid
    }.to_json,
    expires: 1.day.from_now,
    httponly: true,
    secure: Rails.env.production? # HTTPSのみで送信する安全策
  }

    if type == "link"
      handle_google_link(auth)
    else
      handle_google_login(auth)
    end
  end

  def unlink_google_account
    data = cookies.signed[:google_auth_data]
    data = JSON.parse(data, symbolize_names: true) if data.present?

    if data.present?
      user = User.find_by(email: data[:email])
      if user
        user.update(provider: nil, uid: nil)
        cookies.delete(:google_auth_data)

        flash[:notice] = "Googleアカウントの連携を解除しました"
        cookies[:login_method] = "normal"
        redirect_to new_session_path(resource_name)
      else
        flash[:alert] = "ユーザーが見つかりません"
        redirect_to new_registration_path(resource_name)
      end
    else
      flash[:alert] = "連携解除のためには一度ログインからやり直してください"
      redirect_to new_session_path(resource_name)
    end
  end

  def failure
    redirect_to root_path, alert: "認証フローに失敗しました"
  end

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end

  private

  def auth
    auth = request.env["omniauth.auth"]
  end

  def handle_google_link(auth)
    session[:google_auth_data] = {
      provider: auth.provider,
      uid: auth.uid,
      name: auth.info.name,
      email: auth.info.email
    }
    data = session[:google_auth_data]
    user = User.find_by(email: auth.info.email)
    begin
      if user && data.present?
        user.update!(provider: data[:provider], uid: data[:uid])
        cookies[:login_method] = "google"
        flash[:notice] = "Googleアカウントが連携されました。"
      else
        flash[:notice] = "Googleアカウントの連携に失敗しました"
      end
    rescue => e
      flash[:alert] = "予期せぬエラーが発生しました。"
      Rails.logger.error("Googleアカウント連携エラー: #{e.message}")
    end
    render inline:
    <<~HTML
      <script>
        window.opener.location.reload();  // 親画面のリロード
        window.close();
      </script>
    HTML
  end

  def handle_google_login(auth)
    Rails.logger.info "Session data before processing: #{session.inspect}"

    @user = User.from_omniauth(auth)
    if @user.persisted?

      sign_in_and_redirect @user, event: :authentication
      cookies[:login_method] = resource.provider.present? ? "google" : "normal"
      set_flash_message(:notice, :success, kind: "Google") if is_navigational_format?
    else
      session["devise.google_data"] = request.env["omniauth.auth"].except(:extra)
      redirect_to new_user_session_path, alert: @user.errors.full_messages.join("\n")
    end
  end
end
