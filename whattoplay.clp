;;;======================================================
;;;   		What to play?
;;;
;;;     This expert system helps determine the best
;;;	    musical instrument based on user preferences.
;;;
;;;======================================================

;;; ***************************
;;; * DEFTEMPLATES & DEFFACTS *
;;; ***************************

(deftemplate state-list
	(slot content)
	(slot about)
	(multislot answers)
	(slot is-result (default No))
)

(deffacts start
    (start)
)

;;; ****************
;;; *     START    *
;;; ****************

(defrule start-page
?f <- (start)
=>
(retract ?f)
(assert (state-list
	(content firstPage)
	(about first)
	(answers)
	(is-result No)
)))

;;;***************
;;;* QUERY RULES *
;;;***************

(defrule how-old-are-you
?f1 <- (first)
?f2 <- (state-list)
=>
(retract ?f1 ?f2)
(assert (state-list
	(content questionHowOld)
	(about aboutAge)
	(answers answer0to5 answer6to12 answer13plus)
	(is-result No)
)))

(defrule unlimited-time
?f1 <- (wait)
?f2 <- (state-list)
(aboutAge answer13plus)
=>
(retract ?f1 ?f2)
(assert (state-list
	(content questionChauffeur)
	(about aboutUnlimitedTime)
	(answers answerYesChauffeur answerNotReally)
	(is-result No)
)))

(defrule child-prodigy
?f1 <- (wait)
?f2 <- (state-list)
(aboutAge answer0to5)
=>
(retract ?f1 ?f2)
(assert (state-list
	(content questionChildProdigy)
	(about aboutChildProdigy)
	(answers answerYes answerNo)
	(is-result No)
)))

(defrule lots-of-practice-time
?f1 <- (wait)
?f2 <- (state-list)
(or(aboutAge answer6to12)(aboutChildProdigy answerNo))
=>
(retract ?f1 ?f2)
(assert (state-list
	(content questionPracticeTime)
	(about aboutPracticeTime)
	(answers answerYes2 answerNoGetPlaying)
	(is-result No)
)))

(defrule musical-ability
?f1 <- (wait)
?f2 <- (state-list)
(aboutUnlimitedTime answerNotReally)
=>
(retract ?f1 ?f2)
(assert (state-list
	(content questionMusicalAbility)
	(about aboutMusicalAbility)
	(answers answerYesAmazing answerHaveSome answerNotAnIota)
	(is-result No)
)))

(defrule nerves-of-steel
?f1 <- (wait)
?f2 <- (state-list)
(aboutMusicalAbility answerYesAmazing)
=>
(retract ?f1 ?f2)
(assert (state-list
	(content questionNervesOfSteel)
	(about aboutNervesOfSteel)
	(answers answerNotQuite answerJustLikeMe)
	(is-result No)
)))

(defrule family-mad
?f1 <- (wait)
?f2 <- (state-list)
(aboutPracticeTime answerNoGetPlaying)
=>
(retract ?f1 ?f2)
(assert (state-list
	(content questionFamilyMad)
	(about aboutFamilyMad)
	(answers answerWouldntIJust answerNotBrat)
	(is-result No)
)))

(defrule composer
?f1 <- (wait)
?f2 <- (state-list)
(aboutMusicalAbility answerHaveSome)
=>
(retract ?f1 ?f2)
(assert (state-list
	(content questionComposer)
	(about aboutComposer)
	(answers answerYesBeethoven answerNotParticularly)
	(is-result No)
)))

(defrule mozart-mccartney
?f1 <- (wait)
?f2 <- (state-list)
(aboutComposer answerYesBeethoven)
=>
(retract ?f1 ?f2)
(assert (state-list
	(content questionMozartMcCartney)
	(about aboutMozartMcCartney)
	(answers answerMozart answerMcCartney)
	(is-result No)
)))

