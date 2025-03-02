class DeviseMailer < Devise::Mailer
  default from: ENV["GMAIL_ADDRESS"]
  layout "mailer"
end
