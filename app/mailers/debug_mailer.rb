# frozen_string_literal: true

class DebugMailer < ApplicationMailer
  def email
    @config = Rails.configuration.email[:daily_summary]
    @message = params[:message]
    mail(from: @config[:from],
         to: @config[:to],
         subject: "[Non Stop Story/Debug Low Duration] #{@message[:title]}")
  end
end
