module Paths_wai_app_static (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch

version :: Version
version = Version [3,1,1] []
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/tuoms/Haskell/multi/.stack-work/install/x86_64-linux/6d21714cdda7f1c2166da9ea95388bc39e4ed34717b60e2ba88f49d5c147d862/7.10.3/bin"
libdir     = "/home/tuoms/Haskell/multi/.stack-work/install/x86_64-linux/6d21714cdda7f1c2166da9ea95388bc39e4ed34717b60e2ba88f49d5c147d862/7.10.3/lib/x86_64-linux-ghc-7.10.3/wai-app-static-3.1.1-ChQFzXgpJuMJDXgZVwk6uM"
datadir    = "/home/tuoms/Haskell/multi/.stack-work/install/x86_64-linux/6d21714cdda7f1c2166da9ea95388bc39e4ed34717b60e2ba88f49d5c147d862/7.10.3/share/x86_64-linux-ghc-7.10.3/wai-app-static-3.1.1"
libexecdir = "/home/tuoms/Haskell/multi/.stack-work/install/x86_64-linux/6d21714cdda7f1c2166da9ea95388bc39e4ed34717b60e2ba88f49d5c147d862/7.10.3/libexec"
sysconfdir = "/home/tuoms/Haskell/multi/.stack-work/install/x86_64-linux/6d21714cdda7f1c2166da9ea95388bc39e4ed34717b60e2ba88f49d5c147d862/7.10.3/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "wai_app_static_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "wai_app_static_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "wai_app_static_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "wai_app_static_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "wai_app_static_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
