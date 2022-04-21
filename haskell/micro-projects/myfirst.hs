import Data.Char

initMai (x : y) = toUpper x : y

headzero :: [Int] -> Bool
headzero []= False
headzero (x:y) = x == 0 

test1 :: Int -> Int -> Int
test1 a b
    | mod b 3 == 0 = a + b
    | mod b 5 == 0 = b - a
    |otherwise =  a

notaBoa :: Float -> Char
notaBoa a
	| (a >= 9.0) = 'A'
	| ((a >= 7.5) && (a < 9.0)) = 'B'
	| ((a >= 6.0) && (a < 7.5)) = 'C'
	| ((a >= 4.0) && (a < 6.0)) = 'D'
	| otherwise = 'E'

maiuscula1 :: [Char] -> [Char]
maiuscula1 lis = 
		if(lis == []) 
			then "Lista vazia";
		else toUpper (head lis) : tail lis

maiuscula2 :: [Char] -> [Char]
maiuscula2 [] = "Lista vazia"
maiuscula2 (x:y) = (toUpper(x) : y)

somatorio :: [Int] -> Int
somatorio [] = 0
somatorio (x:y) = x + somatorio(y)

tamanho :: [t] -> Int
tamanho []	= 0 
tamanho (x:y) = 1 + tamanho(y)

quadrados :: (Num n) => [n] -> [n]
quadrados [] = []
quadrados (topo:base) = topo * topo : quadrados(base)

--mapquadrados :: (Num n) => [n] -> [n]
--mapquadrados [] = []
--mapquadrados lista = map (lista * lista)
 
-- _ é qualquer coisa
-- "adivinhe" retorna o ultimo item da lista
-- tirar um espaço em branco à esquerda faz a identação ficar errada
adivinhe :: [a] -> a
adivinhe [x] = x 
adivinhe (_:xs) = adivinhe xs

--countChar :: Char -> [Char] -> Int
--countChar [] = 0
--countChar carater (topo:base)
	-- |carater == topo = ((countChar(carater base)) + 1)
	-- |otherwise = (countChar(carater base))


type Ponto = (Float,Float)
type Pessoa = (String, Int)

-- Funcao que verifica se a pessoa é maior de idade
maiorDeIdade :: (String,Int) -> Bool
maiorDeIdade (_,i) = 
	if i >= 18 
		then True 
	else False

maiorDeIdade1 :: Pessoa -> Bool
maiorDeIdade1 (_,i) = 
	if i >= 18 
		then True 
	else False

distPoint1 :: (Float,Float) -> (Float,Float) -> Float
distPoint1 (x1,y1) (x2, y2) =
	sqrt((x1-x2)^2+(y1-y2)^2)

distPoint2 :: (Float,Float) -> (Float,Float) -> Float
distPoint2 p1 p2 =
	sqrt((fst p1 - fst p2)^2 + (snd p1 - snd p2)^2)

distPoint3 :: Ponto -> Ponto -> Float
distPoint3 (x1,y1) (x2,y2) =
	sqrt((x1-x2)^2+(y1-y2)^2)

main =
	putStrLn "Ola Mundo"

test2 :: [a] -> [a]
test2 [] = []
test2 (_:[]) = []
test2 (top:bottom) = top : test2 bottom

test3 :: [Int] -> [Int]
test3 [] = []
test3 list = map (+100) (map (^2) list)

test4 :: Int -> [Int] -> [Int]
test4 _ [] = []
test4 x (top:bottom) 
	|x <= top = top : test4 x bottom
	|otherwise = x : test4 x bottom
