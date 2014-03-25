# per request of Boris Smus

require 'test_helper'

class TestUseCase < ActiveSupport::TestCase
  def test_case1
    Mongoid.purge!

    p1 = LibraryPieceChopinNocturneEminorOpus72No1Posthumous.archive
    setting = p1.metronome_setting
    setting.classic_ticks_per_minute = 15
    setting.classic_ticks_per_beat = 1
    setting.is_background_on_all_ticks = true
    setting.is_background_tick = true
    setting.is_mute_right_and_left_for_classic = true
    setting.is_classic_tick = true
    setting.is_right_hand_tick = true
    setting.is_left_hand_tick = true
    setting.is_stereo_for_right_left = true
    setting.is_use_entire = true

    ticks = p1.metronome.validated_ticks_of_interest
    classic_ticks = ticks.select{|e| setting.is_tick_classic(e)}
    background_ticks = ticks.select{|e| setting.is_tick_background(e)}
    right_hand_ticks = ticks.select{|e| setting.is_tick_right_hand(e)}
    left_hand_ticks = ticks.select{|e| setting.is_tick_left_hand(e)}

    puts 'simple sources: ', (classic_ticks.size  +  background_ticks.size).to_s
    puts 'panned sources: ', (right_hand_ticks.size  +  left_hand_ticks.size).to_s
  end
end