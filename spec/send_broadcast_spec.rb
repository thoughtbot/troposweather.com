require "active_support/time"
require "courier"
require "timecop"
require_relative "../lib/send_broadcast"

Timecop.safe_mode = true

RSpec.describe SendBroadcast do
  describe "#broadcast" do
    it "broadcasts to time zones where it's currently 9am" do
      time_zone = ActiveSupport::TimeZone.new("UTC")
      now = time_zone.parse("09:00:00")

      Timecop.travel(now) do
        courier = instance_double(Courier::Client)
        allow(Courier::Client).to receive(:new).and_return(courier)
        allow(courier).to receive(:broadcast)

        send_broadcast = SendBroadcast.new
        send_broadcast.perform


        expect(courier).to have_received(:broadcast).
          with(
            "plus-0000",
             { "content-available": 1 }
          ).once
      end
    end

    it "broadcasts to time zones where it's currently 09:04:59" do
      time_zone = ActiveSupport::TimeZone.new("UTC")
      now = time_zone.parse("09:04:59")
      Timecop.travel(now) do
        courier = instance_double(Courier::Client)
        allow(Courier::Client).to receive(:new).and_return(courier)
        allow(courier).to receive(:broadcast)

        send_broadcast = SendBroadcast.new
        send_broadcast.perform

        expect(courier).to have_received(:broadcast).
          with(
            "plus-0000",
            { "content-available": 1 }
          ).once
      end
    end

    it "does not broadcast to time zones where it's currently 09:05:00" do
      now = ActiveSupport::TimeZone.new("Amsterdam").parse("09:05:00")
      Timecop.travel(now) do
        courier = instance_double(Courier::Client)
        allow(Courier::Client).to receive(:new).and_return(courier)
        allow(courier).to receive(:broadcast)

        SendBroadcast.new.perform

        expect(courier).to_not have_received(:broadcast)
      end
    end

    it "broadcasts to time zones where it's currently 8:55:00" do
      time_zone = ActiveSupport::TimeZone.new("UTC")
      now = time_zone.parse("08:55:00")
      Timecop.travel(now) do
        courier = instance_double(Courier::Client)
        allow(Courier::Client).to receive(:new).and_return(courier)
        allow(courier).to receive(:broadcast)

        send_broadcast = SendBroadcast.new
        send_broadcast.perform

        expect(courier).to have_received(:broadcast).
          with(
            "plus-0000",
            { "content-available": 1 }
          )
      end
    end

    it "does not broadcast to time zones where it's currently 08:49:59" do
      now = ActiveSupport::TimeZone.new("Amsterdam").parse("08:49:59")
      Timecop.travel(now) do
        courier = instance_double(Courier::Client)
        allow(Courier::Client).to receive(:new).and_return(courier)
        allow(courier).to receive(:broadcast)

        SendBroadcast.new.perform

        expect(courier).to_not have_received(:broadcast)
      end
    end

    describe "#time_zone_identifier" do
      it "returns a positive time offset as plus-[offset]" do
        time_zone = ActiveSupport::TimeZone.new("Amsterdam")

        expect(SendBroadcast.new.time_zone_identifier(time_zone)).
          to start_with("plus-")
      end

      it "returns a negative time offset as minus-[offset]" do
        time_zone = ActiveSupport::TimeZone.new("America/Los_Angeles")

        expect(SendBroadcast.new.time_zone_identifier(time_zone)).
          to start_with("minus-")
      end
    end
  end
end
