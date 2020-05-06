# frozen_string_literal: true

require 'test_helper'

class LiveTest < ActiveSupport::TestCase
  test 'should succeed to save' do
    sakurakaze = Live.new(
      title: 'サクラカゼ',
      start_at: Time.mktime(2020, 3, 27, 0, 0, 0),
      member: members(:sakuramiko),
      room: rooms(:channel_X9zw0QF12Kc)
    )
    untildawn = Live.new(
      title: '直到黎明',
      start_at: Time.mktime(2020, 5, 7, 0, 0, 0),
      member: members(:sakuramiko),
      room: rooms(:channel_21144047)
    )

    assert sakurakaze.valid?
    assert untildawn.valid?
    assert sakurakaze.save
    assert untildawn.save
  end

  test 'should fail to save absent field' do
    absent_title = Live.new(
      start_at: Time.mktime(2020, 3, 27, 0, 0, 0),
      member: members(:sakuramiko),
      room: rooms(:channel_X9zw0QF12Kc)
    )
    absent_member = Live.new(
      title: 'サクラカゼ',
      start_at: Time.mktime(2020, 3, 27, 0, 0, 0),
      room: rooms(:channel_X9zw0QF12Kc)
    )

    assert_not absent_title.valid?
    assert_not absent_title.save
    assert_not absent_member.valid?
    assert_not absent_member.save
  end
end
