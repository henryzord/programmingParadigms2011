import Data.Char

type Bar = (String,Float)
type Point = (Float,Float)
type Number = (Int,Char)

{-
 -	funções que lidam com
 -	os números da barra.
-}

main = do 
		cod <- getLine
		startByNumbers (map digitToInt cod)

--função que cria toda a barra, a partir de 13 numeros.
startByNumbers :: [Int] -> IO()
startByNumbers [] = putStrLn("Lista vazia.")
startByNumbers list
	| validList list == False = putStrLn("Lista invalida.")
	| length list == 13 && last list == checkNumber (init list) = writeBar (generateBars (createNumberList list)) (generateText list)
	| otherwise = putStrLn("Lista invalida.")

--verifica se existe um número maior que 10 na lista
validList :: [Int] -> Bool
validList [] = True
validList (top:bottom)
	| top > 9 = False
	| otherwise = validList bottom

--adiciona o número verificador de uma lista
checkNumber :: [Int] -> Int
checkNumber [] = 0
checkNumber list = guessCheck (innerAddCheck list 0) 0

--recursão da addCheck
innerAddCheck :: [Int] -> Int -> Int
innerAddCheck [] iteration = 0
innerAddCheck (top:bottom) iteration
	| mod iteration 2 == 0 = (top * 1) + (innerAddCheck bottom (iteration+1))
	| otherwise = (top * 3) + (innerAddCheck bottom (iteration+1))

--descobre um número que somado 
--com sum e dividido por 10 dá 0. 
guessCheck :: Int -> Int -> Int
guessCheck sum iteration
	| mod (sum+iteration) 10 == 0 = iteration
	| otherwise = guessCheck sum (iteration+1)


--recebe os 13 int's e os cria a partir do tipo Number, que contém
--o número e a sua codificação ('A','B','C')
createNumberList :: [Int] -> [Number]
createNumberList [] = []
createNumberList (top:bottom) = (top,'0') : (innerNumberCreator ((leftHalfCodes top) ++ rightHalfCodes) bottom)

-- Recursão da createNumberList.
innerNumberCreator :: [Char] -> [Int] -> [Number]
innerNumberCreator codification [] = []
innerNumberCreator [] list = []
innerNumberCreator (top_char:bottom_char) (top_int:bottom_int) = (top_int,top_char) : innerNumberCreator bottom_char bottom_int

--codificação da segunda metade de números
--do código. É sempre C.
rightHalfCodes = ['C','C','C','C','C','C']

--Recebe o primeiro int da lista de números e dá a lista de
--codificações para os próximos 6 números
leftHalfCodes :: Int -> [Char]
leftHalfCodes number 
	| number == 0 = ['A','A','A','A','A','A']
	| number == 1 = ['A','A','B','A','B','B']
	| number == 2 = ['A','A','B','B','A','B']
	| number == 3 = ['A','A','B','B','B','A']
	| number == 4 = ['A','B','A','A','B','B']
	| number == 5 = ['A','B','B','A','A','B']
	| number == 6 = ['A','B','B','B','A','A']
	| number == 7 = ['A','B','A','B','A','B']
	| number == 8 = ['A','B','A','B','B','A']
	| number == 9 = ['A','B','B','A','B','A']

{-
 -	funções que lidam 
 -	com as barras verticais
 -}

--recebe a lista de 13 números com suas codificações
--e transforma em uma lista de barras.
generateBars :: [Number] -> [Bar]
generateBars [] = (setLength (addGuards "small") 25.40) ++ (setLength (addBlanks 7) 22.85)
generateBars list 
	| length list == 13 = (setLength (addBlanks 11) 22.85) ++ (setLength (addGuards "small") 25.40) ++ (setLength (addNumbers (head list)) 22.85) ++ generateBars (tail list)
	| length list == 6 = (setLength (addGuards "big") 25.40) ++ (setLength (addNumbers (head list)) 22.85) ++ generateBars (tail list)
	| otherwise = (setLength (addNumbers (head list)) 22.85) ++ generateBars (tail list)

--junta as strings de cores com o comprimento desejado.
setLength :: [String] -> Float -> [Bar]
setLength [] length = []
setLength (top:bottom) length = (top,length) : (setLength bottom length)

