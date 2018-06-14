class MailerController < ApplicationController
  default from: "Train Logger",
          reply_to: "atcloc.holder@gmail.com"
  layout 'mailer'

end