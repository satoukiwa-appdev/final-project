require 'clockwork'
require './config/boot'
require './config/environment'

include Clockwork

module Clockwork
  handler do |job|
    case job
    when 'frequent.job'
    # 10 秒毎の処理
    #   Dir.chdir("./app/actions/"){ puts `trainlog_task.rb` }
      TrainlogTask.main
    when 'less.frequent.job'
      ApiResponse.destory_all
      # 3 分毎の処理
    when 'hourly.job'
      # 1 時間毎の処理
    when 'quarterly.job'
      # Job to be done every quarter day (6hours)
      # Output CtaLoc to csv and send to my email address
      SampleMailer.send_when_update.deliver
      
      # Destroy all records for CtaLoc to free up space
      CtaLoc.destroy_all
      
      
    when 'midnight.job'
      # Midnight job
      # Output CtaLoc to csv and send to my email address
      SampleMailer.send_when_update.deliver
      # Destroy all records for CtaLoc to free up space
      CtaLoc.destroy_all
    end
  end

  every(10.seconds, 'frequent.job')
  every(3.minutes, 'less.frequent.job')
  every(1.hour, 'hourly.job')
  every(6.hour, 'quarterly.job')
  every(1.day, 'midnight.job', :at => '00:00')
end