class SopcastRunner::Player

  def initialize(name, port)
    @name, @port = name, port
  end

  def play
    puts "Run #{@name}"
    sleep 2
    system "#{@name} http://localhost:#{@port}/tv.asf > /dev/null 2> /dev/null"
  end

end

