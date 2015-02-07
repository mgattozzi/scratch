--Acts as a scratch pad for ideas to be referenced at any time
--from the command line
import System.Environment
import System.IO
import System.Directory
import Data.List
import Control.Exception

scratchpad = "/home/michael/.scratchpad"

--Parses input commands and runs the corresponding function
options :: String -> [String] -> IO ()
options "add" = add
options "remove" = remove
options "help" = help
options command = doesntExist command

--If the command is invalid this function is called to display an error
doesntExist :: String -> [String] -> IO ()
doesntExist command _ =
	putStrLn $ "The " ++ command ++ " command doesn't exist." ++ 
	"\nTo view a list of commands use the help command"

--Executes input commands or displays ideas
main=do
	args <- getArgs
	if(null args == False)
	then do
		let command = head args
		let	modargs = drop 1 args
		options command modargs
	else 
		view scratchpad

--Used to display ideas. Accessed by just calling the program name
view :: FilePath -> IO ()
view filename = do
		contents <- readFile filename
		let splitContents = lines contents
		let	numberedIdeas = zipWith (\n line -> show n ++ " - " ++ line) 
								[0..] splitContents
		mapM_ putStrLn numberedIdeas

--Add ideas to the file
add :: [String] -> IO ()
add [idea] = appendFile scratchpad (idea ++ "\n")
add _ = putStrLn "Add takes exactly two arguments"

--Remove ideas from the file
remove :: [String] -> IO ()
remove [numberString] = do
	putStrLn "Temporary"
remove _ = putStrLn "You need to provide a number to delete an idea"

--Displays different functions to the user
help _ = do
	let helpText = "Below are the commands you can use:\n" ++ "\tadd \"idea\" - Adds quoted text into the scratchpad\n" ++ "\tremove number - Removes the line number that the number value represents\n" ++ "\thelp - Outputs a list of commands scratch can use"
	putStrLn helpText
	
