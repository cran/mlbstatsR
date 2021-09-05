## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(mlbstatsR)

## ----echo=FALSE---------------------------------------------------------------
library(mlbstatsR)
get_reference_players_mlb(1945,"batting", "value")

## ----echo=FALSE---------------------------------------------------------------
library(mlbstatsR)
get_reference_players_mlb(1965,"pitching", "ratio")

## ----echo=FALSE---------------------------------------------------------------
library(mlbstatsR)
get_reference_players_mlb(2002,"fielding", "appearances")

## ----echo=FALSE---------------------------------------------------------------
library(mlbstatsR)
get_reference_team_mlb(2021,"batting", "advanced")


## ----echo=FALSE---------------------------------------------------------------
library(mlbstatsR)
get_reference_team_mlb(1980,"pitching", "battingagainst")


## ----echo=FALSE---------------------------------------------------------------
library(mlbstatsR)
get_reference_team_mlb(1980,"fielding", "centerfield")


## ----echo=FALSE---------------------------------------------------------------
library(mlbstatsR)
get_reference_team_standings(1999)


## ----echo=FALSE---------------------------------------------------------------
library(mlbstatsR)
 espn_player_stats(2015, "pitching", "regular")

## ----echo=FALSE---------------------------------------------------------------
library(mlbstatsR)
espn_player_stats(2004, "batting", "playoffs")

## ----echo=FALSE---------------------------------------------------------------
library(mlbstatsR)
 espn_team_stats(2021, "fielding", "regular")

## ----echo=FALSE---------------------------------------------------------------
library(mlbstatsR)
espn_team_stats(2011, "fielding", "playoffs")

