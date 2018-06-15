require 'clockwork'
require './config/boot'
require './config/environment'

include Clockwork

module Clockwork
  handler do |job|
    case job
    when 'frequent.job'
    # Every 10 seconds (5,760 ~ 8,640 records per day?)
    # heroku free: 10,000 VS for hoby dev: 10,000,000 rows 
    # retrieve data from CTA API and chuck into database
      TrainlogTask.main
    when 'test.job'
      # SampleMailer.send_when_update.deliver
    when 'less.frequent.job'
      # Every 3 minutes
    when 'hourly.job'
      # Every hour
      # Clear API Response data
      ApiResponse.destory_all
    when 'quarterly.job'
      # Job to be done every quarter day (6hours)
      # Place holder, move midnight job here if too many records

    when 'midnight.job'
      # Midnight job
      # Output CtaLoc to csv and send to my email address
      SampleMailer.send_when_update.deliver
      # Destroy all records for CtaLoc to free up space
      CtaLoc.destroy_all
    end
  end

  every(10.seconds, 'frequent.job')
  every(1.minutes, 'test.job')
  every(3.minutes, 'less.frequent.job')
  every(1.hour, 'hourly.job')
  every(6.hour, 'quarterly.job')
  every(1.day, 'midnight.job', :at => '00:00')
end