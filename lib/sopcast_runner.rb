require "yaml"
require "sopcast_runner/notification"

class SopcastRunner
  include Notification

  require "sopcast_runner/sopcast"
  require "sopcast_runner/player"

  DEFAULT_CONFIG = {'player' => 'smplayer', 'port' => 8908}

  def initialize(channel)
    check_sp_auth
    channel_id = get_channel_id(channel)
    config = load_config
    check_player(config['player'])
    @player = Player.new(config['player'], config['port'])
    @sopcast = Sopcast.new(channel_id, config['port'])
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

  def get_channel_id(channel)
    unless channel =~ /^((sop:\/\/)?broker.sopcast.com:3912\/)?(\d{4,6})\/?$/
      notify_send("Invalid channel URL or ID")
      exit
    end
    # return channel id
    $3
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
