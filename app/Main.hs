main :: IO ()
main = do
    input <- readFile "source.vml"
    case parse input of
        Left err -> putStrLn err
        Right ast -> print ast
