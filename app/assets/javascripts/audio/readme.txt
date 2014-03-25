Why Have Subdirectories for Coffeescript?
=========================================

Need to enforce for asset-pipeline the correct order of compiling the coffeescript files.
If files are compiled out of order, then get "Uncaught TypeError: Cannot read property 'prototype' of undefined".
Default order is alphabetical, and subdirectories are compiled after parent directory.
Therefore, create a subdirectory for subclass files.

See http://stackoverflow.com/questions/7977032/backbone-js-coffeescript-extends