--adiciona espaços em branco (0's)
addBlanks :: Int -> [String]
addBlanks 0 = []
addBlanks blanks = "white" : addBlanks (blanks-1)

--adiciona as guardas (big para 01010, small para 101)
addGuards :: String -> [String]
addGuards size 
	| size == "big" = ["white","black","white","black","white"]
	| size == "small" = ["black","white","black"]
	| otherwise = []

--recebe o número e sua codificação, e devolve o seu conjunto de bits representado em strings.
addNumbers :: Number -> [String]
addNumbers (number,codification)
	| codification == 'A' = aCode number
	| codification == 'B' = bCode number
	| codification == 'C' = cCode number
	| otherwise = []

aCode :: Int -> [String]
aCode number 
	| number == 0 = ["white","white","white","black","black","white","black"]
	| number == 1 = ["white","white","black","black","white","white","black"]
	| number == 2 = ["white","white","black","white","white","black","black"]
	| number == 3 = ["white","black","black","black","black","white","black"]
	| number == 4 = ["white","black","white","white","white","black","black"]
	| number == 5 = ["white","black","black","white","white","white","black"]
	| number == 6 = ["white","black","white","black","black","black","black"]
	| number == 7 = ["white","black","black","black","white","black","black"]
	| number == 8 = ["white","black","black","white","black","black","black"]
	| number == 9 = ["white","white","white","black","white","black","black"]
	
bCode :: Int -> [String]
bCode number 
	| number == 0 = ["white","black","white","white","black","black","black"]
	| number == 1 = ["white","black","black","white","white","black","black"]
	| number == 2 = ["white","white","black","black","white","black","black"]
	| number == 3 = ["white","black","white","white","white","white","black"]
	| number == 4 = ["white","white","black","black","black","white","black"]
	| number == 5 = ["white","black","black","black","white","white","black"]
	| number == 6 = ["white","white","white","white","black","white","black"]
	| number == 7 = ["white","white","black","white","white","white","black"]
	| number == 8 = ["white","white","white","black","white","white","black"]
	| number == 9 = ["white","white","black","white","black","black","black"]

cCode :: Int -> [String]
cCode number 
	| number == 0 = ["black","black","black","white","white","black","white"]
	| number == 1 = ["black","black","white","white","black","black","white"]
	| number == 2 = ["black","black","white","black","black","white","white"]
	| number == 3 = ["black","white","white","white","white","black","white"]
	| number == 4 = ["black","white","black","black","black","white","white"]
	| number == 5 = ["black","white","white","black","black","black","white"]
	| number == 6 = ["black","white","black","white","white","white","white"]
	| number == 7 = ["black","white","white","white","black","white","white"]
	| number == 8 = ["black","white","white","black","white","white","white"]
	| number == 9 = ["black","black","black","white","black","white","white"]

{-
 -	funções que lidam 
 -	com arquivos e tags.
 -}

--escreve as cores [bar] para o arquivo
writeBar :: [Bar] -> String -> IO()
writeBar fullbar text = writeFile "codebar.svg" (generateSVG (generateFullbar fullbar) text)

--recebe todas as 113 barras e gera as cores para impressão
generateFullbar :: [Bar] -> String
generateFullbar [] = []
generateFullbar fullbar = innerFullbarGenerator fullbar 0

--recursão do generateFullbar.
innerFullbarGenerator :: [Bar] -> Float -> String
innerFullbarGenerator [] iteration = []
innerFullbarGenerator (top:bottom) iteration = (generateRectangle top (iteration * 0.33)) ++ " \n " ++ (innerFullbarGenerator bottom (iteration+1))

--cria tag de retângulo.
generateRectangle :: Bar -> Float -> String
generateRectangle (color,height) x = "<rect x=\""++show(x)++"\" y=\"0\" width=\"0.33\" height=\""++show(height)++"\" style=\"stroke-width:0;fill:"++color++"\"/>"

--pega a lista de números e converte para uma string
generateText :: [Int] -> String
generateText [] = []
generateText list = "<text x=\"1,6,8,10,12,14,16,21,23,25,27,29,31\" y=\"26\" font-size=\"4\" >" ++ concatList list ++ "</text>"

--concatena todos os números da lista em uma string
concatList :: [Int] -> String
concatList [] = []
concatList (top:bottom) = show top ++ concatList bottom

--gera a tag svg para comportar o objeto gráfico
generateSVG :: String -> String -> String
generateSVG object text = "<svg width=\"37.29mm\" height=\"25.93mm\" viewBox=\"0 0 37.29 25.93\" version=\"1.1\" xmlns=\"http://www.w3.org/2000/svg\">" ++ " \n " ++ object ++ text ++ "</svg>"


