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
      # 3 分毎の処理
    when 'hourly.job'
      # 1 時間毎の処理
    when 'midnight.job'
      # 夜中の処理
    end
  end

  every(10.seconds, 'frequent.job')
  every(3.minutes, 'less.frequent.job')
  every(1.hour, 'hourly.job')

  every(1.day, 'midnight.job', :at => '00:00')
end