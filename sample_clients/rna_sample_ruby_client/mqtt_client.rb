require 'bundler/setup'
# require 'protobuf'
require 'beefcake'
require 'mqtt'
require File.join(File.dirname(__FILE__), '.', 'switch_info.pb.rb')

class MqttClient
  conn_params = {host: 'localhost', port: 1883, keep_alive: 100}
  MQTT::Client.connect(conn_params) do |mqtt_client|
    mqtt_client.get('sci-topic') do |topic, message|
      p "Topic: #{topic} | Message: #{message}"
      # switch_info = SwitchInfo.decode(message)
      switch_info = SwitchInfo.decode(message)
      p "GPB switch_info payload -> #{switch_info}"
      p "DECODED GPB switch_info payload -> value: #{switch_info.value} | type: #{switch_info.type} | encoded: #{switch_info.encoded} | date: #{switch_info.date} | unit_price: #{switch_info.unit_price}"
    end
  end
end
