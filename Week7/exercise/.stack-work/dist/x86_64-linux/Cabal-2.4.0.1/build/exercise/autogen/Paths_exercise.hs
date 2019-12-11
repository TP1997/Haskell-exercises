{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_exercise (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/tuoms/Haskell/Week7/exercise/.stack-work/install/x86_64-linux/1f464b9aa55bbffac6864399e4b9314c6c1548094c0d12ad8dc5fae664f35cbd/8.6.5/bin"
libdir     = "/home/tuoms/Haskell/Week7/exercise/.stack-work/install/x86_64-linux/1f464b9aa55bbffac6864399e4b9314c6c1548094c0d12ad8dc5fae664f35cbd/8.6.5/lib/x86_64-linux-ghc-8.6.5/exercise-0.1.0.0-7qE9OkPMXrQ79udVEPRHOY-exercise"
dynlibdir  = "/home/tuoms/Haskell/Week7/exercise/.stack-work/install/x86_64-linux/1f464b9aa55bbffac6864399e4b9314c6c1548094c0d12ad8dc5fae664f35cbd/8.6.5/lib/x86_64-linux-ghc-8.6.5"
datadir    = "/home/tuoms/Haskell/Week7/exercise/.stack-work/install/x86_64-linux/1f464b9aa55bbffac6864399e4b9314c6c1548094c0d12ad8dc5fae664f35cbd/8.6.5/share/x86_64-linux-ghc-8.6.5/exercise-0.1.0.0"
libexecdir = "/home/tuoms/Haskell/Week7/exercise/.stack-work/install/x86_64-linux/1f464b9aa55bbffac6864399e4b9314c6c1548094c0d12ad8dc5fae664f35cbd/8.6.5/libexec/x86_64-linux-ghc-8.6.5/exercise-0.1.0.0"
sysconfdir = "/home/tuoms/Haskell/Week7/exercise/.stack-work/install/x86_64-linux/1f464b9aa55bbffac6864399e4b9314c6c1548094c0d12ad8dc5fae664f35cbd/8.6.5/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "exercise_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "exercise_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "exercise_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "exercise_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "exercise_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "exercise_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
