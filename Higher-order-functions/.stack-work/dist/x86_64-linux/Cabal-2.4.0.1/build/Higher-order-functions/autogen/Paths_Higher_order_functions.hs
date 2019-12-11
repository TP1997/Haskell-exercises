{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_Higher_order_functions (
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

bindir     = "/home/tuoms/Haskell/Higher-order-functions/.stack-work/install/x86_64-linux/beb58ce6ddc05c358ec9862f7ff8689324c492acc743c02e4b801dde01502c6d/8.6.5/bin"
libdir     = "/home/tuoms/Haskell/Higher-order-functions/.stack-work/install/x86_64-linux/beb58ce6ddc05c358ec9862f7ff8689324c492acc743c02e4b801dde01502c6d/8.6.5/lib/x86_64-linux-ghc-8.6.5/Higher-order-functions-0.1.0.0-BkV1Uk5pCiCCZZA58HABXf-Higher-order-functions"
dynlibdir  = "/home/tuoms/Haskell/Higher-order-functions/.stack-work/install/x86_64-linux/beb58ce6ddc05c358ec9862f7ff8689324c492acc743c02e4b801dde01502c6d/8.6.5/lib/x86_64-linux-ghc-8.6.5"
datadir    = "/home/tuoms/Haskell/Higher-order-functions/.stack-work/install/x86_64-linux/beb58ce6ddc05c358ec9862f7ff8689324c492acc743c02e4b801dde01502c6d/8.6.5/share/x86_64-linux-ghc-8.6.5/Higher-order-functions-0.1.0.0"
libexecdir = "/home/tuoms/Haskell/Higher-order-functions/.stack-work/install/x86_64-linux/beb58ce6ddc05c358ec9862f7ff8689324c492acc743c02e4b801dde01502c6d/8.6.5/libexec/x86_64-linux-ghc-8.6.5/Higher-order-functions-0.1.0.0"
sysconfdir = "/home/tuoms/Haskell/Higher-order-functions/.stack-work/install/x86_64-linux/beb58ce6ddc05c358ec9862f7ff8689324c492acc743c02e4b801dde01502c6d/8.6.5/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "Higher_order_functions_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "Higher_order_functions_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "Higher_order_functions_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "Higher_order_functions_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "Higher_order_functions_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "Higher_order_functions_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
