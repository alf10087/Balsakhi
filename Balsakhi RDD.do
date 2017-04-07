use "C:\Users\ajr3347\Desktop\Balsakhi_RD_Data.dta" , clear

Drop if balsakhi==0 & test0<=20
gen force = test0 - 20
gen interaction = force * balsakhi 
gen balnobals = cond(bal == 1 & balsakhi==0, 1, 0)
regress test1 force balsakhi interaction if test0 <= 80 & test0 >= -20 

regress test1 force balsakhi interaction if test0 <= 80 & test0 >= -20 
regress test1 force balsakhi interaction if test0 <= 80 & test0 >= -20 & bal == 1
regress test1 force balsakhi interaction if test0 <= 80 & test0 >= -20 & (balnobals == 0 | balsakhi == 1)

* 1. Sharp RDD tau estimation

gen force = test0 - 20
gen interaction = force * balsakhi 
regress test1 force balsakhi interaction if test0 <= 80 & test0 >= -20

twoway (scatter test1 test0) (lfit test1 force balsakhi interaction if test0 <= 80& test0 >= -20)

* 2. Piecewise regression

regress test1 test0 if test0 >= 20 & bal == 1
regress test1 test0 if test0 < 20 & bal == 1

twoway (scatter test1 test0 if bal == 1, msize(tiny) mcolor(gray)) (lfit test1 test0 if test0 >= 20, sort) (lfit test1 test0 if test0 < 20, lcolor(black) sort), xline(20)

* 3. Fourth order polynomial

twoway (lpoly test1 test0 if test0 >= 20 & bal == 1, degree(4)) (lpoly test1 test0 if test0 < 20 & bal == 1, degree(4))

* 4. Non parametric methods

* Method 1

rdrobust test1 test0 if bal == 1, c(20)
rdplot test1 test0 if bal == 1, c(20)

* Method 2

rd test1 bal test0, z0(20) graph

*** Both methods provide similar estimates for the treatment effect, but it doesn't make a lot of sense.
*** The treatment effect is negative! What are we doing wrong?

* 5. Gender effect

rdrobust test1 test0 male if bal == 1, c(20)
rdplot test1 test0 male if bal == 1, c(20)


