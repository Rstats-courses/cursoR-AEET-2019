

## ----echo=TRUE, cache=FALSE----------------------------------------------
library(ggplot2)
ggplot(trees)


## ----eval=FALSE, echo=TRUE-----------------------------------------------
## ggplot(trees)


## ----echo=TRUE-----------------------------------------------------------
ggplot(trees) +
  aes(x = dbh, y = height)


## ----echo=TRUE, eval=FALSE-----------------------------------------------
## ggplot(trees) +
##   aes(x = dbh, y = height)


## ----out.width="4in", out.height="3in"-----------------------------------
include_graphics("images/aesthetics_Wilke.png")


## ----echo=TRUE, eval=TRUE------------------------------------------------
ggplot(trees) +
  aes(x = dbh, y = height) +
  geom_point()


## ----echo=TRUE-----------------------------------------------------------
ggplot(trees) +
  aes(x = dbh, y = height) +
  geom_point(size = 2)


## ----echo=TRUE-----------------------------------------------------------
ggplot(trees) +
  aes(x = dbh, y = height) +
  geom_point(size = 2, shape = 18)


## ----echo=TRUE-----------------------------------------------------------
ggplot(trees) +
  aes(x = dbh, y = height) +
  geom_point(size = 2, shape = 18, colour = 'blue')


## ----echo=TRUE, fig.width=5----------------------------------------------
ggplot(trees) +
  aes(x = dbh, y = height) +
  geom_point(aes(colour = sex))


## ----eval=FALSE, echo=TRUE-----------------------------------------------
## geom_point(colour = "blue")
## # colour is given a concrete value ('blue')


## ----eval=FALSE, echo=TRUE-----------------------------------------------
## geom_point(aes(colour = sex))
## # colour maps a *variable* (using `aes`)


## ----echo=TRUE-----------------------------------------------------------
ggplot(trees) +
  aes(x = dbh, y = height) +
  geom_point(aes(colour = sex))


## ----echo=TRUE, eval=FALSE-----------------------------------------------
## ggplot(trees) +
##   aes(x = dbh, y = height) +
##   geom_point(colour = sex)


## ----echo=TRUE, fig.width=5----------------------------------------------
ggplot(trees) +
  aes(x = dbh, y = height) +
  geom_point(aes(colour = sex, shape = sex))


## ----echo=TRUE-----------------------------------------------------------
ggplot(trees) +
  aes(x = dbh, y = height) +
  geom_point(aes(colour = plot, shape = sex))


## ----echo=TRUE-----------------------------------------------------------
trees$plot <- as.factor(trees$plot)


## ----echo=TRUE, fig.width=5----------------------------------------------
ggplot(trees) +
  aes(x = dbh, y = height) +
  geom_point(aes(colour = plot, shape = sex))


## ----echo=TRUE, fig.width=5----------------------------------------------
ggplot(trees) +
  aes(x = dbh, y = height) +
  geom_point(aes(colour = sex)) +
  scale_colour_manual(values = c("orange", "blue"))


## ----echo=TRUE-----------------------------------------------------------
ggplot(trees) +
  aes(x = dbh, y = height) +
  geom_point() +
  labs(x = "Diameter at Breast Height (cm)", y = "Height (m)")


## ----echo=TRUE, fig.width=5----------------------------------------------
ggplot(trees) +
  aes(x = dbh, y = height) +
  geom_point(aes(colour = sex)) +
  labs(x = "Diameter at Breast Height (cm)", y = "Height (m)") +
  labs(title = "Tree allometry")


## ----echo=TRUE, fig.width=5----------------------------------------------
ggplot(trees) +
  aes(x = dbh, y = height) +
  geom_point() +
  geom_smooth(method = "lm")


## ----echo=TRUE, fig.width=5----------------------------------------------
ggplot(trees) +
  aes(x = dbh, y = height) +
  geom_point() +
  geom_smooth(method = "lm") +
  geom_vline(xintercept = c(10, 20, 30, 40, 50))


## ----echo=TRUE, fig.width=5----------------------------------------------
ggplot(trees) +
  aes(x = dbh, y = height) +
  geom_point() +
  geom_smooth(method = "lm") +
  geom_vline(xintercept = c(10, 20, 30, 40, 50)) +
  geom_hline(yintercept = c(20, 30, 40, 50))


## ----eval=FALSE, echo=TRUE-----------------------------------------------
## ggplot(trees) +                 # Name of (tidy) data frame
##   aes(x = dbh, y = height) +    # Aesthetics (variables to map in axes)
##   geom_point()                  # Geoms: geometric objects


