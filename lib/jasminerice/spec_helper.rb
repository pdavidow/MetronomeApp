require "#{Rails.root}/lib/piece_fixture"

module Jasminerice
  module SpecHelper
    include Gon::GonHelpers
    include GonAudioHelper

    def gon_audio_for_no_loop
      self.gon_audio_for_piece(PieceFixture.no_loop)
    end

    def gon_audio_for_last_beat_in_last_measure_only_has_1_tick
      self.gon_audio_for_piece(PieceFixture.last_beat_in_last_measure_only_has_1_tick)
    end

    def gon_audio_for_loop_entire
      self.gon_audio_for_piece(PieceFixture.loop_entire)
    end

    def gon_audio_for_logeeOff
      self.gon_audio_for_piece(PieceFixture.logeeOff)
    end

    def gon_audio_for_logeeA
      self.gon_audio_for_piece(PieceFixture.logeeA)
    end

    def gon_audio_for_logeeB
      self.gon_audio_for_piece(PieceFixture.logeeB)
    end

    def gon_audio_for_logeeC
      self.gon_audio_for_piece(PieceFixture.logeeC)
    end

    def gon_audio_for_logeeD
      self.gon_audio_for_piece(PieceFixture.logeeD)
    end

    def gon_audio_for_logeeE
      self.gon_audio_for_piece(PieceFixture.logeeE)
    end

    def gon_audio_for_logeeF
      self.gon_audio_for_piece(PieceFixture.logeeE)
    end

    def gon_audio_for_logeeG
      self.gon_audio_for_piece(PieceFixture.logeeE)
    end
  end
end
