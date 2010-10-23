require "yaml"
require "sopcast_runner/notification"

class SopcastRunner
  include Notification

  require "sopcast_runner/sopcast"
  require "sopcast_runner/player"

  DEFAULT_CONFIG = {'player' => 'smplayer', 'port' => 8908}

  def initialize(channel)
    check_sp_auth
    channel_url = get_channel_url(channel)
    config = load_config
    check_player(config['player'])
    @player = Player.new(config['player'], config['port'])
    @sopcast = Sopcast.new(channel_url, config['port'])
  end

  def run
    @sopcast.start
    @player.play
    @sopcast.stop
  end

  private

  def load_config
    # try load config
    config = YAML.load_file("/etc/sopcast_runner/sopcast_runner.conf")
    DEFAULT_CONFIG.each {|option, value| config[option] ||= value} if config
    config || DEFAULT_CONFIG
  rescue Errno::ENOENT
    # return default config
    DEFAULT_CONFIG
  end

  def get_channel_url(channel)
    # if received channel id
    if channel =~ /^\d{3,6}$/
      # return main sopcast url
      return "sop://broker.sopcast.com:3912/#{channel}"
    end
    # otherwise check url
    unless channel =~ /^sop:\/\/(([a-zA-Z0-9\-\.]+\.[a-zA-Z]+)|(([0-9]{1,3}\.){3}[0-9]{1,3})):3912\/\d{3,6}\/?$/
      notify_send("Invalid channel URL")
      exit
    end
    # return channel url
    channel
  end

  def check_sp_auth
    if `which sp-sc`.empty?
      notify_send("Command line p2p video streaming client sp-auth isn't installed")
      exit
    end
  end

  def check_player(name)
    if `which #{name}`.empty?
      notify_send("Player #{name} isn't installed")
      exit
    end
  end

end
