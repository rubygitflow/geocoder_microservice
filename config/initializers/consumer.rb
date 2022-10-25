# frozen_string_literal: true

channel = RabbitMq.consumer_channel
queue = channel.queue('geocoding', durable: true)

# https://www.rabbitmq.com/tutorials/tutorial-two-ruby.html
queue.subscribe(manual_ack: true) do |delivery_info, _properties, payload|
  payload = JSON(payload)
  coordinates = Geocoder.geocode(payload['city'])

  if coordinates.present?
    client = AdsService::RpcClient.fetch
    client.update_coordinates(payload['id'], coordinates)
  end

  channel.ack(delivery_info.delivery_tag)
end
