{-# LANGUAGE OverloadedStrings #-}

module Main where

import Termonad (start)
import Termonad.Config
  ( CursorBlinkMode(CursorBlinkModeOff)
  , FontConfig
  , FontSize(FontSizePoints)
  , ShowScrollbar(ShowScrollbarNever)
  , TMConfig
  , confirmExit
  , cursorBlinkMode
  , defaultConfigOptions
  , defaultFontConfig
  , defaultTMConfig
  , fontConfig
  , fontFamily
  , fontSize
  , options
  , showMenu
  , showScrollbar
  )

fontConf :: FontConfig
fontConf =
  defaultFontConfig
    {fontSize = FontSizePoints 20, fontFamily = "Roboto Mono for Powerline"}

myTMConfig :: TMConfig
myTMConfig =
  defaultTMConfig
    { options =
        defaultConfigOptions
          { fontConfig = fontConf
          , showScrollbar = ShowScrollbarNever
          , confirmExit = False
          , showMenu = False
          , cursorBlinkMode = CursorBlinkModeOff
          }
    }

main :: IO ()
main = start myTMConfig
