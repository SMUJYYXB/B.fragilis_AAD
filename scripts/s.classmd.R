#------------------------PCOA
library(ade4)
scatterutil.basemd <-function (dfxy, xax, yax, xlim, ylim, grid, addaxes, cgrid, include.origin, origin, sub, csub, possub, pixmap, contour, area, add.plot,Labels) 
{
    df <- data.frame(dfxy)
    if (!is.data.frame(df)) 
        stop("Non convenient selection for df")
    if ((xax < 1) || (xax > ncol(df))) 
        stop("Non convenient selection for xax")
    if ((yax < 1) || (yax > ncol(df))) 
        stop("Non convenient selection for yax")
    x <- df[, xax]
    y <- df[, yax]
    if (is.null(xlim)) {
        x1 <- x
        if (include.origin) 
            x1 <- c(x1, origin[1])
        x1 <- c(x1 - diff(range(x1)/10), x1 + diff(range(x1))/10)
        xlim <- range(x1)
    }
    if (is.null(ylim)) {
        y1 <- y
        if (include.origin) 
            y1 <- c(y1, origin[2])
        y1 <- c(y1 - diff(range(y1)/10), y1 + diff(range(y1))/10)
        ylim <- range(y1)
    }
    if (!is.null(pixmap)) {
        if (is.null(class(pixmap))) 
            pixmap <- NULL
        if (is.na(charmatch("pixmap", class(pixmap)))) 
            pixmap <- NULL
    }
    if (!is.null(contour)) {
        if (!is.data.frame(contour)) 
            contour <- NULL
        if (ncol(contour) != 4) 
            contour <- NULL
    }
    if (!is.null(area)) {
        if (!is.data.frame(area)) 
            area <- NULL
        if (!is.factor(area[, 1])) 
            area <- NULL
        if (ncol(area) < 3) 
            area <- NULL
    }
    if (!add.plot) 
        plot.default(0, 0, type = "n", asp = 1, 
            xlab = ifelse(is.null(Labels),colnames(df)[xax],paste(colnames(df)[xax],"(",Labels[xax],"%)",sep="")), 
            ylab = ifelse(is.null(Labels),colnames(df)[yax],paste(colnames(df)[yax],"(",Labels[yax],"%)",sep="")), 
            xlim = xlim, ylim = ylim, 
            xaxs = "i", yaxs = "i", frame.plot = FALSE)
    if (!is.null(pixmap)) {
        pixmap::plot(pixmap, add = TRUE)
    }
    if (!is.null(contour)) {
        apply(contour, 1, function(x) segments(x[1], x[2], x[3], 
            x[4], lwd = 1))
    }
    if (grid & !add.plot) 
        scatterutil.grid(cgrid)
    if (addaxes & !add.plot) 
        abline(h = 0, v = 0, lty = 2,col="grey60")
    if (!is.null(area)) {
        nlev <- nlevels(area[, 1])
        x1 <- area[, 2]
        x2 <- area[, 3]
        for (i in 1:nlev) {
            lev <- levels(area[, 1])[i]
            a1 <- x1[area[, 1] == lev]
            a2 <- x2[area[, 1] == lev]
            polygon(a1, a2)
        }
    }
    if (csub > 0) 
        scatterutil.sub(sub, csub, possub)
    return(list(x = x, y = y))
}
#-----
scatterutil.ellipse<-function(x, y, z, cellipse, axesell, coul = rep(1, length(x)),elllwd) 
{
    if (any(is.na(z))) 
        return(invisible())
    if (sum(z * z) == 0) 
        return(invisible())
    util.ellipse <- function(mx, my, vx, cxy, vy, coeff) {
        lig <- 100
        epsi <- 1e-10
        x <- 0
        y <- 0
        if (vx < 0) 
            vx <- 0
        if (vy < 0) 
            vy <- 0
        if (vx == 0 && vy == 0) 
            return(NULL)
        delta <- (vx - vy) * (vx - vy) + 4 * cxy * cxy
        delta <- sqrt(delta)
        l1 <- (vx + vy + delta)/2
        l2 <- vx + vy - l1
        if (l1 < 0) 
            l1 <- 0
        if (l2 < 0) 
            l2 <- 0
        l1 <- sqrt(l1)
        l2 <- sqrt(l2)
        test <- 0
        if (vx == 0) {
            a0 <- 0
            b0 <- 1
            test <- 1
        }
        if ((vy == 0) && (test == 0)) {
            a0 <- 1
            b0 <- 0
            test <- 1
        }
        if (((abs(cxy)) < epsi) && (test == 0)) {
            a0 <- 1
            b0 <- 0
            test <- 1
        }
        if (test == 0) {
            a0 <- 1
            b0 <- (l1 * l1 - vx)/cxy
            norm <- sqrt(a0 * a0 + b0 * b0)
            a0 <- a0/norm
            b0 <- b0/norm
        }
        a1 <- 2 * pi/lig
        c11 <- coeff * a0 * l1
        c12 <- (-coeff) * b0 * l2
        c21 <- coeff * b0 * l1
        c22 <- coeff * a0 * l2
        angle <- 0
        for (i in 1:lig) {
            cosinus <- cos(angle)
            sinus <- sin(angle)
            x[i] <- mx + c11 * cosinus + c12 * sinus
            y[i] <- my + c21 * cosinus + c22 * sinus
            angle <- angle + a1
        }
        return(list(x = x, y = y, seg1 = c(mx + c11, my + c21, 
            mx - c11, my - c21), seg2 = c(mx + c12, my + c22, 
            mx - c12, my - c22)))
    }
    z <- z/sum(z)
    m1 <- sum(x * z)
    m2 <- sum(y * z)
    v1 <- sum((x - m1) * (x - m1) * z)
    v2 <- sum((y - m2) * (y - m2) * z)
    cxy <- sum((x - m1) * (y - m2) * z)
    ell <- util.ellipse(m1, m2, v1, cxy, v2, cellipse)
    if (is.null(ell)) 
        return(invisible())
    polygon(ell$x, ell$y, border = coul,lwd =elllwd)
    if (axesell) 
        segments(ell$seg1[1], ell$seg1[2], ell$seg1[3], ell$seg1[4], 
            lty = 2, col = coul)
    if (axesell) 
        segments(ell$seg2[1], ell$seg2[2], ell$seg2[3], ell$seg2[4], 
            lty = 2, col = coul)
}

