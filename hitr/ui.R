shinyUI(pageWithSidebar(
    headerPanel("hitr: Exploring Offensive Drivers of Success in Baseball"),
    sidebarPanel(
        sliderInput("years", label = h3("Date Range"), format = "####",
                   min = 1879, max = 2013, value = c(1954, 2013)),
        radioButtons("outcome", label = h3("Outcome"),
             choices = list("Runs per Game" = "RpG",
                            "Winning Percentage" = "winPct"
                            ), selected = "RpG"),
        radioButtons("predictor", label = h3("Predictor"),
             choices = list("Batting Average" = "AVG",
                            "On-Base Percentage" = "OBP",
                            "Slugging Percentage" = "SLG",
                            "On-Base Plus Slugging" = "OPS",
                            "Hits per Game" = "HpG",
                            "Extra-Base Hits per Game" = "XBHpG",
                            "Home Runs per Game" = "HRpG",
                            "Stolen Bases per Game" = "SBpG",
                            "Basic Runs Created" = "BRC",
                            "Isolated Power" = "ISO",
                            "Power-Speed Number" = "PSN"
                            ), selected = "AVG"),
    width = 3),
    mainPanel(
        p("Welcome to hitr, a simple R-powered application that enables the user to examine relationships between various team batting statistics and indicators of baseball success (runs per game and winning percentage)."),
        p("To use, select a date range, outcome, and predictor from the menu on the left. The application will fit a simple linear regression model to the appropriate data, and display a plot of the data and the regression line, along with the corresponding adjusted R-squared value."),
        HTML("<p>Data is from the Lahman Baseball Database, available <a href = 'http://www.seanlahman.com/baseball-archive/statistics/'>here</a>.</p>"),
        br(),
        h3(textOutput('plotLabel'), align = 'center'),
        plotOutput('regPlot'),
        br(),
        p('Note: Sacrifice flies were not tracked prior to 1954. The team sacrifice flies variable is assigned a value of zero when calculating on-base percentage for pre-1954 seasons.')
    )
))
