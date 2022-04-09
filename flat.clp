(deffunction ask-question (?question)
(printout t ?question)
(bind ?answer (read))
?answer
)

(deftemplate answer-count
(slot not_good)
(slot bad)
)

(defrule init
=>
	(assert (answer-count (not_good 0)(bad 0)))
)

(defrule ask-questions1
?fact1 <- (answer-count (not_good ?c)(bad ?d))
(not (answered 1))
=>
	(bind ?answer (ask-question "Is the area satisfied? (y/n): ")) 

(if (eq ?answer y)
then
	(modify ?fact1 (not_good (+ ?c 1)))
else
	(modify ?fact1 (bad (+ ?d 1)))
)
(assert (answered 1))
)

(defrule ask-questions2
?fact1 <- (answer-count (not_good ?c)(bad ?d))
(not (answered 2))
=>
	(bind ?answer (ask-question "What floor of the flat? (natural number): "))

(if (< ?answer 3)
then
	(modify ?fact1 (not_good (+ ?c 1)))
else
	(if (> ?answer 3)
then
	(modify ?fact1 (bad (+ ?d 1)))
))
(assert (answered 2))
)

(defrule ask-questions3
?fact1 <- (answer-count (not_good ?c)(bad ?d))
(not (answered 3))
=>
	(bind ?answer (ask-question "Is the price right? (y/n): ")) 

(if (eq ?answer y)
then
	(modify ?fact1 (not_good (+ ?c 1))(bad (+ ?d 1)))
)
(assert (answered 3))
)

(defrule ask-questions4
?fact1 <- (answer-count (not_good ?c)(bad ?d))
(not (answered 4))
=>
	(bind ?answer (ask-question "What area of the apartment? (integer): "))

(if (> ?answer 50)
then
	(modify ?fact1 (not_good (+ ?c 1)))
else
	(if (< ?answer 50)
then
	(modify ?fact1 (bad (+ ?d 1)))
))
(assert (answered 4))
)

(defrule result-flat
?fact1 <- (answer-count (not_good ?c)(bad ?d))
(not (flat 1))
=>
	(if (= 4 ?c)
then
	(assert (result "Prepaid expense."))
(printout t crlf "Prepaid expense." crlf)
else
	(if (= 4 ?d)
then
	(assert (result "Think."))
(printout t crlf "Think." crlf)
else
	(assert (result "Renounceent."))
(printout t crlf "Renounceent." crlf)
))
(assert (flat 1))
)