library(ggplot2)
teams <- read.csv("data/Teams.csv", na.strings = '')

teams[is.na(teams$SF),]$SF <- 0
teams[is.na(teams$HBP),]$HBP <- 0
teams$RpG <- teams$R / teams$G
teams$winPct <- teams$W / (teams$W + teams$L)
teams$AVG <- teams$H / teams$AB
teams$OBP <- (teams$H + teams$BB + teams$HBP) /
    (teams$AB + teams$BB + teams$HBP + teams$SF)
teams$TB <- teams$H + teams$X2B + 2 * teams$X3B + 3 * teams$HR
teams$TBpG <- teams$TB / teams$G
teams$SLG <- teams$TB / teams$AB
teams$OPS <- teams$OBP + teams$SLG
teams$HpG <- teams$H / teams$G
teams$XBHpG <- (teams$X2B + teams$X3B + teams$HR) / teams$G
teams$HRpG <- teams$HR / teams$G
teams$SBpG <- teams$SB / teams$G
teams$BRC <- ((teams$H + teams$BB) * teams$TB) / (teams$AB + teams$BB)
teams$ISO <- (teams$TB - teams$H) / teams$AB
teams$PSN <- 2 * teams$HR * teams$SB / (teams$HR + teams$SB)

shinyServer(
    function(input, output) {
        output$regPlot <- renderPlot({
            minYear <- {input$years[1]}
            maxYear <- {input$years[2]}
            teams_filtered <- teams[teams$yearID >= minYear & teams$yearID <= maxYear,]
            fit <- lm(teams_filtered[,{input$outcome}] ~ teams_filtered[,{input$predictor}])
            p <- ggplot(teams_filtered, aes_string(x = {input$predictor}, y = {input$outcome})) +
                geom_point(size = 3.5, color = 'steelblue', alpha = 0.5) +
                stat_smooth(method = 'lm', se = FALSE, color = 'orange', size = 1.5)
            print(p)
            plotLabel <- paste({input$predictor}, ' vs. ', {input$outcome},
                               ', ', minYear, '-', maxYear,
                               ': Adjusted R-squared = ',
                               round(summary(fit)$adj.r.squared, 3), sep = '')
            output$plotLabel <- renderText(plotLabel)
        })
    }
)
