class UserMailer < Devise::Mailer
  def confirmation_instructions(record, token, opts = {})
    mail(to: record.email, subject: "【ColorMirror】メールアドレスの確認") do |format|
      format.text { render plain: "確認リンク: #{confirmation_url(record, confirmation_token: token)}" }
      format.html { render "devise/mailer/confirmation_instructions" }
    end
  end
end
