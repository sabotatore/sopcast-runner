class SopcastRunner::Sopcast
  include Notification

  def initialize(channel, port)
    @channel, @port = channel, port
  end

  def start
    notify_send("Connecting to #{@channel}")
    system "sp-sc #{@channel} 3908 #{@port} > /dev/null &"
    waiting_was_started
    puts "\nSopCast successfully launched"
  end

  def stop
    netstat_output = `netstat -tnlp`
    netstat_output.each_line.map do |l|
      m = l.match(%r|^tcp\s+\S+\s+\S+\s+\S+:#{@port}\s+\S+\s+LISTEN\s+(\d+)|)
      pid = m && m[1]
      pid && system("kill #{pid}")
    end
    puts "SopCast successfully stopped"
  end

  private

  def waiting_was_started
    cmd = "netstat -tnlp 2>/dev/null | grep '#{@port}' > /dev/null"
    timeout = 15
    started = Time.now
    loop do
      break if system cmd
      print '.'
      if (Time.now - started) > timeout
        puts "\n"
        notify_send("SopCast channel #{@channel} isn't active now")
        exit
      end
      sleep 3
    end
  end

end
