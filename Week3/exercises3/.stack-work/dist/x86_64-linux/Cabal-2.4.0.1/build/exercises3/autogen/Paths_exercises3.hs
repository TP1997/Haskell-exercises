{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_exercises3 (
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

bindir     = "/home/tuoms/Haskell/Week3/exercises3/.stack-work/install/x86_64-linux/9def0f2ce18ca3303ccff52daa2717f8fc8e635661b9c3d751aae7dd6c7db805/8.6.5/bin"
libdir     = "/home/tuoms/Haskell/Week3/exercises3/.stack-work/install/x86_64-linux/9def0f2ce18ca3303ccff52daa2717f8fc8e635661b9c3d751aae7dd6c7db805/8.6.5/lib/x86_64-linux-ghc-8.6.5/exercises3-0.1.0.0-9xcePbrBaEOnetjwwmjna-exercises3"
dynlibdir  = "/home/tuoms/Haskell/Week3/exercises3/.stack-work/install/x86_64-linux/9def0f2ce18ca3303ccff52daa2717f8fc8e635661b9c3d751aae7dd6c7db805/8.6.5/lib/x86_64-linux-ghc-8.6.5"
datadir    = "/home/tuoms/Haskell/Week3/exercises3/.stack-work/install/x86_64-linux/9def0f2ce18ca3303ccff52daa2717f8fc8e635661b9c3d751aae7dd6c7db805/8.6.5/share/x86_64-linux-ghc-8.6.5/exercises3-0.1.0.0"
libexecdir = "/home/tuoms/Haskell/Week3/exercises3/.stack-work/install/x86_64-linux/9def0f2ce18ca3303ccff52daa2717f8fc8e635661b9c3d751aae7dd6c7db805/8.6.5/libexec/x86_64-linux-ghc-8.6.5/exercises3-0.1.0.0"
sysconfdir = "/home/tuoms/Haskell/Week3/exercises3/.stack-work/install/x86_64-linux/9def0f2ce18ca3303ccff52daa2717f8fc8e635661b9c3d751aae7dd6c7db805/8.6.5/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "exercises3_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "exercises3_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "exercises3_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "exercises3_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "exercises3_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "exercises3_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
