# frozen_string_literal: true

class Channel < ApplicationRecord
  has_many :lives
  belongs_to :platform
  belongs_to :member, optional: true
  belongs_to :editor, optional: true
  validate :validate_channel_format

  scope :youtube, lambda {
    joins(:platform).where(platforms: { platform: 'youtube' })
  }

  def validate_channel_format
    return unless platform.present?

    format = platform.platform == 'youtube' ? /^UC[\w-]+$/ : /^\d+$/

    return if channel =~ format

    errors.add(:channel, "format is invalid #{channel}")
  end
end
