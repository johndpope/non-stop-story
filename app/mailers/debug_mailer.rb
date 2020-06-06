# frozen_string_literal: true

class DebugMailer < ApplicationMailer
  def email
    @config = Rails.configuration.email[:daily_summary]
    @message = params[:message]

    Network.get_response(Rails.configuration.worker[:debug][:homepage], [@message.channel[:channel]])
    Network.get_response(Rails.configuration.worker[:debug][:all_videos], [@message.channel[:channel]])
    Network.get_response(Rails.configuration.worker[:debug][:all_videos_m], [@message.channel[:channel]])
    Network.get_response(Rails.configuration.worker[:debug][:livestream_m], [@message.channel[:channel]])

    mail(from: @config[:from],
         to: @config[:to],
         subject: "[Non Stop Story/Debug Low Duration] #{@message[:title]}")
  end
end