(defrule center-of-attention
?f1 <- (wait)
?f2 <- (state-list)
(aboutComposer answerNotParticularly)
=>
(retract ?f1 ?f2)
(assert (state-list
	(content questionCenterOfAttention)
	(about aboutAttention)
	(answers answerYesStar answerTeamPlayer)
	(is-result No)
)))

(defrule jazz
?f1 <- (wait)
?f2 <- (state-list)
(aboutHeavyWeights answerSuperman)
=>
(retract ?f1 ?f2)
(assert (state-list
	(content questionJazz)
	(about aboutJazz)
	(answers answerNoise answerSure)
	(is-result No)
)))

(defrule big-house
?f1 <- (wait)
?f2 <- (state-list)
(or (aboutFamilyMad answerNotBrat) (aboutAttention answerTeamPlayer))
=>
(retract ?f1 ?f2)
(assert (state-list
	(content questionBigHouse)
	(about aboutBigHouse)
	(answers answerChurch answerPlenty answerCompact)
	(is-result No)
)))

(defrule neighbours
?f1 <- (wait)
?f2 <- (state-list)
(aboutBigHouse answerCompact)
=>
(retract ?f1 ?f2)
(assert (state-list
	(content questionHateNeighbours)
	(about aboutNeighbours)
	(answers answerPassion answerNicePeople)
	(is-result No)
)))

(defrule orchestra
?f1 <- (wait)
?f2 <- (state-list)
(aboutBigHouse answerPlenty)
=>
(retract ?f1 ?f2)
(assert (state-list
	(content questionOrchestra)
	(about aboutOrchestra)
	(answers answerPeopleNoise answerSymphony answerBaroque)
	(is-result No)
)))

(defrule folk-music
?f1 <- (wait)
?f2 <- (state-list)
(aboutNeighbours answerNicePeople)
=>
(retract ?f1 ?f2)
(assert (state-list
	(content questionFolkMusic)
	(about aboutFolkMusic)
	(answers answerFlowers answerHippy)
	(is-result No)
)))

(defrule heavy-weights
?f1 <- (wait)
?f2 <- (state-list)
(aboutOrchestra answerSymphony)
=>
(retract ?f1 ?f2)
(assert (state-list
	(content questionHeavyWeights)
	(about aboutHeavyWeights)
	(answers answerSuperman answerWimp)
	(is-result No)
)))

(defrule spit-condensation
?f1 <- (wait)
?f2 <- (state-list)
(aboutHeavyWeights answerWimp)
=>
(retract ?f1 ?f2)
(assert (state-list
	(content questionSpitCondensation)
	(about aboutSpitCondensation)
	(answers answerYuck answerMusicAboveHygiene)
	(is-result No)
)))

(defrule rhythm-timing
?f1 <- (wait)
?f2 <- (state-list)
(aboutNeighbours answerPassion)
=>
(retract ?f1 ?f2)
(assert (state-list
	(content questionRhythmTiming)
	(about aboutRhythmTiming)
	(answers answerOkIGuess answerMetronome)
	(is-result No)
)))

(defrule jokes
?f1 <- (wait)
?f2 <- (state-list)
(aboutSpitCondensation answerYuck)
=>
(retract ?f1 ?f2)
(assert (state-list
	(content questionJokes)
	(about aboutJokes)
	(answers answerGoodnessNo answerGoodLaugh)
	(is-result No)
)))

(defrule challenge
?f1 <- (wait)
?f2 <- (state-list)
(aboutSpitCondensation answerMusicAboveHygiene)
=>
(retract ?f1 ?f2)
(assert (state-list
	(content questionChallenge)
	(about aboutChallenge)
	(answers answerLife answerChallenge answerRealChallenge)
	(is-result No)
)))

(defrule fiddling-reeds
?f1 <- (wait)
?f2 <- (state-list)
(aboutChallenge answerLife)
=>
(retract ?f1 ?f2)
(assert (state-list
	(content questionReeds)
	(about aboutFiddling)
	(answers answerTooMuchHassle answerLove)
	(is-result No)
)))

