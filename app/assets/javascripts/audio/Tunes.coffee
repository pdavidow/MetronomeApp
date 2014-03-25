class window.Tunes

  @spectrumSweep: ->
    windowTime = window.context.currentTime
    Audio.startSound_Right(Audio.tone_700hz, windowTime + 0.05)
    Audio.startSound_Right(Audio.tone_800hz, windowTime + 0.1)
    Audio.startSound_Right(Audio.tone_850hz, windowTime + 0.15)
    Audio.startSound_Right(Audio.tone_900hz, windowTime + 0.2)
    Audio.startSound_Right(Audio.tone_950hz, windowTime + 0.25)
    Audio.startSound_Right(Audio.tone_1000hz, windowTime + 0.30)
    Audio.startSound_Right(Audio.tone_1050hz, windowTime + 0.35)
    Audio.startSound_Right(Audio.tone_1100hz, windowTime + 0.40)
    Audio.startSound_Right(Audio.tone_1150hz, windowTime + 0.45)
    Audio.startSound_Right(Audio.tone_1200hz, windowTime + 0.50)
    Audio.startSound_Right(Audio.tone_1250hz, windowTime + 0.55)
    Audio.startSound_Right(Audio.tone_1300hz, windowTime + 0.60)
    Audio.startSound_Right(Audio.tone_1350hz, windowTime + 0.65)
    Audio.startSound_Right(Audio.tone_1400hz, windowTime + 0.70)
    Audio.startSound_Right(Audio.tone_1450hz, windowTime + 0.75)
    Audio.startSound_Right(Audio.tone_1500hz, windowTime + 0.80)
    Audio.startSound_Right(Audio.tone_2000hz, windowTime + 0.85)
    Audio.startSound_Right(Audio.tone_2500hz, windowTime + 0.90)
    Audio.startSound_Right(Audio.tone_3000hz, windowTime + 0.95)
    Audio.startSound_Right(Audio.tone_3500hz, windowTime + 1.00)
    Audio.startSound_Center(Audio.tone_4000hz, windowTime + 1.05)
    Audio.startSound_Left(Audio.tone_3500hz, windowTime + 1.10)
    Audio.startSound_Left(Audio.tone_3000hz, windowTime + 1.15)
    Audio.startSound_Left(Audio.tone_2500hz, windowTime + 1.20)
    Audio.startSound_Left(Audio.tone_2000hz, windowTime + 1.25)
    Audio.startSound_Left(Audio.tone_1500hz, windowTime + 1.30)
    Audio.startSound_Left(Audio.tone_1000hz, windowTime + 1.35)
    Audio.startSound_Left(Audio.tone_800hz, windowTime + 1.40)

  @okay: ->

  @notOkay: ->
    windowTime = window.context.currentTime
    Audio.startSound_Center(window.Audio.tone_4000hz, windowTime + 0)
    Audio.startSound_Center(Audio.tone_3000hz, windowTime + 0.1)

