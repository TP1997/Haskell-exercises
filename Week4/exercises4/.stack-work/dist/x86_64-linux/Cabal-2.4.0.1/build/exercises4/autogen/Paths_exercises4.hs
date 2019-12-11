{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_exercises4 (
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

bindir     = "/home/tuoms/Haskell/Week4/exercises4/.stack-work/install/x86_64-linux/d0acc8ed17993e94ff7631ce97d2f61360673c8aea9efd62895be0fbd9ea5c44/8.6.5/bin"
libdir     = "/home/tuoms/Haskell/Week4/exercises4/.stack-work/install/x86_64-linux/d0acc8ed17993e94ff7631ce97d2f61360673c8aea9efd62895be0fbd9ea5c44/8.6.5/lib/x86_64-linux-ghc-8.6.5/exercises4-0.1.0.0-33hxK5hZT9eHsOFRBF9IXx-exercises4"
dynlibdir  = "/home/tuoms/Haskell/Week4/exercises4/.stack-work/install/x86_64-linux/d0acc8ed17993e94ff7631ce97d2f61360673c8aea9efd62895be0fbd9ea5c44/8.6.5/lib/x86_64-linux-ghc-8.6.5"
datadir    = "/home/tuoms/Haskell/Week4/exercises4/.stack-work/install/x86_64-linux/d0acc8ed17993e94ff7631ce97d2f61360673c8aea9efd62895be0fbd9ea5c44/8.6.5/share/x86_64-linux-ghc-8.6.5/exercises4-0.1.0.0"
libexecdir = "/home/tuoms/Haskell/Week4/exercises4/.stack-work/install/x86_64-linux/d0acc8ed17993e94ff7631ce97d2f61360673c8aea9efd62895be0fbd9ea5c44/8.6.5/libexec/x86_64-linux-ghc-8.6.5/exercises4-0.1.0.0"
sysconfdir = "/home/tuoms/Haskell/Week4/exercises4/.stack-work/install/x86_64-linux/d0acc8ed17993e94ff7631ce97d2f61360673c8aea9efd62895be0fbd9ea5c44/8.6.5/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "exercises4_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "exercises4_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "exercises4_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "exercises4_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "exercises4_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "exercises4_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
