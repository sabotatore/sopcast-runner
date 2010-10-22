module Notification
  def notify_send(message, urgency = 'normal')
    puts "#{message}"
    system "notify-send -u #{urgency} -i /usr/share/sopcast_runner/icon_48x48.png 'SopCast Runner' \"#{message}\"" unless `which notify-send`.empty?
  end
end
