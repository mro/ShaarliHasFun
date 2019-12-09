-- 
-- https://l.mro.name/o/p/a7u5g39/
-- http://intern.fh-wedel.de/~si/seminare/ss01/Ausarbeitung/6.cgi/haskell3.htm
-- 

module Lib
    ( helloWorld
    ) where

import System.IO (hSetEncoding, stdout, stderr, stdin, utf8)

setup io =
  hSetEncoding io utf8

helloWorld :: IO ()
helloWorld = do
  setup stdout
  setup stderr
  setup stdin
  putStrLn "Content-type: text/html; charset=utf-8"
  putStrLn ""
  putStrLn "<html>"
  putStrLn "<head><title>Hello, Worλd</title></head>"
  putStrLn "<body><h1>Hello, λλ=</h1></body>"
  putStrLn "</html>" 
