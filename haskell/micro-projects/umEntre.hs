umEntre :: Int -> Int -> [Int] -> Bool
umEntre _ _ [] = false
umEntre x y (top:bottom)
	|top == x 
