# frozen_string_literal: true

require 'test_helper'

class DebugTest < ActionDispatch::IntegrationTest
  test 'should send email because of low duration' do
    channel = channels(:test_1)
    live_infos = {}

    room_vals = live_infos.to_a.map { |room, _live_info| room }
    open_room_vals = Room.open(channel).pluck('room')

    assert_emails 2 do
      travel_to Time.mktime(2020, 3, 27, 8, 1, 0) do
        LivesDetectJob.close_or_delete_lives open_room_vals - room_vals
      end
    end
  end
end
