# frozen_string_literal: true

require 'json'
require 'net/http'

class Network
  class << self
    def get_videos(worker, channels)
      retry_count = 0
      begin
        res = request(encode_worker_uri(worker, channels))

        raise "Network error: #{res.code}" unless res.is_a? Net::HTTPSuccess

        filename = "#{Time.now.strftime('%Y%m%d%H%M%S')}_#{channels.join('_')}.json"
        File.open(File.join(Rails.root, 'log', filename), 'ab') do |io|
          io.write(res.body)
        end

        JSON.parse(res.body)
      rescue StandardError => e
        Rails.logger.error e.message
        retry if (retry_count += 1) <= 1
        {}
      end
    end

    def get_response(worker, channels)
      retry_count = 0
      begin
        res = request(encode_worker_uri(worker, channels))

        raise "Network error: #{res.code}" unless res.is_a? Net::HTTPSuccess

        filename = "#{Time.now.strftime('%Y%m%d%H%M%S')}_#{channels.join('_')}.json"
        File.open(File.join(Rails.root, 'log', filename), 'ab') do |io|
          io.write(res.body)
        end
      rescue StandardError => e
        Rails.logger.error e.message
        retry if (retry_count += 1) <= 1
      end
    end

    private

    def encode_worker_uri(worker, channels)
      uri = URI(worker)
      uri.query = URI.encode_www_form(channels: channels)
      uri
    end

    def request(uri)
      Net::HTTP.start(
        uri.host, uri.port,
        open_timeout: 5, read_timeout: 5,
        use_ssl: uri.scheme == 'https', max_retries: 3
      ) do |http|
        http.request Net::HTTP::Get.new(uri)
      end
    end
  end
end
