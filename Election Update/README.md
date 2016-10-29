
Objective:
==========
Pull in election polling data so that I can easily see the most relevant
information. This includes National polling averages, Electoral College
breakdown and Odds of victory. Once swing states are known, display any
Must-win states.

Version 1.0:
------------
I currently can access national and state polling data from RCP, Pollster.com,
PEC and part of the Upshot. I have used this data to give the breakdowns I
previously described. Unfortunately, I am being held back by my inability to
scrape text from websites that undergo changes due to JS React.

Remaining items:
-  538 polls eater- not being pulled in due to React text
-  Upshot eater- odds not being pulled in due to React text
-  Convert state hashes into symbols to save memory?
-  Pull in state data concurrently rather than one at a time
-  Display any must-win states for each candidate
-  Open program in terminal on click in Explorer
