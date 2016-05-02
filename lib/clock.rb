require "clockwork"
require_relative "./send_broadcast"

Clockwork.every(15.minutes, "send_broadcast", at: ["**:00", "**:15", "**:30", "**:45"]) do
  SendBroadcast.new.perform
end
