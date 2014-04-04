Tested on Chrome browser.  Uses HTML5 audio.
HOSTED http://metronome-app.herokuapp.com

This is music practice software geared towards the piano.  At the heart of it is a specialized metronome tied to a piece of piano music.  The piece is modeled as a series of measures each of which contain beats.  A beat is modeled as two numbers: the amount of evenly-spaced notes for the right hand, and same for left.

This  metronome is designed to help a piano student practice tricky Chopin-style music where different polyrhythms can occur.  For example, with ‘Chopin Nocturne in E Minor (Op.72 No.1)’ measures 31 through 37
(http://totalpianist.com/music/classical/c/chopin/nocturnes/nocturne-op-72.pdf), the left hand has consistent triplets but the right hand can have 4, 6, 8, 10, or 11 notes against each triplet.  For such beats, the lowest common multiple is found (e.g., 24 for 8 against 3), and the student would normally map out a grid to determine which note falls on which grid-line (e.g., for 8 against 3, right hand notes fall on every third grid-line, starting on the first).  The student could then set a standard metronome to tick for every grid-line -- for the particular bar under study.  This metronome on the other hand which is tied to a piece description, automatically generates these ticks on a per beat basis, such that in the time interval where normally there would have been 3 ticks, now there are 24. This allows the student to practice -- as one set -- a series of beats each with a potential different number of ticks.  For example, a beat of 8 against 3, followed by another of 11 against 3, would have 24 and 33 ticks respectively, correctly spaced.  The metronome allows for starting and stopping at arbitrary beats.

The user can have many pieces, and there can be many users.  A piece belongs to only one user.  There is a distinct log per piece (with timestamped entries), as well as a distinct metronome-setting per piece.

