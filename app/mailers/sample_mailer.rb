class SampleMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.sample_mailer.send_when_update.subject
  #
  def send_when_update(email)
    @greeting = "Hi"
    @email = email
    @time = Date.today.to_time
    @cnt = CtaLoc.count

    mail to: @email,
    subject: 'CTA locations of the day at' + @time.to_s
  end
end
