strlen' :: IO ()
strlen'= do putStr "Enter the username: "
            xs <- getLine
            putStrLn "the username is "
            putStr xs
            putStrLn " "
            putStr "you have 3 direction to walk: 1->left, 2->forward, 3->right "
            xs <- getLine
            putStrLn "1 has the giftbox to increase the blood; 2 has the giftbox to increase the speed and 3 have the  the giftbox to have the weapon"
            putStr xs