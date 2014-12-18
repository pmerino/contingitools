ct.er <- function(cttable, level = 0.95)
{
	p <- 1 - (1 - level) / 2
	if (attr(cttable, "factors") == 1)
	{
		DE   <- cttable[1, 1, 1]
		dE  <- cttable[1, 2, 1]
		De  <- cttable[2, 1, 1]
		de <- cttable[2, 2, 1]

		er <- DE / (DE + dE) - De / (dE + de)

		# interval on original scale (difference of proportions)

		se <- sqrt(DE * dE / (DE + dE) ^ 3 + De * de / (De + de) ^ 3)
		int <- er + c(-1, 1) * qnorm(p) * se
		return(list(estimate = er, interval = int))
	}

}