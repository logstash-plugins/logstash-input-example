# encoding: utf-8
require "logstash/inputs/base"
require "logstash/namespace"
require "stud/interval"
require "socket" # for Socket.gethostname

# Generate a repeating message.
#
# This plugin is intented only as an example.

class LogStash::Inputs::Example < LogStash::Inputs::Base
  config_name "example"

  # If undefined, Logstash will complain, even if codec is unused.
  default :codec, "plain"

  # The message string to use in the event.
  config :message, :validate => :string, :default => "Hello World!"

  # Set how frequently messages should be sent.
  #
  # The default, `1`, means send a message every second.
  config :interval, :validate => :number, :default => 1

  public
  def register
    @host = Socket.gethostname
  end # def register

  def run(queue)
    # This plugin uses Stud.interval. Because we want it to be able to stop
    # cleanly, we need to keep access to the current thread.  It is referenced
    # in the stop method below.
    #
    # Other plugins may require similar access to the current thread.
    @thread = Thread.current

    Stud.interval(@interval) do
      event = LogStash::Event.new("message" => @message, "host" => @host)
      decorate(event)
      queue << event
    end # loop
  end # def run

  def stop
    Stud.stop!(@thread)
  end
end # class LogStash::Inputs::Example
