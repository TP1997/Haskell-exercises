{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_exercies2 (
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

bindir     = "/home/tuoms/Haskell/Week2/exercies2/.stack-work/install/x86_64-linux/beb58ce6ddc05c358ec9862f7ff8689324c492acc743c02e4b801dde01502c6d/8.6.5/bin"
libdir     = "/home/tuoms/Haskell/Week2/exercies2/.stack-work/install/x86_64-linux/beb58ce6ddc05c358ec9862f7ff8689324c492acc743c02e4b801dde01502c6d/8.6.5/lib/x86_64-linux-ghc-8.6.5/exercies2-0.1.0.0-6Tl5RyCfwbeDBh3kNVAFp1-exercies2"
dynlibdir  = "/home/tuoms/Haskell/Week2/exercies2/.stack-work/install/x86_64-linux/beb58ce6ddc05c358ec9862f7ff8689324c492acc743c02e4b801dde01502c6d/8.6.5/lib/x86_64-linux-ghc-8.6.5"
datadir    = "/home/tuoms/Haskell/Week2/exercies2/.stack-work/install/x86_64-linux/beb58ce6ddc05c358ec9862f7ff8689324c492acc743c02e4b801dde01502c6d/8.6.5/share/x86_64-linux-ghc-8.6.5/exercies2-0.1.0.0"
libexecdir = "/home/tuoms/Haskell/Week2/exercies2/.stack-work/install/x86_64-linux/beb58ce6ddc05c358ec9862f7ff8689324c492acc743c02e4b801dde01502c6d/8.6.5/libexec/x86_64-linux-ghc-8.6.5/exercies2-0.1.0.0"
sysconfdir = "/home/tuoms/Haskell/Week2/exercies2/.stack-work/install/x86_64-linux/beb58ce6ddc05c358ec9862f7ff8689324c492acc743c02e4b801dde01502c6d/8.6.5/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "exercies2_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "exercies2_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "exercies2_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "exercies2_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "exercies2_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "exercies2_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
