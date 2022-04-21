type Point     = (Int,Int)
type Circle    = (Point,Int)

writeSVG :: String -> String
writeSVG s = "<svg xmlns=\"http://www.w3.org/2000/svg\">\n" ++ s ++"</svg>"

writePoint :: Point -> String
writePoint (x,y) = (show x) ++ "," ++ (show y) ++ " "

writeCircle :: Circle -> String
writeCircle ((x,y),r) = "<circle cx=\"" ++ (show x) ++ "\" cy=\"" ++ (show y) ++ "\" r=\"" ++ (show r) ++ "\" stroke=\"black\" stroke-width=\"2\" fill=\"green\"/>\n"

main = do 
  writeFile "circle.svg" (writeSVG (writeCircle ((100,50),40)))

