require "bundler/setup"
Bundler.require(:broadcast)
require "active_support/time"
require "logger"

class SendBroadcast
  Morning = "09:00:00".freeze

  def perform
    time_zones_where_it_is(Morning).each do |time_zone|
      logger.info "broadcast to: #{time_zone_identifier(time_zone)}"
      broadcast(time_zone)
    end
  end

  private

  def time_zones_where_it_is(time_string)
    ActiveSupport::TimeZone.all.select do |tz|
      time = tz.parse(time_string)

      current_utc_time.between?(
        time.advance(minutes: -5),
        time.advance(minutes: 5)
      )
    end
  end

  def broadcast(time_zone)
    courier.broadcast(time_zone_identifier(time_zone), { content_available: 1 })
  end

  def time_zone_identifier(time_zone)
    tzinfo = ActiveSupport::TimeZone.find_tzinfo(time_zone.name)
    tzinfo.canonical_identifier
  end

  def logger
    @logger ||= Logger.new(STDOUT)
    if ENV["RACK_ENV"] == "test"
      @logger.level = Logger::FATAL
    else
      @logger.level = Logger::DEBUG
    end
    @logger
  end


  def courier
    @courier ||= Courier::Client.new(api_token: ENV["COURIER_API_TOKEN"])
  end

  def current_utc_time
    @current_utc_time ||= ActiveSupport::TimeZone.new("UTC").now
  end
end
