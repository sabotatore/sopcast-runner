require "yaml"

class SopcastRunner

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
      puts "Please type correct Channel ID. Run like 'sopcast-runner 12345'"
      exit
    end
    # return channel id
    $3
  end

  def check_sp_auth
    if `which sp-sc`.empty?
      puts "Please install command line p2p video streaming client sp-auth"
      exit
    end
  end

  def check_player(name)
    if `which #{name}`.empty?
      puts "Please install #{name} or configure other player"
      exit
    end
  end

end