(defrule loud-soft
?f1 <- (wait)
?f2 <- (state-list)
(aboutFiddling answerTooMuchHassle)
=>
(retract ?f1 ?f2)
(assert (state-list
	(content questionThatOrThat)
	(about aboutLoudSoft)
	(answers answerLouder answerElegant)
	(is-result No)
)))

(defrule moonlight
?f1 <- (wait)
?f2 <- (state-list)
(aboutFiddling answerLove)
=>
(retract ?f1 ?f2)
(assert (state-list
	(content questionMoonlight)
	(about aboutMoonlight)
	(answers answerSolo answerDefNot)
	(is-result No)
)))

(defrule sit-stand
?f1 <- (wait)
?f2 <- (state-list)
(aboutOrchestra answerBaroque)
=>
(retract ?f1 ?f2)
(assert (state-list
	(content questionSitOrStand)
	(about aboutSitOrStand)
	(answers answerSit answerStand)
	(is-result No)
)))


;;;*****************
;;;* RESULTS RULES *
;;;*****************

(defrule result-harp
?f1 <- (wait)
?f2 <- (state-list)
(aboutUnlimitedTime answerYesChauffeur)
=>
(retract ?f1 ?f2)
(assert (state-list
	(content resultHarp)
	(about -)
	(answers)
	(is-result Yes)
)))

(defrule result-comb-tissue
?f1 <- (wait)
?f2 <- (state-list)
(aboutMusicalAbility answerNotAnIota)
=>
(retract ?f1 ?f2)
(assert (state-list
	(content resultCombTissue)
	(about -)
	(answers)
	(is-result Yes)
)))

(defrule result-violin
?f1 <- (wait)
?f2 <- (state-list)
(aboutChildProdigy answerYes)
=>
(retract ?f1 ?f2)
(assert (state-list
	(content resultViolin)
	(about -)
	(answers)
	(is-result Yes)
)))

(defrule result-piano
?f1 <- (wait)
?f2 <- (state-list)
(or (aboutOrchestra answerPeopleNoise) (aboutPracticeTime answerYes2) (aboutNervesOfSteel answerNotQuite) (aboutAttention answerYesStar) (aboutMozartMcCartney answerMozart))
=>
(retract ?f1 ?f2)
(assert (state-list
	(content resultPiano)
	(about -)
	(answers)
	(is-result Yes)
)))

(defrule result-recorder
?f1 <- (wait)
?f2 <- (state-list)
(aboutFamilyMad answerWouldntIJust)
=>
(retract ?f1 ?f2)
(assert (state-list
	(content resultRecorder)
	(about -)
	(answers)
	(is-result Yes)
)))

(defrule result-french-horn
?f1 <- (wait)
?f2 <- (state-list)
(aboutNervesOfSteel answerJustLikeMe)
=>
(retract ?f1 ?f2)
(assert (state-list
	(content resultFrenchHorn)
	(about -)
	(answers)
	(is-result Yes)
)))

(defrule result-tuba
?f1 <- (wait)
?f2 <- (state-list)
(aboutJazz answerNoise)
=>
(retract ?f1 ?f2)
(assert (state-list
	(content resultTuba)
	(about -)
	(answers)
	(is-result Yes)
)))

(defrule result-double-bass
?f1 <- (wait)
?f2 <- (state-list)
(aboutJazz answerSure)
=>
(retract ?f1 ?f2)
(assert (state-list
	(content resultDoubleBass)
	(about -)
	(answers)
	(is-result Yes)
)))

(defrule result-organ
?f1 <- (wait)
?f2 <- (state-list)
(aboutBigHouse answerChurch)
=>
(retract ?f1 ?f2)
(assert (state-list
	(content resultOrgan)
	(about -)
	(answers)
	(is-result Yes)
)))

