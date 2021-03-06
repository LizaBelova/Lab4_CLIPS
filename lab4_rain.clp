(deffunction ask-question (?question)
(printout t ?question)
(bind ?answer (read))
?answer
)

(deftemplate answer-count
(slot not_today)
(slot tomorrow)
)

(defrule init
=>
	(assert (answer-count (not_today 0)(tomorrow 0)))
)

(defrule ask-questions1
?fact1 <- (answer-count (not_today ?c)(tomorrow ?d))
(not (answered 1))
=>
	(bind ?answer (ask-question "Is the sky clear? (y/n): "))

(if (eq ?answer y)
then
	(modify ?fact1 (not_today (+ ?c 1)))
else
	(modify ?fact1 (tomorrow (+ ?d 1)))
)
(assert (answered 1))
)

(defrule ask-questions2
?fact1 <- (answer-count (not_today ?c)(tomorrow ?d))
(not (answered 2))
=>
	(bind ?answer (ask-question "How much storm clouds on the sky? (integer): "))

(if (< ?answer 2)
then
	(modify ?fact1 (not_today (+ ?c 1)))
else
	(if (> ?answer 2)
then
	(modify ?fact1 (tomorrow (+ ?d 1)))
))
(assert (answered 2))
)

(defrule ask-questions3
?fact1 <- (answer-count (not_today ?c)(tomorrow ?d))
(not (answered 3))
=>
	(bind ?answer (ask-question "What is the direction of the wind? (north, south, east, west): "))

(if (eq ?answer north)
then
	(modify ?fact1 (not_today (+ ?c 1))(tomorrow (+ ?d 1)))
)
(assert (answered 3))
)

(defrule ask-questions4
?fact1 <- (answer-count (not_today ?c)(tomorrow ?d))
(not (answered 4))
=>
	(bind ?answer (ask-question "What is the wind speed? (integer, m / s): "))

(if (= ?answer 2)
then
	(modify ?fact1 (not_today (+ ?c 1)))
else
	(if (= ?answer 5)
then
	(modify ?fact1 (tomorrow (+ ?d 1)))
))
(assert (answered 4))
)

(defrule result-rain
?fact1 <- (answer-count (not_today ?c)(tomorrow ?d))
(not (rain 1))
=>
	(if (= 4 ?c)
then
	(assert (result "It will be sunny today, without rain."))
(printout t crlf "It will be sunny today, without rain." crlf)
else
	(if (= 4 ?d)
then
	(assert (result "Tomorrow it will be rainy."))
(printout t crlf "Tomorrow it will be rainy." crlf)
else
	(assert (result "It's going to be rainy."))
(printout t crlf "It's going to be rainy." crlf)
))
(assert (rain 1))
)