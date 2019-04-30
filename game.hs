nameInput = do
    foo <- putStrLn "hello, Whats your name?"
    name <- getLine
    putStrLn ("Hey " ++ name ++ ", You Suuuuck!!")
	