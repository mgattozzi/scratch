--Acts as a scratch pad for ideas to be referenced at any time
--from the command line
import System.Environment
import System.IO
import Data.List

main=do
	contents <- readFile "/home/michael/.scratchpad"
	args <- getArgs
	if (null args)
	then putStr contents
	else
		putStr "Test complete"