(defrule result-acoustic-guitar
?f1 <- (wait)
?f2 <- (state-list)
(or (aboutFolkMusic answerFlowers) (aboutMozartMcCartney answerMcCartney))
=>
(retract ?f1 ?f2)
(assert (state-list
	(content resultAcousticGuitar)
	(about -)
	(answers)
	(is-result Yes)
)))

(defrule result-digital-piano
?f1 <- (wait)
?f2 <- (state-list)
(aboutFolkMusic answerHippy)
=>
(retract ?f1 ?f2)
(assert (state-list
	(content resultDigitalPiano)
	(about -)
	(answers)
	(is-result Yes)
)))

(defrule result-oboe
?f1 <- (wait)
?f2 <- (state-list)
(aboutChallenge answerRealChallenge)
=>
(retract ?f1 ?f2)
(assert (state-list
	(content resultOboe)
	(about -)
	(answers)
	(is-result Yes)
)))

(defrule result-percussion
?f1 <- (wait)
?f2 <- (state-list)
(aboutRhythmTiming answerMetronome)
=>
(retract ?f1 ?f2)
(assert (state-list
	(content resultPercussion)
	(about -)
	(answers)
	(is-result Yes)
)))

(defrule result-trombone
?f1 <- (wait)
?f2 <- (state-list)
(aboutRhythmTiming answerOkIGuess)
=>
(retract ?f1 ?f2)
(assert (state-list
	(content resultTrombone)
	(about -)
	(answers)
	(is-result Yes)
)))

(defrule result-bassoon
?f1 <- (wait)
?f2 <- (state-list)
(aboutChallenge answerChallenge)
=>
(retract ?f1 ?f2)
(assert (state-list
	(content resultBassoon)
	(about -)
	(answers)
	(is-result Yes)
)))

(defrule result-cello
?f1 <- (wait)
?f2 <- (state-list)
(aboutJokes answerGoodnessNo)
=>
(retract ?f1 ?f2)
(assert (state-list
	(content resultCello)
	(about -)
	(answers)
	(is-result Yes)
)))

(defrule result-viola
?f1 <- (wait)
?f2 <- (state-list)
(aboutJokes answerGoodLaugh)
=>
(retract ?f1 ?f2)
(assert (state-list
	(content resultViola)
	(about -)
	(answers)
	(is-result Yes)
)))

(defrule result-trumpet
?f1 <- (wait)
?f2 <- (state-list)
(aboutLoudSoft answerLouder)
=>
(retract ?f1 ?f2)
(assert (state-list
	(content resultTrumpet)
	(about -)
	(answers)
	(is-result Yes)
)))

(defrule result-flute
?f1 <- (wait)
?f2 <- (state-list)
(aboutLoudSoft answerElegant)
=>
(retract ?f1 ?f2)
(assert (state-list
	(content resultFlute)
	(about -)
	(answers)
	(is-result Yes)
)))

(defrule result-saxophone
?f1 <- (wait)
?f2 <- (state-list)
(aboutMoonlight answerSolo)
=>
(retract ?f1 ?f2)
(assert (state-list
	(content resultSaxophone)
	(about -)
	(answers)
	(is-result Yes)
)))

(defrule result-clarinet
?f1 <- (wait)
?f2 <- (state-list)
(aboutMoonlight answerDefNot)
=>
(retract ?f1 ?f2)
(assert (state-list
	(content resultClarinet)
	(about -)
	(answers)
	(is-result Yes)
)))

(defrule result-lute
?f1 <- (wait)
?f2 <- (state-list)
(aboutSitOrStand answerSit)
=>
(retract ?f1 ?f2)
(assert (state-list
	(content resultLute)
	(about -)
	(answers)
	(is-result Yes)
)))

(defrule result-harpsichord
?f1 <- (wait)
?f2 <- (state-list)
(aboutSitOrStand answerStand)
=>
(retract ?f1 ?f2)
(assert (state-list
	(content resultHarpsichord)
	(about -)
	(answers)
	(is-result Yes)
)))