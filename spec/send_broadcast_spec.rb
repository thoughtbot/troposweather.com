require "active_support/time"
require "courier"
require "timecop"
require_relative "../lib/send_broadcast"

Timecop.safe_mode = true

RSpec.describe SendBroadcast do
  describe "#broadcast" do
    it "broadcasts to time zones where it's currently 9am" do
      now = ActiveSupport::TimeZone.new("Amsterdam").parse("09:00:00")
      Timecop.travel(now) do
        courier = instance_double(Courier::Client)
        allow(Courier::Client).to receive(:new).and_return(courier)
        allow(courier).to receive(:broadcast)

        SendBroadcast.new.perform

        expect(courier).to have_received(:broadcast).
          with("Europe/Amsterdam", { "content-available": 1 })
      end
    end

    it "broadcasts to time zones where it's currently 09:04:59" do
      now = ActiveSupport::TimeZone.new("Amsterdam").parse("09:04:59")
      Timecop.travel(now) do
        courier = instance_double(Courier::Client)
        allow(Courier::Client).to receive(:new).and_return(courier)
        allow(courier).to receive(:broadcast)

        SendBroadcast.new.perform

        expect(courier).to have_received(:broadcast).
          with("Europe/Amsterdam", { "content-available": 1 })
      end
    end

    it "does not broadcast to time zones where it's currently 09:05:00" do
      now = ActiveSupport::TimeZone.new("Amsterdam").parse("09:05:00")
      Timecop.travel(now) do
        courier = instance_double(Courier::Client)
        allow(Courier::Client).to receive(:new).and_return(courier)
        allow(courier).to receive(:broadcast)

        SendBroadcast.new.perform

        expect(courier).to_not have_received(:broadcast).
          with("Europe/Amsterdam", { "content-available": 1 })
      end
    end

    it "broadcasts to time zones where it's currently 8:55:00" do
      now = ActiveSupport::TimeZone.new("Amsterdam").parse("08:55:00")
      Timecop.travel(now) do
        courier = instance_double(Courier::Client)
        allow(Courier::Client).to receive(:new).and_return(courier)
        allow(courier).to receive(:broadcast)

        SendBroadcast.new.perform

        expect(courier).to have_received(:broadcast).
          with("Europe/Amsterdam", { "content-available": 1 })
      end
    end

    it "does not broadcast to time zones where it's currently 08:49:59" do
      now = ActiveSupport::TimeZone.new("Amsterdam").parse("08:49:59")
      Timecop.travel(now) do
        courier = instance_double(Courier::Client)
        allow(Courier::Client).to receive(:new).and_return(courier)
        allow(courier).to receive(:broadcast)

        SendBroadcast.new.perform

        expect(courier).to_not have_received(:broadcast).
          with("Europe/Amsterdam", { "content-available": 1 })
      end
    end
  end
end
