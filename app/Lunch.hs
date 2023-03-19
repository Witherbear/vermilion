module Main where

import Options.Applicative

data Command = Install | Uninstall | Build | Info

installParser :: Parser Command
installParser = pure Install

uninstallParser :: Parser Command
uninstallParser = pure Uninstall

buildParser :: Parser Command
buildParser = pure Build

infoParser :: Parser Command
infoParser = pure Info

commandParser :: Parser Command
commandParser = subparser $
  command "install" (info installParser (progDesc "Install Vermilion packages with Lunch")) <>
  command "uninstall" (info uninstallParser (progDesc "Uninstall Vermilion packages with Lunch")) <>
  command "build" (info buildParser (progDesc "Build Vermilion projects with Lunch")) <>
  command "info" (info infoParser (progDesc "Info about Lunch tool"))

main :: IO ()
main = do
  command <- execParser (info (commandParser <**> helper) idm)
  putStrLn (case command of
    Install -> "Installing package ..."
    Uninstall -> "Uninstalling package ..."
    Build -> "Building project ..."
    Info -> "Lunch program version 1.0.0")
