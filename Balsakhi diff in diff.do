use "/Users/Alfonso/Downloads/Balsakhi_wide.dta", clear

log using "/Users/Alfonso/Downloads/balsakhi.txt", replace

gen deltaY = test1 - test0

regress deltaY bal
estimates store m1, title(Model 1)

regress deltaY balsakhi
estimates store m2, title(Model 2)

regress deltaY bal male
estimates store m3, title(Model 3)

regress deltaY bal bigschool
estimates store m4, title(Model 4)

regress deltaY balsakhi male
estimates store m5, title(Model 5)

regress deltaY balsakhi bigschool
estimates store m6, title(Model 6)

estout m1 m2 m3 m4 m5 m6, cells(b(star fmt(3)) se(par fmt(2)))   ///
   legend label varlabels(_cons constant)               ///
   stats(r2 df_r bic, fmt(3 0 1) label(R-sqr dfres BIC))

*** There is a clear impact of the 'bal' variable in the tests scores.
*** The impact in balsakhi is bigger than the one for bal, this is a consequence
*** of how the variable is specified.
*** The coffficients for the other variables are similar, but the standard error for bal increases
*** Also, there is negative coefficient for being a male, which means that there is a previous
*** effect of gender that is related with bal program. We could try using male as an interaction.
*** Similar results as before. Being in a big school decreases the expected variation in test scores
*** Also, the standard errors for bal stays pretty much the same.

log close