## ----fig.width=5---------------------------------------------------------
ggplot(trees) +
  aes(x = plot, y = height) +
  geom_boxplot() +
  labs(x = "Study plot", y = "Height (m)") +
  labs(title = "Tree heights per plot")


## ----fig.width=5---------------------------------------------------------
ggplot(trees) +
  aes(x = plot, y = height) +
  geom_violin() +
  labs(x = "Study plot", y = "Height (m)") +
  labs(title = "Tree heights per plot") +
  geom_point()


## ----fig.width=5---------------------------------------------------------
ggplot(trees) +
  aes(x = height) +
  geom_density(aes(colour = sex, fill = sex), alpha = 0.5) +
  labs(x = "Height (m)", title = "Distribution of heights")


## ----fig.width=5---------------------------------------------------------
ggplot(trees) +
  aes(x = dbh) +
  geom_density(aes(colour = sex, fill = sex), alpha = 0.5) +
  labs(x = "DBH (cm)", title = "Distribution of diameters")


## ----fig.width=5---------------------------------------------------------
ggplot(trees) +
  aes(x = dbh, y = height, colour = sex) +
  geom_point() +
  geom_smooth(method = "lm")


## ----fig.width=5---------------------------------------------------------
ggplot(trees) +
  aes(x = dbh, y = height) +
  geom_point() +
  geom_smooth(aes(colour = sex), method = "lm")


## ----echo=TRUE-----------------------------------------------------------
myplot <- ggplot(trees) +
  aes(x = dbh, y = height)
myplot + geom_point()


## ----echo=TRUE-----------------------------------------------------------
myplot <- ggplot(trees) +
  aes(x = dbh, y = height)
myplot <- myplot + geom_point()
myplot


## ----echo=TRUE-----------------------------------------------------------
baseplot <- ggplot(trees) +
  aes(x = dbh, y = height)
scatterplot <- baseplot + geom_point()
labelled <- scatterplot + labs(x = "DBH (cm)", y = "Height (m)")
labelled


## ----echo=1--------------------------------------------------------------
myplot <- ggplot(trees) +
  aes(x = dbh, y = height) +
  geom_point()
myplot


## ----echo=TRUE-----------------------------------------------------------
myplot + theme_classic()


## ----echo=TRUE-----------------------------------------------------------
myplot + theme_minimal()


## ----echo=TRUE-----------------------------------------------------------
library(ggthemes)
myplot + theme_economist()


## ----echo=TRUE-----------------------------------------------------------
myplot + theme_wsj()


## ----echo=TRUE, eval=FALSE-----------------------------------------------
## ?theme


## ----fig.width=5---------------------------------------------------------
ggplot(trees) +
  aes(x = dbh, y = height, colour = sex) +
  geom_point() +
  labs(x = "DBH (cm)", y = "Height (m)") +
  labs(title = "Changing plot appearance") +
  theme(axis.title.x = element_text(colour = "blue"),
        axis.title.y = element_text(colour = "red"),
        plot.title = element_text(size = 16),
        legend.key = element_rect(fill = "white"),
        legend.position = "bottom"
        )


## ------------------------------------------------------------------------
myplot


## ------------------------------------------------------------------------
myplot


## ----out.height="3in", out.width="4in"-----------------------------------
include_graphics("images/trevor_tweet.png")


## ----echo=TRUE-----------------------------------------------------------
myplot +
  theme(axis.title = element_text(size = 18))


## ----echo=TRUE-----------------------------------------------------------
library(cowplot)
myplot


## ----echo=TRUE, out.width='4in', out.height='3in'------------------------
library(cowplot)
plot1 <- ggplot(trees) + aes(dbh, height) + geom_point()
plot2 <- ggplot(trees) + aes(factor(plot), height) + geom_boxplot()
plot_grid(plot1, plot2, labels = "AUTO")


## ----echo=3, out.width='3in', out.height='5in'---------------------------
plot1 <- ggplot(trees) + aes(dbh, height) + geom_point()
plot2 <- ggplot(trees) + aes(factor(plot), height) + geom_boxplot()
plot_grid(plot1, plot2, labels = "AUTO", ncol = 1)


## ------------------------------------------------------------------------
include_graphics("images/patchwork.PNG")


## ------------------------------------------------------------------------
include_graphics("images/egg.png")


## ----echo=TRUE, eval=FALSE-----------------------------------------------
## ggsave("myplot.pdf")


