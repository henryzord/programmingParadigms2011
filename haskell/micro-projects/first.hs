-- Calcula o quadrado de um numero
quadrado x = x*x

-- Soma 3 numeros inteiros
addThreeInt :: Int -> Int -> Int -> Int  
addThreeInt x y z = x + y + z

-- Soma 3 numeros de ponto flutuante
addThreeFloat :: Float -> Float -> Float -> Float
addThreeFloat x y z = x + y + z

-- Soma 3 numeros
-- Essa funcao usa o conceito de typeclass (classe de tipo) 
-- para funcionar com qualquer tipo numérico (Int, Float, etc.).
-- Veja mais sobre isso em http://learnyouahaskell.com/types-and-typeclasses#typeclasses-101
addThree :: (Num n) => n -> n -> n -> n
addThree x y z = x + y + z

-- Aumenta um numero se ele eh pequeno
superSizeMe :: (Ord n) => (Num n) => n -> n
superSizeMe x = if x < 100 
                  then x^2  
                  else x

-- Verifica se é par
par :: Int -> Bool 
par x = 
	if (mod x 2) == 0 
		then True
	else False 

--Soma os elementos de uma lista
somaElem :: [Int] -> Int
somaElem [] = 0
somaElem lis = head (lis) + somaElem(tail(lis)) 




