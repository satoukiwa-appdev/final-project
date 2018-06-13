class ApplicationMailer < ActionMailer::Base
  default from: 'CTA locations sender (ks)',
          reply_to: 'atcloc.holder@gmail.com'
  layout 'mailer'
end
