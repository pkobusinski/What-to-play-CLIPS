;;;======================================================
;;;   		What to play?
;;;
;;;     This expert system helps determine the best
;;;	musical instrument based on user preferences.
;;;
;;;======================================================

;;; ***************************
;;; * DEFTEMPLATES & DEFFACTS *
;;; ***************************

(deftemplate state-list
	(slot content)
	(slot about)
	(slot numOfAnswers (default 0))
	(slot answer1 (default -))
	(slot answer2 (default -))
	(slot answer3 (default -))
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
	(numOfAnswers 0)
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
	(numOfAnswers 3)
	(answer1 answer0to5)
	(answer2 answer6to12)
	(answer3 answer13plus)
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
	(numOfAnswers 2)
	(answer1 answerYesChauffeur)
	(answer2 answerNotReally)
	(answer3 -)
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
	(numOfAnswers 2)
	(answer1 answerYes)
	(answer2 answerNo)
	(answer3 -)
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
	(numOfAnswers 2)
	(answer1 answerYes2)
	(answer2 answerNoGetPlaying)
	(answer3 -)
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
	(numOfAnswers 3)
	(answer1 answerNotAnIota)
	(answer2 answerYesAmazing)
	(answer3 answerHaveSome)
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
	(numOfAnswers 2)
	(answer1 answerNotQuite)
	(answer2 answerJustLikeMe)
	(answer3 -)
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
	(numOfAnswers 2)
	(answer1 answerWouldntIJust)
	(answer2 answerNotBrat)
	(answer3 -)
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
	(numOfAnswers 2)
	(answer1 answerYesBeethoven)
	(answer2 answerNotParticularly)
	(answer3 -)
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
	(numOfAnswers 2)
	(answer1 answerMozart)
	(answer2 answerMcCartney)
	(answer3 -)
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
	(numOfAnswers 2)
	(answer1 answerYesStar)
	(answer2 answerTeamPlayer)
	(answer3 -)
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
	(numOfAnswers 2)
	(answer1 answerNoise)
	(answer2 answerSure)
	(answer3 -)
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
	(numOfAnswers 3)
	(answer1 answerChurch)
	(answer2 answerPlenty)
	(answer3 answerCompact)
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
	(numOfAnswers 2)
	(answer1 answerPassion)
	(answer2 answerNicePeople)
	(answer3 -)
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
	(numOfAnswers 3)
	(answer1 answerPeopleNoise)
	(answer2 answerSymphony)
	(answer3 answerBaroque)
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
	(numOfAnswers 2)
	(answer1 answerFlowers)
	(answer2 answerHippy)
	(answer3 -)
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
	(numOfAnswers 2)
	(answer1 answerSuperman)
	(answer2 answerWimp)
	(answer3 -)
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
	(numOfAnswers 2)
	(answer1 answerYuck)
	(answer2 answerMusicAboveHygiene)
	(answer3 -)
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
	(numOfAnswers 2)
	(answer1 answerOkIGuess)
	(answer2 answerMetronome)
	(answer3 -)
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
	(numOfAnswers 2)
	(answer1 answerGoodnessNo)
	(answer2 answerGoodLaugh)
	(answer3 -)
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
	(numOfAnswers 3)
	(answer1 answerLife)
	(answer2 answerChallenge)
	(answer3 answerRealChallenge)
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
	(numOfAnswers 2)
	(answer1 answerTooMuchHassle)
	(answer2 answerLove)
	(answer3 -)
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
	(numOfAnswers 2)
	(answer1 answerLouder)
	(answer2 answerElegant)
	(answer3 -)
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
	(numOfAnswers 2)
	(answer1 answerSolo)
	(answer2 answerDefNot)
	(answer3 -)
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
	(numOfAnswers 2)
	(answer1 answerSit)
	(answer2 answerStand)
	(answer3 -)
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
	(numOfAnswers 0)
	(answer1 -)
	(answer2 -)
	(answer3 -)
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
	(numOfAnswers 0)
	(answer1 -)
	(answer2 -)
	(answer3 -)
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
	(numOfAnswers 0)
	(answer1 -)
	(answer2 -)
	(answer3 -)
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
	(numOfAnswers 0)
	(answer1 -)
	(answer2 -)
	(answer3 -)
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
	(numOfAnswers 0)
	(answer1 -)
	(answer2 -)
	(answer3 -)
	(is-result Yes)
)))

(defrule result-french-horn
?f1 <- (wait)
?f2 <- (state-list)
(aboutNerves answerJustLikeMe)
=>
(retract ?f1 ?f2)
(assert (state-list
	(content resultFrenchHorn)
	(about -)
	(numOfAnswers 0)
	(answer1 -)
	(answer2 -)
	(answer3 -)
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
	(numOfAnswers 0)
	(answer1 -)
	(answer2 -)
	(answer3 -)
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
	(numOfAnswers 0)
	(answer1 -)
	(answer2 -)
	(answer3 -)
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
	(numOfAnswers 0)
	(answer1 -)
	(answer2 -)
	(answer3 -)
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
	(numOfAnswers 0)
	(answer1 -)
	(answer2 -)
	(answer3 -)
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
	(numOfAnswers 0)
	(answer1 -)
	(answer2 -)
	(answer3 -)
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
	(numOfAnswers 0)
	(answer1 -)
	(answer2 -)
	(answer3 -)
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
	(numOfAnswers 0)
	(answer1 -)
	(answer2 -)
	(answer3 -)
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
	(numOfAnswers 0)
	(answer1 -)
	(answer2 -)
	(answer3 -)
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
	(numOfAnswers 0)
	(answer1 -)
	(answer2 -)
	(answer3 -)
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
	(numOfAnswers 0)
	(answer1 -)
	(answer2 -)
	(answer3 -)
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
	(numOfAnswers 0)
	(answer1 -)
	(answer2 -)
	(answer3 -)
	(is-result Yes)
)))

(defrule result-trumpet
?f1 <- (wait)
?f2 <- (state-list)
(aboutLoudSoft answerLoud)
=>
(retract ?f1 ?f2)
(assert (state-list
	(content resultTrumpet)
	(about -)
	(numOfAnswers 0)
	(answer1 -)
	(answer2 -)
	(answer3 -)
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
	(numOfAnswers 0)
	(answer1 -)
	(answer2 -)
	(answer3 -)
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
	(numOfAnswers 0)
	(answer1 -)
	(answer2 -)
	(answer3 -)
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
	(numOfAnswers 0)
	(answer1 -)
	(answer2 -)
	(answer3 -)
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
	(numOfAnswers 0)
	(answer1 -)
	(answer2 -)
	(answer3 -)
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
	(numOfAnswers 0)
	(answer1 -)
	(answer2 -)
	(answer3 -)
	(is-result Yes)
)))