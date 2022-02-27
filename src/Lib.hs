module Lib where

import           Control.Monad                  ( when )
import           Data.Foldable                  ( foldl' )
import           System.IO                      ( hGetContents )
import           System.Process                 ( CreateProcess(std_out)
                                                , StdStream(CreatePipe)
                                                , createProcess
                                                , proc
                                                )

convert :: (String, [String]) -> String -> (String, [String])
convert (p, ss) s@('\t' : cs) = (p, (p ++ s) : ss)
convert (_, ss) s             = (takeWhile (/= ' ') s, s : ss)

run :: [String] -> IO ()
run args = do
  (_, Just hOut, _, _) <- createProcess (proc "ifconfig" args)
    { std_out = CreatePipe
    }
  contents <- hGetContents hOut
  (not . null) contents `when` putStr
    (unlines . reverse . snd . foldl' convert ("", []) $ lines contents)
