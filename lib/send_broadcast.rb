require "bundler/setup"
Bundler.require(:broadcast)
require "active_support/time"
require "logger"

class SendBroadcast
  Morning = "09:00:00".freeze

  def perform
    time_zones_where_it_is(Morning).map do |time_zone|
      time_zone_identifier(time_zone)
    end.uniq.each do |channel|
      broadcast(channel)
    end
  end

  def time_zone_identifier(time_zone)
    offset = time_zone.tzinfo.current_period.utc_total_offset
    ActiveSupport::TimeZone.seconds_to_utc_offset(offset, false)
      .sub("+", "plus ").sub("-", "minus ").parameterize
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

  def broadcast(channel)
    logger.info "broadcast to: #{channel}"
    courier.broadcast(channel, { "content-available": 1 })
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
    @courier ||= Courier::Client.new(
      api_token: ENV["COURIER_API_TOKEN"],
      environment: ENV.fetch("COURIER_ENVIRONMENT", :production)
    )
  end

  def current_utc_time
    @current_utc_time ||= ActiveSupport::TimeZone.new("UTC").now
  end
end
