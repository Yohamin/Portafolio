import System.IO (writeFile)

-- Definimos el tipo Paciente con el nuevo campo nombre
data Paciente = Paciente {
    nombre :: String,     -- Nombre del paciente
    edad :: Int,
    sexo :: String,       -- Puede ser "M" o "F" para simplificar
    sintomas :: [String]  -- Lista de síntomas representada como cadenas
} deriving (Show)

-- Definimos el tipo Pacientes como una lista de Paciente
type Pacientes = [Paciente]

-- Lista de síntomas disponibles con sus números asociados
sintomasDisponibles :: [(Int, String)]
sintomasDisponibles = [
    (1, "fiebre"),
    (2, "dolor_muscular"),
    (3, "fatiga"),
    (4, "dolor_cabeza"),
    (5, "nauseas"),
    (6, "escalofrios"),
    (7, "sudoracion"),
    (8, "ulceras_piel"),
    (9, "perdida_peso")
    ]

-- Función para mostrar sintomas disponibles
mostrarSintomas :: IO ()
mostrarSintomas = do
    putStrLn "Síntomas disponibles:"
    mapM_ (\(n, s) -> putStrLn (show n ++ ". " ++ s)) sintomasDisponibles

-- Función para convertir números a síntomas
numerosASintomas :: [Int] -> [String]
numerosASintomas nums = [s | (n, s) <- sintomasDisponibles, n `elem` nums]

-- Función para crear un nuevo paciente
crearPaciente :: String -> Int -> String -> [String] -> Paciente
crearPaciente nombre edad sexo sintomas = Paciente { nombre = nombre, edad = edad, sexo = sexo, sintomas = sintomas }

-- Función para validar un paciente
validarPaciente :: Paciente -> Either String Paciente
validarPaciente paciente
    | null (nombre paciente) = Left "El nombre no puede estar vacío."
    | edad paciente < 0 = Left "La edad no puede ser negativa."
    | sexo paciente /= "m" && sexo paciente /= "f" = Left "El sexo debe ser 'm' o 'f'."
    | null (sintomas paciente) = Left "Debe haber al menos un síntoma."
    | otherwise = Right paciente

-- Función para guardar los datos de los pacientes válidos en un archivo
guardarPacientes :: Pacientes -> IO ()
guardarPacientes pacientes = do
    let datos = unlines ["Nombre: "++nombre paciente ++ ", Edad: " ++ show (edad paciente) ++ ", Sexo: " ++ sexo paciente ++ ", Sintomas: " ++ show (sintomas paciente) | paciente <- pacientes]
    writeFile "sintomas.txt" datos
    putStrLn "Datos de los pacientes guardados en sintomas.txt"

-- Filtrar solo los pacientes válidos
filtrarPacientesValidos :: Pacientes -> Pacientes
filtrarPacientesValidos pacientes = [paciente | paciente <- pacientes, isRight (validarPaciente paciente)]
  where
    isRight (Right _) = True
    isRight _ = False

-- Función para pedir y crear un paciente
pedirPaciente :: IO Paciente
pedirPaciente = do
    -- Pedir nombre
    putStrLn "Ingrese el nombre del paciente:"
    nombrePaciente <- getLine
    
    -- Pedir edad
    putStrLn "Ingrese la edad del paciente:"
    edadStr <- getLine
    let edadPaciente = read edadStr :: Int
    
    -- Pedir sexo
    putStrLn "Ingrese el sexo del paciente (M/F):"
    sexoPaciente <- getLine
    
    -- Mostrar y pedir síntomas
    mostrarSintomas
    putStrLn "Ingrese los números de los síntomas separados por comas (por ejemplo: 1,2,3):"
    sintomasNumsStr <- getLine
    let sintomasNums = map read (words [if c == ',' then ' ' else c | c <- sintomasNumsStr]) :: [Int]
    let sintomasPaciente = numerosASintomas sintomasNums
    
    -- Crear y devolver el paciente
    return $ crearPaciente nombrePaciente edadPaciente sexoPaciente sintomasPaciente

-- Función principal
main :: IO ()
main = do
    putStrLn "¿Cuántos pacientes desea ingresar?"
    numPacientesStr <- getLine
    let numPacientes = read numPacientesStr :: Int
    
    -- Obtener los pacientes uno por uno
    listaPacientes <- mapM (\_ -> pedirPaciente) [1..numPacientes]
    
    -- Filtrar pacientes válidos
    let pacientesValidos = filtrarPacientesValidos listaPacientes
    
    -- Guardar datos de pacientes válidos
    guardarPacientes pacientesValidos
    putStrLn "Pacientes guardados correctamente."
