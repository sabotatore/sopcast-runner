require "yaml"
require "sopcast"
require "player"

class SopcastRunner

  PORT = '8908'

  def initialize(*args)
    check_sp_auth
    validate_channel(args.first)
    config = load_config
    check_player(config['player'])
    @player = Player.new(config['player'], config['port'])
    @sopcast = Sopcast.new(args.first, config['port'])
  end

  def run
    @sopcast.start
    @player.play
    @sopcast.stop
  end

  private

  def load_config
    YAML.load_file(File.expand_path('../../etc/sopcast-runner.yml', __FILE__))
  end

  def validate_channel(id)
    unless id =~ /^\d{4,6}$/
      puts "Please type correct Channel ID. Run like 'sopcast-runner 12345'"
      exit
    end
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