#-----
s.classmd <-function (dfxy, fac, wt = rep(1, length(fac)), xax = 1, yax = 2, 
    cstar = 1, cellipse = 1.5, axesell = TRUE, label = levels(fac), 
    clabel = 1, cpoint = 1, pch = 20, col = rep(1, length(levels(fac))), lwd=1,
    xlim = NULL, ylim = NULL, grid = TRUE, addaxes = TRUE, origin = c(0, 0), 
    include.origin = TRUE, sub = "", csub = 1, possub = "bottomleft", 
    cgrid = 1, pixmap = NULL, contour = NULL, area = NULL, add.plot = FALSE,Labels=NULL,show.legend=FALSE) 
{
    opar <- par(mar = par("mar"))
    par(mar = c(4, 4, 0.2, 0.2))
    on.exit(par(opar))
    dfxy <- data.frame(dfxy)
    if (!is.data.frame(dfxy)) 
        stop("Non convenient selection for dfxy")
    if (any(is.na(dfxy))) 
        stop("NA non implemented")
    if (!is.factor(fac)) 
        stop("factor expected for fac")
    dfdistri <- ade4:::fac2disj(fac) * wt
    coul <- col
    w1 <- unlist(lapply(dfdistri, sum))
    dfdistri <- t(t(dfdistri)/w1)
    coox <- as.matrix(t(dfdistri)) %*% dfxy[, xax]
    cooy <- as.matrix(t(dfdistri)) %*% dfxy[, yax]
    if(show.legend)
        
    if (nrow(dfxy) != nrow(dfdistri)) 
        stop(paste("Non equal row numbers", nrow(dfxy), nrow(dfdistri)))
    coo <- scatterutil.basemd(dfxy = dfxy, xax = xax, yax = yax, 
        xlim = xlim, ylim = ylim, grid = grid, addaxes = addaxes, 
        cgrid = cgrid, include.origin = include.origin, origin = origin, 
        sub = sub, csub = csub, possub = possub, pixmap = pixmap, 
        contour = contour, area = area, add.plot = add.plot,Labels=Labels)
    if (cpoint > 0) 
        for (i in 1:ncol(dfdistri)) {
            pch <- rep(pch, length = nrow(dfxy))
            points(coo$x[dfdistri[, i] > 0], coo$y[dfdistri[, 
                i] > 0], pch = pch[dfdistri[, i] > 0], cex = par("cex") * 
                cpoint, col = coul[i])
        }
    if (cstar > 0) 
        for (i in 1:ncol(dfdistri)) {
            scatterutil.star(coo$x, coo$y, dfdistri[, i], cstar = cstar, 
                coul[i])
        }
    if (cellipse > 0) 
        for (i in 1:ncol(dfdistri)) {
            scatterutil.ellipse(coo$x, coo$y, dfdistri[, i], 
                cellipse = cellipse, axesell = axesell, coul[i],elllwd=lwd)
        }
    if (clabel > 0) 
        scatterutil.eti(coox, cooy, label, clabel, coul = col)
    box()
    invisible(match.call())
}
