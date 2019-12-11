{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_arvioinnit (
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

bindir     = "/home/tuoms/Haskell/Week5/arvioinnit/.stack-work/install/x86_64-linux/643fab73436ecb3a6b7e62a62e12efd4144f7dc113495e7d5cf52727ed385ccf/8.6.5/bin"
libdir     = "/home/tuoms/Haskell/Week5/arvioinnit/.stack-work/install/x86_64-linux/643fab73436ecb3a6b7e62a62e12efd4144f7dc113495e7d5cf52727ed385ccf/8.6.5/lib/x86_64-linux-ghc-8.6.5/arvioinnit-0.1.0.0-BkPmkFqLca4Jhr4kxuUawi-arvioinnit"
dynlibdir  = "/home/tuoms/Haskell/Week5/arvioinnit/.stack-work/install/x86_64-linux/643fab73436ecb3a6b7e62a62e12efd4144f7dc113495e7d5cf52727ed385ccf/8.6.5/lib/x86_64-linux-ghc-8.6.5"
datadir    = "/home/tuoms/Haskell/Week5/arvioinnit/.stack-work/install/x86_64-linux/643fab73436ecb3a6b7e62a62e12efd4144f7dc113495e7d5cf52727ed385ccf/8.6.5/share/x86_64-linux-ghc-8.6.5/arvioinnit-0.1.0.0"
libexecdir = "/home/tuoms/Haskell/Week5/arvioinnit/.stack-work/install/x86_64-linux/643fab73436ecb3a6b7e62a62e12efd4144f7dc113495e7d5cf52727ed385ccf/8.6.5/libexec/x86_64-linux-ghc-8.6.5/arvioinnit-0.1.0.0"
sysconfdir = "/home/tuoms/Haskell/Week5/arvioinnit/.stack-work/install/x86_64-linux/643fab73436ecb3a6b7e62a62e12efd4144f7dc113495e7d5cf52727ed385ccf/8.6.5/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "arvioinnit_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "arvioinnit_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "arvioinnit_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "arvioinnit_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "arvioinnit_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "arvioinnit_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
