;------------------------------------------------------------------------------
; CHANGELOG:
; 
; Sep 13 2007: Added more misspellings.
;              Added fix for -ign -> -ing that ignores words like "sign".
;              Added word beginnings/endings sections to cover more options.
;              Added auto-accents section for words like fiancée, naïve, etc.
; Feb 28 2007: Added other common misspellings based on MS Word AutoCorrect.
;              Added optional auto-correction of 2 consecutive capital letters.
; Sep 24 2006: Initial release by Jim Biancolo (http://www.biancolo.com)
; 
; INTRODUCTION
; 
; This is an AutoHotKey script that implements AutoCorrect against several
; "Lists of common misspellings":
; 
; This does not replace a proper spellchecker such as in Firefox, Word, etc.
; It is usually better to have uncertain typos highlighted by a spellchecker
; than to "correct" them incorrectly so that they are no longer even caught by
; a spellchecker: it is not the job of an autocorrector to correct *all*
; misspellings, but only those which are very obviously incorrect.
; 
; From a suggestion by Tara Gibb, you can add your own corrections to any
; highlighted word by hitting Win+H. These will be added to a separate file,
; so that you can safely update this file without overwriting your changes.
; 
; Some entries have more than one possible resolution (achive->achieve/archive)
; or are clearly a matter of deliberate personal writing style (wanna, colour)
; 
; These have been placed at the end of this file and commented out, so you can
; easily edit and add them back in as you like, tailored to your preferences.
; 
; SOURCES
; 
; http://en.wikipedia.org/wiki/Wikipedia:Lists_of_common_misspellings
; http://en.wikipedia.org/wiki/Wikipedia:Typo
; Microsoft Office autocorrect list
; Script by jaco0646 http://www.autohotkey.com/forum/topic8057.html
; OpenOffice autocorrect list
; TextTrust press release
; User suggestions.
; 
; CONTENTS
; 
;   Settings
;   AUto-COrrect TWo COnsecutive CApitals (commented out by default)
;   Win+H code
;   Fix for -ign instead of -ing
;   Word endings
;   Word beginnings
;   Accented English words
;   Common Misspellings - the main list
;   Ambiguous entries - commented out
;------------------------------------------------------------------------------

;------------------------------------------------------------------------------
; Settings
;------------------------------------------------------------------------------
#NoEnv ; For security
#SingleInstance force

;------------------------------------------------------------------------------
; AUto-COrrect TWo COnsecutive CApitals.
; Disabled by default to prevent unwanted corrections such as IfEqual->Ifequal.
; To enable it, remove the /*..*/ symbols around it.
; From Laszlo's script at http://www.autohotkey.com/forum/topic9689.html
;------------------------------------------------------------------------------
/*
; The first line of code below is the set of letters, digits, and/or symbols
; that are eligible for this type of correction.  Customize if you wish:
keys = abcdefghijklmnopqrstuvwxyz
Loop Parse, keys
    HotKey ~+%A_LoopField%, Hoty
Hoty:
    CapCount := SubStr(A_PriorHotKey,2,1)="+" && A_TimeSincePriorHotkey<999 ? CapCount+1 : 1
    if CapCount = 2
        SendInput % "{BS}" . SubStr(A_ThisHotKey,3,1)
    else if CapCount = 3
        SendInput % "{Left}{BS}+" . SubStr(A_PriorHotKey,3,1) . "{Right}"
Return
*/


;------------------------------------------------------------------------------
; Accented English words, from, amongst others,
; http://en.wikipedia.org/wiki/List_of_English_words_with_diacritics
; I have included all the ones compatible with reasonable codepages, and placed
; those that may often not be accented either from a clash with an unaccented 
; word (resume), or because the unaccented version is now common (cafe).
;------------------------------------------------------------------------------
/*
::a bas::à bas
::a la::à la
::apres::après
::arete::arête
::blase::blasé
::cliche::cliché
::dais::daïs
::deja::déjà
::garcon::garçon
::voila::voilà 
*/

;------------------------------------------------------------------------------
; Common Misspellings - the main list
;------------------------------------------------------------------------------

:*:selecet::select
:*:autocompelter::autocompleter
:*:Autocompelter::Autocompleter
:*:ssf::SELECT TOP 1000{Enter}*{Enter}{Up}    {Home}{Down}FROM{Enter}{Enter}--WHERE{Enter}{Enter}{Up}    {Home}{Up}{Up}    {End}
:*:ssob::SELECT TOP 1000{Enter}*{Enter}{Up}    {Home}{Down}FROM{Enter}{Enter}{Up}    {Home}{Down}--WHERE{Enter}{Enter}{Up}    {Home}{Down}ORDER BY{Enter}{Enter}{Up}    Id DESC{Home}{Up}{Up}{Up}{Up}{End}
:*:clog::console.log({Right};{Left}{Left}
:*:-80-::--------------------------------------------------------------------------------

;-------------------------------------------------------------------------------
; Useful for me
;-------------------------------------------------------------------------------
:*:qqq::matthewfturner@gmail.com


;-------------------------------------------------------------------------------
;  Capitalise dates
;-------------------------------------------------------------------------------
::monday::Monday
::tuesday::Tuesday
::wednesday::Wednesday
::thursday::Thursday
::friday::Friday
::saturday::Saturday
::sunday::Sunday 

::january::January
::february::February
; ::march::March  ; Commented out because it matches the common word "march".
::april::April
; ::may::May  ; Commented out because it matches the common word "may".
::june::June
::july::July
::august::August
::september::September
::october::October
::november::November
::december::December


;-------------------------------------------------------------------------------
; Anything below this point was added to the script by the user via the Win+H hotkey.
;-------------------------------------------------------------------------------
