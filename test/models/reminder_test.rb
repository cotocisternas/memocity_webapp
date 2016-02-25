require 'test_helper'

class ReminderTest < ActiveSupport::TestCase

  def setup
    @user = users(:nicolas)
    @reminder = @user.reminders.build(content: 'Lorem ipsum', when_activate: '2015-11-30 07:11:58')
  end

  test 'should be valid' do
    assert @reminder.valid?
  end

  test 'user id should be present' do
    @reminder.user_id = nil
    assert_not @reminder.valid?
  end

  test 'content should be present' do
    @reminder.content = '   '
    assert_not @reminder.valid?
  end

  test 'content should be at most 140 characteres' do
    @reminder.content = 'a' * 140
    assert_not @reminder.valid?
  end

  test 'when_activate should be greater than now' do
    @reminder.when_activate > Time.now
  end

  test 'order should be most recent first' do
    assert_equal reminders(:most_recent), Reminder.first
  end
end
