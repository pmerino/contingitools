ct.ar <- function(cttable, level = 0.95)
{
    if (class(cttable) != "cttable")
    {
        cttable <- cttable(cttable)
    }

    if (attr(cttable, "Groups") == 1)
    {
        return(ct.ar.one(cttable, level))
    }
    else
    {
        out <- list()
        for (i in 1:attr(cttable, "Groups"))
        {
            g <- paste0("Group", i)
            out[[g]] <- ct.ar.one(cttable[ , , i], level)
        }

        return(out)
    }
}

ct.ar.one <- function(cttable, level)
{
    p <- 1 - (1 - level) / 2

    DE <- cttable[1, 1]
    dE <- cttable[1, 2]
    De <- cttable[2, 1]
    de <- cttable[2, 2]

    # sec 7.4 page 84
    ar <- (DE * de - dE * De) / ((DE + De) * (De + de))

    # interval on log(1-AR) scale sec 7.4 pg 84
    # order endpoints backwards because we will multiply by -1
    se <- sqrt((dE + ar * (DE + de)) / (sum(cttable) * De))
    int <- log(1-ar) + c(1, -1) * qnorm(p) * se

    return(list(AR = ar, CI = -1 * (exp(int) - 1)))

    # see page 82 for small sample size

}
