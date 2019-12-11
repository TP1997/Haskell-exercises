{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_Chap11 (
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

bindir     = "/home/tuoms/Haskell/Chap11/.stack-work/install/x86_64-linux/643fab73436ecb3a6b7e62a62e12efd4144f7dc113495e7d5cf52727ed385ccf/8.6.5/bin"
libdir     = "/home/tuoms/Haskell/Chap11/.stack-work/install/x86_64-linux/643fab73436ecb3a6b7e62a62e12efd4144f7dc113495e7d5cf52727ed385ccf/8.6.5/lib/x86_64-linux-ghc-8.6.5/Chap11-0.1.0.0-KqkvSxFB7ScuBcyZnIHTm-Chap11"
dynlibdir  = "/home/tuoms/Haskell/Chap11/.stack-work/install/x86_64-linux/643fab73436ecb3a6b7e62a62e12efd4144f7dc113495e7d5cf52727ed385ccf/8.6.5/lib/x86_64-linux-ghc-8.6.5"
datadir    = "/home/tuoms/Haskell/Chap11/.stack-work/install/x86_64-linux/643fab73436ecb3a6b7e62a62e12efd4144f7dc113495e7d5cf52727ed385ccf/8.6.5/share/x86_64-linux-ghc-8.6.5/Chap11-0.1.0.0"
libexecdir = "/home/tuoms/Haskell/Chap11/.stack-work/install/x86_64-linux/643fab73436ecb3a6b7e62a62e12efd4144f7dc113495e7d5cf52727ed385ccf/8.6.5/libexec/x86_64-linux-ghc-8.6.5/Chap11-0.1.0.0"
sysconfdir = "/home/tuoms/Haskell/Chap11/.stack-work/install/x86_64-linux/643fab73436ecb3a6b7e62a62e12efd4144f7dc113495e7d5cf52727ed385ccf/8.6.5/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "Chap11_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "Chap11_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "Chap11_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "Chap11_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "Chap11_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "Chap11_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