## ----echo=TRUE, eval=FALSE-----------------------------------------------
## save_plot("myplot.pdf")


## ----echo=TRUE, fig.width=5, fig.height=3--------------------------------
ggplot(trees) + aes(dbh, height) +
  geom_point() + theme_minimal(base_size = 8) +
  facet_wrap(~plot)


## ----echo=TRUE, fig.width=5, fig.height=3--------------------------------
ggplot(trees) +
  geom_histogram(aes(height)) + theme_minimal(base_size = 8) +
  facet_wrap(~plot, nrow = 2)


## ----echo=TRUE, eval=FALSE-----------------------------------------------
## library(plotly)
## myplot <- ggplot(trees) +
##   aes(x = dbh, y = height) +
##   geom_point()
## ggplotly(myplot)


## ------------------------------------------------------------------------
include_graphics("images/ggrepel.png")


## ------------------------------------------------------------------------
include_graphics("images/ggexts.PNG")


## ------------------------------------------------------------------------
ggplot(trees) +
  aes(sex, height) +
  geom_violin()


## ----fig.height=4, fig.width=5-------------------------------------------
ggplot(trees) +
  aes(dbh, height) +
  geom_point() +
  geom_smooth() +
  theme_minimal(base_size = 8) +
  facet_wrap(~sex, nrow = 2) +
  labs(x = "DBH (cm)", y = "Height (m)",
       title = "Tree allometry")


## ----fig.height=4, fig.width=5-------------------------------------------
ggplot(trees) +
  aes(dbh, height) +
  geom_point(aes(colour = sex)) +
  geom_smooth(aes(colour = sex)) +
  theme_minimal(base_size = 12) +
  labs(x = "DBH (cm)", y = "Height (m)",
       title = "Tree allometry")


## ----out.height="3.5in"--------------------------------------------------
ggplot(trees) +
  geom_histogram(aes(height)) +
  facet_wrap(~sex, nrow = 2) +
  labs(x = "Height (m)", y = "Number of trees",
       title = "Tree allometry") +
  theme(plot.title = element_text(hjust = 0.5))


## ----include=FALSE, eval=FALSE-------------------------------------------
## library(rotl)
## library(ggtree)
## lauraceae <- tnrs_match_names(c("Quercus suber", "Quercus ilex", "Pinus pinea", "Laurus nobilis"))
## lautree <- tol_induced_subtree(ott_ids = unlist(ott_id(lauraceae)))
## ggtree(lautree) + geom_tiplab()


## ----fig.height=4, fig.width=5-------------------------------------------
ggplot(trees) +
  geom_histogram(aes(height, group = sex, fill = sex)) +
  theme_minimal(base_size = 8) +
  facet_wrap(~plot) +
  labs(x = "Height (m)", y = "Number of trees") +
  labs(title = "Distribution of heights by sex and plot")


## ----cache=TRUE, fig.width=6---------------------------------------------
hansen <- read.table("http://www.columbia.edu/~mhs119/Sensitivity+SL+CO2/Table.txt",
                     header = FALSE, dec = ".", nrows = 17604, skip = 9)
hansen <- hansen[, c(3,6)]
names(hansen) <- c("MyrBP", "Tabs")
hansen$logtime <- log10(hansen$MyrBP)


timebreaks <- c(0.001, 0.01, 0.1, 1, 10, 66)  # in MyrBP
timebreaks.log <- log10(timebreaks)
time.labels <- latex2exp::TeX(c("10^{-3}", "10^{-2}",
                  "10^{-1}", "1", "10", "66"))

temp <- ggplot(hansen, aes(x = logtime, y = Tabs)) +
  ylim(9, 30) +
  labs(x = "Millions of years BP", y = "Temperature (ºC)") +
  theme(axis.text.x = element_text(size = 10)) +
  geom_line(colour = "Dark Red") +
  scale_x_continuous(breaks = timebreaks.log,
                     labels = time.labels,
                     trans = "reverse")


epochs.start <- c(0.0117, 2.58, 5.333, 23.03, 33.9, 56, 66)  # from geoscale

temp.paleo <- temp +
  geom_vline(xintercept = log10(epochs.start), linetype = "dashed", size = 0.2) +
  annotate("text", label = c("P", "Eo", "Ol", "Mi", "Pli", "Ple", "Hol"),
            x = c(1.78, 1.63, 1.44, 1.07, 0.58, -0.7, -2.9),
           y = 30, size = 3)
temp.paleo


## ----out.width="2in", out.height="3in"-----------------------------------
include_graphics("images/christmas_tree.png")

