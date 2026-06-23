

#include <MsgBoxConstants.au3>
#include <Clipboard.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <Array.au3>
#include <FileConstants.au3>

Global $detectaCliente = -1
;=========================================  para el historico
Global $sLogFile = @ScriptDir & "\historico_log.txt"  ; Archivo donde se guardará el histórico
Global $gMainCounter = 0  ; Contador de ejecuciones principales
Global $startTime = TimerInit()  ; Inicio del tiempo de ejecución
Global $totalIncidencias = 0
Global $paginasPorProcesar = 0
Global $aArray[0]  ; Inicializamos un array vacío para almacenar datos
;=========================================
;VARIBLES GLOBALES click seguro
Global $g_LastClickX = -1
Global $g_LastClickY = -1
Global $g_LastClickButton = "left"
Global $g_LastClickCount = 1
Global $g_RepetirClickPendiente = False

 ; Vigilante cada 500 ms (medio segundo)
;AdlibRegister("VigilarVentanaAliquo", 400)

HotKeySet("{ESC}", "Salir") ; Asignar la tecla ESC para salir
Local $parar = False
MostrarVerificacionPantalla("C:\Users\C:\Ruta\Proyecto\img_ini.jpg")

;=========================================
; Guardar inicio de ejecución en el histórico
GuardarHistorico("INICIO", "El script ha comenzado la ejecución.")
;=========================================

While true
    If $parar Then ExitLoop

    $gMainCounter += 1  ; Incrementar contador de ejecuciones
    ConsoleWrite("Ejecución principal número: " & $gMainCounter & @CRLF)

    ;=========================================
    ; Si el usuario presiona ESC, salir del bucle y registrar en el histórico
    If $parar Then
        GuardarHistorico("TERMINADO", "El usuario detuvo el script manualmente.")
        ExitLoop
    EndIf
    ;=========================================

    ; Abrir Microsoft Edge con la URL específica
    Run('C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe "URL_NEOCASE"', "", @SW_MAXIMIZE)
    $timeout= 10
    Sleep(2500)
    If WinWait("Neocase ", "", $timeout) Then
        ; Especificar las coordenadas absolutas del campo de entrada
        Local $x = 901  ; Coordenada X
        Local $y = 472  ; Coordenada Y

        ; Mover el ratón a la posición especificada
        MouseMove($x, $y, 10) ; (10 es la velocidad del movimiento, ajustable)

        ; Realizar un doble clic en la posición
        MouseClick("left", $x, $y, 2) ; "2" indica doble clic

        Sleep(1000)
        ; Escribir "HTB"
        Send("xxx")

        ; Especificar las coordenadas absolutas del campo de HTB
        Local $x = 901  ; Coordenada X
        Local $y = 517  ; Coordenada Y

        ; Mover el ratón a la posición especificada
        MouseMove($x, $y, 10) ; (10 es la velocidad del movimiento, ajustable)

        ; Realizar un doble clic en la posición
        MouseClick("left", $x, $y, 2) ; "2" indica doble clic

        ; Escribir "HTB"
        Send("xxx")

        ; Especificar las coordenadas absolutas del campo de entrada
        Local $x = 1188  ; Coordenada X
        Local $y = 612  ; Coordenada Y

        ; Mover el ratón a la posición especificada
        MouseMove($x, $y, 10) ; (10 es la velocidad del movimiento, ajustable)

        ; Realizar un doble clic en la posición
        MouseClick("left", $x, $y, 1) ; "1" indica doble clic

        Sleep(5900)

; Coordenadas fijas de búsqueda
Local $x = 27
Local $yInicio = 260
Local $yFin = 411
Local $colorBuscado = 0xD9834C

; Buscar el color y hacer doble clic si se encuentra
If Not BuscarColorVerticalYClick($x, $yInicio, $yFin, $colorBuscado) Then
    MsgBox(48, "Aviso", "No se encontró el color buscado en la zona especificada.")
EndIf


        Sleep(5000)
        compruebaPortapapeles()

        ; Especificar las coordenadas absolutas del campo de entrada
        Local $x = 1406  ; Coordenada X DEL DESPLEGABLE DE ALIQUO
        Local $y = 256  ; Coordenada Y

        ; Mover el ratón a la posición especificada
        MouseMove($x, $y, 10) ; (10 es la velocidad del movimiento, ajustable)
        Sleep(800)
        ; Realizar un doble clic en la posición
        MouseClick("left", $x, $y,1) ;

        ; Especificar las coordenadas absolutas del campo de entrada
        Local $x = 1166  ; Coordenada X
        Local $y = 371  ; Coordenada Y

        ; Mover el ratón a la posición especificada
        MouseMove($x, $y, 10) ; (10 es la velocidad del movimiento, ajustable)

        Sleep(1200)
        ; Realizar un doble clic en la posición
        MouseClick("left", $x, $y,1) ;
        Sleep(100)

        ;REPITE PINCHAR EN EL DESPLEGABLE POR SI ACASO
        MouseClick("left", 1406, 256,1)
        Sleep(200)
        MouseClick("left", 1166, 371,1)

        Sleep(2000)
        ;cuantas incidencias, en cuantas paginas

        compruebaIncidencias()

        ; Especificar las coordenadas absolutas del campo de entrada
        Local $x = 226  ; Coordenada X
        Local $y = 1008  ; Coordenada Y

        ; Mover el ratón a la posición especificada
        MouseMove($x, $y, 10) ; (10 es la velocidad del movimiento, ajustable)
        Sleep(2000)

        ; Realizar un doble clic en la posición
        MouseClick("left", $x, $y,3) ;
        Sleep(100)
        ; Simula Ctrl+C para copiar al portapapeles
        Send("^c")
        Sleep(100)
        ; Obtener el texto copiado del portapapeles
        Local $textoCopiado = ClipGet()

        ; Esperar un momento para asegurarse de que se copió correctamente
        Sleep(100)

        ; Cadena de ejemplo
        Local $cadena = $textoCopiado

        ; Expresión regular para extraer incidencias y páginas
        Local $aMatches = StringRegExp($cadena, "(\d+)\s+incidencia\(s\).*Página\s*:\s*\d+\s+en\s+(\d+)", 3)
        Global $paginasPorProcesar = 0;
        ; Verificar si se encontraron coincidencias
        If UBound($aMatches) > 1 Then
            Local $totalIncidencias = $aMatches[0]
            $paginasPorProcesar = $aMatches[1]

            ; Mostrar resultados
            ConsoleWrite("Número total de incidencias: " & $totalIncidencias & @CRLF)
            ConsoleWrite("Número total de páginas: " & $paginasPorProcesar & @CRLF)
        Else
            ConsoleWrite("No se encontraron coincidencias.")
        EndIf

        Run("C:\Program Files (x86)\Aliquo Software 5\Aliquo.exe")
        Sleep(8000)
        MouseMove(357,1020, 10)
        EsperarColor(357, 1020, 0x5CA000)

        ; Especificar las coordenadas absolutas del campo de entrada
        Local $x = 150  ; Coordenada X
        Local $y = 108  ; Coordenada Y

        ; vamos a sección MENU en aliquo y hacemos click
        MouseMove(30, 35, 10) ; (10 es la velocidad del movimiento, ajustable)
        Sleep(400)
        MouseClick("left", 30, 35,1) ;
        Sleep(1500)

        ; vamos a sección PRICIPAL de trabajo en aliquo y hacemos click
        MouseMove(46, 90, 10) ;
        Sleep(450)
        MouseClick("left", 46, 90,1) ;
        Sleep(1500)

        ;PINCHAMOS EN SERVICIOS Y EN PARTES DE TRABAJAO
        MouseMove(247, 221, 10) ;
        Sleep(450)
        MouseClick("left", 247, 221,1) ;
        Sleep(500)
        MouseMove(458, 121, 10) ;
        Sleep(450)
        MouseClick("left", 458, 121,1) ;

        Local $x = 25  ; Coordenada X
        Local $y = 212  ; Coordenada Y
        MouseMove($x, $y, 10) ; (10 es la velocidad del movimiento, ajustable)
        EsperarColor(406, 209, 0xFBF4E7)
        Sleep(800)
        ; Realizar un doble clic en la posición
        MouseClick("left", $x, $y,1) ;
        Sleep(1250)
        ; Presionar la tecla "Suprimir" (Delete) --borramos filtro en aliquo

        Sleep(700)
        Send("{DEL}")
        Sleep(700)
        MouseClick("left", 245, 214,1) ;
        Sleep(200)

        ; Especificar las coordenadas absolutas del campo de entrada
        Local $x = 916  ; Coordenada X
        Local $y = 10  ; Coordenada Y

        ; Mover el ratón a la posición especificada
        ; Mover Aliquo a la pantalla izquierda
        MouseMove($x, $y, 10) ; (10 es la velocidad del movimiento, ajustable)
        Sleep(500)
        MouseDown("left")  ; Mantiene el clic izquierdo
        MouseMove(13, 417, 10) ; (10 es la velocidad del movimiento, ajustable) mueve aliquo a la pantalla izq
        Sleep(500)
        MouseUp("left")    ; Suelta el clic izquierdo
        Sleep(700)

        ; Comprobar color en posición 691, 75
        If PixelGetColor(691, 75) = 0xE2AE36 Then
            ; Color correcto, continuar
            ConsoleWrite("? Aliquo reposicionado correctamente." & @CRLF)
        Else
            ; Mostrar texto a pantalla completa y volver a intentar
            SplashTextOn("HTB SISTEMAS S.L.", "Aliquo Software", @DesktopWidth, @DesktopHeight, -1, -1, 1, "Arial", 48)
            Sleep(3000)
            SplashOff()
            ; Reintentar mover la ventana
            MouseMove($x, $y, 10)
            Sleep(500)
            MouseDown("left")
            MouseMove(13, 417, 10)
            Sleep(500)
            MouseUp("left")
            Sleep(700)
        EndIf

        MouseMove(1194, 246, 10) ; (10 es la velocidad del movimiento, ajustable) mueva para pinchar en la ventana de neocase
        MouseClick("left", 1194, 246, 1) ; "2" indica doble clic
        EsperarColor(994, 182, 0xD9834C)

        ;Local $paginasPorProcesar = 2;
        Global $incidencias[0]
        Global $casosCreados[0]

        Global $x1 = 1217  ; Coordenada X empezar en neocase
        Global $y1 = 366  ; Coordenada Y empezar en neocase
        ;HayQueProcesar($x1,$y1)

        ;vamos a iterar el metodo HayQueProcesar para que vaya comprobando
        for $i=0 To ($totalIncidencias -1)

            If Mod($i - 25, 50) = 0 Then
                Bajar() ; Llama a la función Baja, para que cada 25, 75, 125 haga scroll down
            EndIf

            Sleep(100)
            $proximoNum = ObtenerProximoNumero()
            ConsoleWrite("obtengo el proximo número " & $proximoNum & " para la iteración "&$i& @CRLF)

            Sleep(222)

            If $proximoNum <> "" Then
                HayQueComprobar()
                if $i == 49 And $paginasPorProcesar > 1 then
                    $paginasPorProcesar = $paginasPorProcesar - 1
                    $i=0
                    PasarPagina()
                EndIf
            Else
                ConsoleWrite("No hay numeros a procesar o el último fue el que se procesó.")
                ExitLoop
            EndIf
        Next

        Local $cadenaNumeros = _ArrayToString($casosCreados, ",")

        ;=============================================================================
        ;====================================================
        ; Calcular tiempo total de ejecución
        Local $elapsedTime = Round(TimerDiff($startTime) / 1000, 2)  ; Tiempo en segundos
        Local $minutos = Int($elapsedTime / 60)  ; Obtener los minutos
        Local $segundos = Mod($elapsedTime, 60)  ; Obtener los segundos

        ; Guardar finalización de la ejecución en el histórico con tiempo formateado
        GuardarHistorico("FIN", "Ejecución finalizada. Tiempo de ejecución: " & $minutos & " min " & $segundos & " seg. " & _
                        "Casos procesados: " & $gMainCounter & " | Total de incidencias: " & $totalIncidencias & @CRLF & _
                         "Casos agregados: " & $cadenaNumeros & @CRLF)
        ;====================================================
        ;=============================================================================

        MsgBox(0, "Alerta", "Terminado, casos agregados: "& $cadenaNumeros)
        $parar = True
    Else
        ; Mostrar un MsgBox con solo el botón "Aceptar"
        MsgBox($MB_SYSTEMMODAL + $MB_ICONWARNING + $MB_TOPMOST, _
            "?? Alerta - Neocase No Encontrado ??", _
            "? No se encontró Neocase." & @CRLF & @CRLF & _
            "?? **LEA TODO EL TEXTO ANTES DE CONTINUAR**" & @CRLF & _
            "?? Después de pulsar 'Aceptar', presione la tecla 'ESC' para detener la ejecución." & @CRLF & @CRLF & _
            "?? **Posibles causas del error:**" & @CRLF & _
            "   1?? Neocase tardó más de 10 segundos en arrancar." & @CRLF & _
            "   2?? No se ejecutó la pestaña de LogIn de Neocase y entró directamente." & @CRLF & _
            "      - Esto puede ocurrir si ya había algo abierto en Neocase (un caso, pestaña, etc.)." & @CRLF & _
            "      - ?? **SOLUCIÓN:** Cierra sesión en Neocase y vuelve a ejecutar el script." & @CRLF & @CRLF & _
            "?? **IMPORTANTE:** Recuerda siempre cerrar el navegador **Edge** estando en pantalla completa." & @CRLF & @CRLF & _
            "? **Presione 'Aceptar' para continuar.**" _
            , 100000000)
    EndIf

    Sleep(100) ; Evitar un uso excesivo de CPU
WEnd

Func Salir()
    GuardarHistorico("CERRADO", "El usuario presionó ESC y cerró el script.")
    Exit
EndFunc

Func ObtenerIncidenciaAliquo($num)
    ;vamos a aliquo a filtrar
    MouseMove(240, 207, 4)
    Sleep(100)
    MouseClick("left", 240, 207,1) ;
    Send($num)
    Sleep(100)
    Send("{ENTER}")
    Sleep(400)
EndFunc

Func ObtenerProximoNumero()
    Sleep(100)
    ClipPut("")

    ;Coopiar al portapapeles el caso
    MouseMove($x1, $y1, 2)
    Sleep(200)
    MouseDown("left")  ; Mantiene el clic izquierdo
    Sleep(100)
    MouseMove($x1+63, $y1, 4) ;
    Sleep(100)
    MouseUp("left")    ; Suelta el clic izquierdo
    Sleep(100)
    Send("^c")
    Sleep(100)

    ; Obtener el contenido del portapapeles
    Local $sClipboard = ClipGet()

    $portaPapeles = ClipGet()
    $y1= $y1+22.4
    if EstaEnArray($incidencias, $portaPapeles) Then
        if($portaPapeles<> "")then
            Return ObtenerProximoNumero()
        EndIf
    Else
        AgregarNumero($incidencias, $portaPapeles)
        Return $portaPapeles
    EndIf

    Return ""
EndFunc

Func HayQueComprobar() ; función para comprobar si el caso existe o no
    ClipPut("")  ; Establece el contenido del portapapeles como vacío
    Sleep(100)
    MouseClick("left", 241, 212, 2)
    Sleep(200)
    Send($proximoNum)
    Sleep(200)
    Send("{ENTER}")
    Sleep(800)

    EsperarColor(525, 992, 0xF0F0F0); para comprobar si ha cargado el caso
    ConsoleWrite("comprueba que ha cargado el caso !!")

    MouseMove(244, 233, 10)
    Sleep(250)
    MouseClick("left", 244, 233, 1)
    Sleep(550)
    Send("^c")
    Sleep(250)
    Local $copiedText = ClipGet()

    ConsoleWrite("El portapapeles no está vacío. Contenido: " & $copiedText & @CRLF)
    Sleep(250)
    ; Obtener el color de la línea
    Local $colorFondo = PixelGetColor(209, 233) ; Coordenadas de la línea
    ConsoleWrite("Color de fondo detectado: " & Hex($colorFondo, 6) & @CRLF)
    Sleep(100)
    ; Si el color es gris (0xE9E8E6), se crea un caso
    If $colorFondo = 0xE9E8E6 Then
        ConsoleWrite("La línea es GRIS. Creando nuevo caso..." & @CRLF)
        Sleep(100)
        MouseClick("left", $x1 + 15, $y1 - 24.5, 2) ;hacemos click en el caso
        Sleep(4500)
        MouseMove(454, 9, 8); seleccionamos pestaña que se abre para ponerla a la derecha
        Sleep(250)
        MouseDown("left")
        MouseMove(1883, 299, 8)
        MouseUp("left")
        Sleep(500)
        crearCaso()

        Sleep(700)
        MouseClick("left", 1898, 8, 1)
        Sleep(400)

        EsperarColor(803, 492, 0xFFFFFF)

        MouseClick("left", 929, 538, 1)

    Else
        ConsoleWrite("El color detectado NO es gris. Continuando iteración..." & @CRLF)
        Sleep(400) ; Esperar un poco antes de volver a iterar
    EndIf
EndFunc

Func bajar() ;funcion para hacer scroll down en la barra lateral
    MouseMove(1887,518,4)
    MouseDown("left")  ; Mantiene el clic izquierdo
    MouseMove(1887,785,10)
    Sleep(500)
    MouseUp("left")
    Sleep(200)
    $x1 = 1217  ; Coordenada X empezar en neocase
    $y1 = 372  ; Coordenada Y empezar en neocase
    MouseMove($x1,$y1,4)
EndFunc

Func PasarPagina()
	Sleep(1000)
	EsperarColor(1839, 1008, 0xE0E3E8)
    MouseMove(1856, 1010, 10)
    MouseClick("left", 1856, 1010,1)
    $x1 = 1217  ; Coordenada X empezar en neocase
    $y1 = 366  ; Coordenada Y empezar en neocase
    Sleep(10000)
EndFunc

; Función para añadir un número al array
Func AgregarNumero(ByRef $aArray, $iNumero)
    Local $iSize = UBound($aArray) ; Obtiene el tamaño actual del array
    ReDim $aArray[$iSize + 1] ; Redimensiona el array para añadir un nuevo elemento
    $aArray[$iSize] = $iNumero ; Añade el número al final del array
EndFunc

; Función para verificar si un número está en el array
Func EstaEnArray($aArray, $iNumero)
    Local $sTrimmed = StringStripWS($iNumero, 3) ; Elimina espacios al inicio y final
    Local $iNumeroparsed = Number($sTrimmed) ; Convierte la cadena a número
    Local $iIndex = _ArraySearch($aArray, $iNumeroparsed) ; Busca el número en el array
    Return $iIndex <> -1 ; Devuelve True si está presente, False si no
EndFunc

Func crearCaso()
    Sleep(500)
    ;pulsar en añadir
    MouseClick("left", 78, 62, 1)
    Sleep(3500)
    EsperarColor(305, 576, 0xE9E8E6)

    ;rellenar el campo Documento
    MouseMove(317, 202, 10)
    MouseClick("left", 317, 202, 1)
    Sleep(100)
    Send("Pte Recibir SAT") ; Documento
    Sleep(100)

    ; fecha inicio
    MouseClick("left", 202, 290, 1)
    Sleep(150)
    MouseClick("left", 230, 451, 1)
    Sleep(350)

    ;pulsar en estado
    MouseClick("left", 217, 422, 1)

    MouseMove(291, 523,10)
    EsperarColor(291, 523, 0xFBF4E7)

    Sleep(2500)

    MouseClick("left", 291, 554, 2)
    Sleep(1000)

    ; Limpia el portapapeles
    ClipPut("")

    ; --- Primera comprobación ---
    MouseClick("left", 1763, 658, 2)
    Sleep(300)
    Send("^c")
    Sleep(400)
    Local $textoCopiado = ClipGet()

    ; Si en la primera comprobación se obtuvo contenido, se detiene la comprobación
    If $textoCopiado <> "" Then
        ConsoleWrite("Primera comprobación: El portapapeles tiene contenido: " & $textoCopiado & @CRLF)
        $detectaCliente = 1; CI
    Else
        ; --- Segunda comprobación (solo si la primera no obtuvo contenido) ---
        MouseClick("left", 1778, 696, 2)
        Sleep(300)
        Send("^c")
        Sleep(300)
        $textoCopiado = ClipGet()

        If $textoCopiado <> "" Then
            ConsoleWrite("Segunda comprobación: El portapapeles tiene contenido: " & $textoCopiado & @CRLF)
            $detectaCliente = 1 ; CI
        Else
            ConsoleWrite("PC Componentes: El contenido está vacío." & @CRLF)
            $detectaCliente = 0 ; es PC
        EndIf
    EndIf

    ; ---  comprobación si pone Caso en clinica  para ver que altura hay ---
    ClipPut("")
    Sleep(300)
    MouseClick("left", 1396, 185, 3)
    Sleep(500)
    Send("^c")
    Sleep(300)
    Local $textoAltura = ClipGet()
    ConsoleWrite("PC Componentes: El contenido está vacío." & $textoAltura & @CRLF)
    Sleep(300)

    If $textoAltura = "" Then
        ;?? Coger el número de caso desde la URL copiada
        MouseMove(1808, 47, 10)
        MouseClick("left", 1808, 47, 1)
        Sleep(500)
        Send("^c")
        Sleep(500)

        Local $textoURL = ClipGet()
        Sleep(100)

        ; ?? Extraer el número al final de la URL después de "numero="
        Local $aMatch = StringRegExp($textoURL, "numero=(\d+)", 1)
        If @error Or UBound($aMatch) = 0 Then
            MsgBox($MB_ICONERROR, "Error", "? No se pudo extraer el número del caso.")
            Return
        EndIf

        Local $numCaso = $aMatch[0]
        ConsoleWrite("? Número de caso extraído: " & $numCaso & @CRLF)
        ClipPut($numCaso) ; ??? Actualiza el portapapeles con solo el número del caso
        AgregarNumero($casosCreados, $numCaso)
        Sleep(400)

        MouseClick("left",1125,451,1)
        Sleep(350)
        MouseClick("left", 149, 343, 1) ; escribe en Referencia el numero de caso
        Send("^v")
        Sleep(500)

        ; detalle del trabajo
        Sleep(350)
        MouseMove(1438, 314, 5)
        MouseClick("left", 1438, 314, 3)
        Sleep(150)
        Send("^c")
        Sleep(400)
        MouseClick("left", 268, 258,1)
        Sleep(200)
        MouseClick("left", 144, 317,1)
        Sleep(200)
        MouseClick("left", 164, 337,2)
        Sleep(200)
        Send("^v")
        Sleep(200)
        Send("   ")

        Sleep(200)
        MouseClick("left", 1723, 310, 3)
        Sleep(200)
        Send("^c")
        Sleep(200)
        MouseClick("left", 144, 317,1)
        Send("^v")
        Sleep(200)
        ;escribir into "Model:" intro "S/N:"  el numCaso
        Send("{ENTER}")
        Sleep(200)
        Send("MODEL:")
        Sleep(200)
        Send("{ENTER}")
        Sleep(200)
        Send("S/N:")
        Sleep(200)
        Send("{ENTER}")
        Sleep(200)
        Send($numCaso)
        Sleep(200)

        ;rellenar Detalle del aviso
        MouseClick("left", 171, 259, 1)
        Sleep(300)
        MouseClick("left", 1609, 390, 3)
        Sleep(100)
        Send("^c")
        Sleep(200)
        MouseClick("left", 272, 355, 1)
        Sleep(100)
        Send("^v")
        Sleep(200)

        ;rellenar la pestaña Direccion
        Sleep(250)
        MouseMove(90, 253, 6)
        Sleep(200)
        MouseClick("left", 90, 253, 1) ; aliquo pestaña

        ; comprueba si estoy en direccion
        EsperarColor(166, 391, 0xE2AE36)

        ;contacto
        MouseClick("left", 1763, 528, 2) ;neocase
        Sleep(200)
        Send("^c")
        Sleep(200)
        MouseClick("left", 125, 290, 1) ;aliquo
        Sleep(150)
        Send("^v")
        Sleep(200)
        Send(" ")
        Sleep(200)
        MouseClick("left", 1510, 528, 2) ;neocase
        Sleep(200)
        Send("^c")
        Sleep(200)
        MouseClick("left", 541, 290, 1) ;aliquo
        Sleep(150)
        Send("^v")
        Sleep(200)

        ;Direccion
        MouseClick("left", 1512, 699, 2) ;neocase
        Sleep(200)
        Send("^c")
        Sleep(200)
        MouseClick("left", 189, 314, 1) ;aliquo
        Sleep(150)
        Send("^v")
        Sleep(200)

        ;Cod postal
        MouseClick("left", 1512, 793, 2) ;neocase
        Sleep(200)
        Send("^c")
        Sleep(200)
        Local $codPostal = ClipGet()
        MouseClick("left", 122, 368, 1) ;aliquo
        Sleep(150)
        Send("^v")
        Sleep(200)

        ;Poblacion->ciudad
        MouseClick("left", 1775, 784, 2) ;neocase
        Sleep(200)
        Send("^c")
        Sleep(200)
        MouseClick("left", 291, 366, 1) ;aliquo
        Sleep(150)
        Send("^v")
        Sleep(200)

        ; ----------- NUEVO: Provincia segura desde CP -----------
        Local $provincia = ProvinciaDesdeCP($codPostal)
        If @error Then
            ConsoleWrite("?? CP no reconocido. CP bruto='" & $codPostal & "'" & @CRLF)
        Else
            MouseClick("left", 630, 367, 1) ;aliquo
            Sleep(300)
            Send($provincia)
        EndIf
        ; ---------------------------------------------------------

        ;Telefono
        ClipPut("")
        MouseClick("left", 1527, 568, 2) ;neocase
        Sleep(100)
        Send("^c")
        Sleep(200)
        MouseClick("left", 122, 419, 1) ;aliquo
        Send("^v")
        Sleep(100)

        ;E-mail
        ClipPut("")
        MouseClick("left", 1527, 613, 2) ;neocase
        Sleep(100)
        Send("^c")
        Sleep(200)
        MouseClick("left", 657, 419, 1) ;aliquo
        Sleep(100)
        Send("^v")

        ;CLIENTE
        MouseClick("left",  32, 260, 1)
        Sleep(200)
        MouseClick("left",  177, 231, 1)
        Sleep(800)
        MouseMove(122, 332, 10)
        EsperarColor(122, 332, 0xFBF4E7)
        Sleep(500)
        MouseClick("left", 122, 332, 1)
        Sleep(500)

        If $detectaCliente = 0 Then
            ;PC
            Send("03574")
            Send("{ENTER}")
            Sleep(1000)
            EsperarColor(792, 460, 0xE9E8E6)
            ConsoleWrite("Después de EsperarColor() - Se detectó el color correctamente" & @CRLF)
            Sleep(500)
            MouseMove(168, 350, 10)
            Sleep(800)
            MouseClick("left", 168, 350, 2)
            Sleep(1000)
            MouseMove(1092, 662, 10)
            Sleep(1000)
            MouseClick("left", 1092, 662, 1)
        Else
            ;CI
            Send("03372")
            Send("{ENTER}")
            Sleep(1000)
            EsperarColor(792, 460, 0xE9E8E6)
            Sleep(500)
            MouseMove(168, 350, 10)
            Sleep(800)
            MouseClick("left", 168, 350, 2)
            Sleep(1000)
            MouseClick("left", 1092, 662, 1)
        EndIf

        ;CERRAR
        Sleep(1000)
        MouseClick("left", 27, 76, 1) ;aliquo guardamos parte
        Sleep(1500)
        MouseClick("left", 365, 163, 1) ;aliquo cerramos parte
		
		
		
        imprime()



    Else
        ; Obtener el contenido del portapapeles
        Local $copiedText = ClipGet()

        ;?? Coger el número de caso desde la URL copiada
        MouseMove(1808, 47, 10)
        MouseClick("left", 1808, 47, 1)
        Sleep(500)
        Send("^c")
        Sleep(500)

        Local $textoURL = ClipGet()
        Sleep(100)

        ; ?? Extraer el número al final de la URL después de "numero="
        Local $aMatch = StringRegExp($textoURL, "numero=(\d+)", 1)
        If @error Or UBound($aMatch) = 0 Then
            MsgBox($MB_ICONERROR, "Error", "? No se pudo extraer el número del caso.")
            Return
        EndIf

        Local $numCaso = $aMatch[0]
        ConsoleWrite("? Número de caso extraído: " & $numCaso & @CRLF)
        ClipPut($numCaso)
        AgregarNumero($casosCreados, $numCaso)
        Sleep(400)

        MouseClick("left",1125,451,1) ;pulsa la nada
        Sleep(350)
        MouseClick("left", 149, 343, 1) ; escribe en referencia el numero de caso
        Send("^v")
        Sleep(600)

        ; detalle del trabajo
        MouseClick("left", 1438, 344, 3) ; PINCHA EN NEOCASE PARA LA MARCA DEL CACHARRO
        Sleep(420)
        Send("^c")
        Sleep(200)
        MouseClick("left", 268, 258,1) ;pincha sobre detalles del trabajo
        Sleep(100)
        MouseClick("left", 144, 317,1)
        Sleep(100)
        MouseClick("left", 164, 337,2)
        Sleep(200)
        Send("^v")
        Sleep(200)
        Send("   ")

        Sleep(200)
        MouseClick("left", 1723, 345, 3)
        Sleep(200)
        Send("^c")
        Sleep(200)
        MouseClick("left", 144, 317,1)
        Sleep(200)
        Send("^v")
        Sleep(200)
        ;escribir into "Model:" intro "S/N:"  el numCaso
        Send("{ENTER}")
        Sleep(200)
        Send("MODEL:")
        Sleep(200)
        Send("{ENTER}")
        Sleep(200)
        Send("S/N:")
        Sleep(200)
        Send("{ENTER}")
        Sleep(200)
        Send($numCaso)
        Sleep(100)

        ;rellenar Detalle del aviso
        MouseClick("left", 171, 259, 1)
        Sleep(200)
        MouseClick("left", 1609, 425, 3)
        Sleep(200)
        Send("^c")
        Sleep(100)
        MouseClick("left", 272, 355, 1)
        Sleep(150)
        Send("^v")
        Sleep(100)

        ;rellenar la pestaña Direccion
        Sleep(250)
        MouseMove(90, 253, 6)
        MouseClick("left", 90, 253, 1) ;aliquo pestaña

        ; comprueba si estoy en direccion
        EsperarColor(166, 391, 0xE2AE36)

        ;contacto
        Sleep(250)
        MouseClick("left", 1763, 563, 2) ;neocase
        Sleep(200)
        Send("^c")
        Sleep(200)
        MouseClick("left", 125, 290, 1) ;aliquo
        Send("^v")
        Sleep(200)
        Send(" ")
        Sleep(200)
        MouseClick("left", 1510, 563, 2) ;neocase
        Sleep(200)
        Send("^c")
        Sleep(200)
        MouseClick("left", 541, 290, 1) ;aliquo
        Sleep(150)
        Send("^v")
        Sleep(200)

        ;Direccion
        MouseClick("left", 1512, 734, 2) ;neocase
        Sleep(200)
        Send("^c")
        Sleep(200)
        MouseClick("left", 189, 314, 1) ;aliquo
        Sleep(150)
        Send("^v")
        Sleep(200)

        ;Cod postal
        MouseClick("left", 1512, 828, 2) ;neocase
        Sleep(200)
        Send("^c")
        Sleep(200)
        Local $codPostal = ClipGet()
        Sleep(150)
        MouseClick("left", 122, 368, 1) ;aliquo
        Sleep(300)
        Send("^v")
        Sleep(100)

        ;Poblacion->ciudad
        MouseClick("left", 1775, 819, 2) ;neocase
        Sleep(200)
        Send("^c")
        Sleep(200)
        MouseClick("left", 291, 366, 1) ;aliquo
        Sleep(100)
        Send("^v")
        Sleep(200)

        ; ----------- NUEVO: Provincia segura desde CP -----------
        Local $provincia = ProvinciaDesdeCP($codPostal)
        If @error Then
            ConsoleWrite("?? CP no reconocido. CP bruto='" & $codPostal & "'" & @CRLF)
        Else
            MouseClick("left", 630, 367, 1) ;aliquo
            Sleep(300)
            Send($provincia)
        EndIf
        ; ---------------------------------------------------------

        ;Telefono
        ClipPut("")
        MouseClick("left", 1527, 603, 2) ;neocase
        Sleep(100)
        Send("^c")
        Sleep(100)
        MouseClick("left", 122, 419, 1) ;aliquo
        Sleep(100)
        Send("^v")
        Sleep(100)

        ;E-mail
        ClipPut("")
        MouseClick("left", 1527, 648, 2) ;neocase
        Sleep(100)
        Send("^c")
        Sleep(100)
        MouseClick("left", 657, 419, 1) ;aliquo
        Sleep(100)
        Send("^v")
        Sleep(100)

        ;CLIENTE
        MouseClick("left",  32, 260, 1)
        Sleep(200)
        MouseClick("left",  177, 231, 1)
        Sleep(800)
        MouseMove(122, 332, 10)
        EsperarColor(122, 332, 0xFBF4E7)
        Sleep(500)
        MouseClick("left", 122, 332, 1)
        Sleep(500)

        If $detectaCliente = 0 Then
            ;PC
            Send("03574")
            Send("{ENTER}")
            Sleep(1000)
            EsperarColor(792, 460, 0xE9E8E6)
            ConsoleWrite("Después de EsperarColor() - Se detectó el color correctamente" & @CRLF)
            Sleep(500)
            MouseMove(168, 350, 10)
            Sleep(800)
            MouseClick("left", 168, 350, 2)
            Sleep(1000)
            MouseClick("left", 1092, 662, 1)
        Else
            ;CI
            Send("03372")
            Send("{ENTER}")
            Sleep(1000)
            EsperarColor(792, 460, 0xE9E8E6)
            Sleep(500)
            MouseMove(168, 350, 10)
            Sleep(800)
            MouseClick("left", 168, 350, 2)
            Sleep(1000)
            MouseClick("left", 1092, 662, 1)
        EndIf

        ;CERRAR
        Sleep(1000)
        MouseClick("left", 27, 76, 1) ;aliquo guardamos parte
        Sleep(1500)
        EsperarColor(142, 67, 0x95D059)
        MouseMove(365, 163, 10)
        Sleep(200)
        MouseClick("left", 365, 163, 1) ;aliquo cerramos parte
        
		
		imprime()
    
	
	EndIf
EndFunc

Func imprime()
    Sleep(2000)
    MouseMove(1375,189,8)
    MouseDown("left")  ; Mantiene el clic izquierdo
    MouseMove(1503,1058,12)
    Sleep(500)
    MouseUp("left")
    Sleep(200)

    MouseMove(1656,526,8)
    Sleep(200)
    ; Simular un clic derecho en la posición (x, y) abrir vista de impresion
    ClickSeguro("right", 1656, 526, 1)
    Sleep(100)
    ClickSeguro("left", 1709, 650,1)

    ;pinchar en el desplegable
    Sleep(800)
    MouseMove(1588, 48,8)
    Sleep(300)
    EsperarColor(1585, 40, 0xDEDEDE)
    Sleep(100)

    ClickSeguro("left", 1588, 48,1)
    Sleep(1000)
    ClickSeguro("left", 1543, 60,1) ; pincha en lo de vista de impresion

    Sleep(500)
    ClickSeguro("left", 1739, 44,1)
    Sleep(100)
    ClickSeguro("left", 1634, 179,1) ; lo pone al 100%

    Sleep(500)
    ClickSeguro("left", 958, 49,1) ; pincha en el boton de la impresora
    Sleep(500)
    ClickSeguro("left", 1212, 417,1) ; pincha en el boton de imprimir

    Sleep(500)
    ClickSeguro("left", 919, 539,1) ; pincha en la nada
EndFunc

Func compruebaPortapapeles()
    ; Vaciar el portapapeles al inicio
    ClipPut("")

    While True
        ; Realizar clic izquierdo en la posición (1076, 255) y simular Ctrl+C
        MouseClick("left", 1076, 255, 2)
        Send("^c")

        ; Obtener el contenido del portapapeles
        Local $contenidoPortapapeles = ClipGet()

        ; Limpiar espacios al inicio y al final del contenido
        $contenidoPortapapeles = StringStripWS($contenidoPortapapeles, 3)

        ; Verificar si el portapapeles no contiene "Filas"
        If $contenidoPortapapeles <> "Filas" Then
            ConsoleWrite("Portapapeles no contiene 'Filas'. Contenido actual: " & $contenidoPortapapeles & @CRLF)
            Sleep(500) ; Pausa para evitar uso excesivo de CPU
        Else
            ConsoleWrite("Portapapeles contiene 'Filas'. Salimos del bucle." & @CRLF)
            ExitLoop ; Salir del bucle
        EndIf
    WEnd
EndFunc

Func compruebaIncidencias()
    ; Vaciar el portapapeles al inicio
    ClipPut("")

    While True
        ; Realizar clic izquierdo en la posición (229, 1006) y simular Ctrl+C
        MouseClick("left", 229, 1006, 3)
        Send("^c")

        ; Obtener el contenido del portapapeles
        Local $contenidoPortapapeles = ClipGet()

        ; Verificar si el portapapeles está vacío
        If $contenidoPortapapeles = "" Then
            ConsoleWrite("Portapapeles vacío, esperando..." & @CRLF)
            Sleep(500) ; Pausa para evitar uso excesivo de CPU
        Else
            ConsoleWrite("Portapapeles contiene datos: " & $contenidoPortapapeles & @CRLF)
            ExitLoop ; Salir del bucle
        EndIf
    WEnd
EndFunc

Func comprobarColorLinea()
    ; Coordenadas donde está la línea de la tabla
    Local $x = 209 ; Ajusta según la posición en pantalla
    Local $y = 233 ; Ajusta según la posición en pantalla

    ; Obtener el color del píxel en la coordenada
    Local $color = PixelGetColor($x, $y)

    ; Imprimir el color en consola
    ConsoleWrite("Color detectado: " & Hex($color, 6) & @CRLF)

    ; Comparar con los colores de referencia
    If $color = 0xEBF3E0 Then ; Verde claro (ajusta el código según sea necesario)
        ConsoleWrite("La línea es VERDE (Caso encontrado)." & @CRLF)
        Return "Verde"
    ElseIf $color = 0xE9E8E6 Then ; Gris claro (ajusta el código según sea necesario)
        ConsoleWrite("La línea es GRIS (No hay caso)." & @CRLF)
        Return "Gris"
    Else
        ConsoleWrite("El color no coincide con verde ni gris. Color detectado: " & Hex($color, 6) & @CRLF)
        Return "Desconocido"
    EndIf
EndFunc

; Función que verifica si se ha excedido el tiempo máximo (en milisegundos)
Func Timeout($startTime, $maxTime)
    If TimerDiff($startTime) >= $maxTime Then
         Return True
    Else
         Return False
    EndIf
EndFunc










; Función EsperarColor con timeout incorporado
Func EsperarColor($x, $y, $colorEsperado)
    Local $startTime = TimerInit()  ; Inicia el temporizador

    While True
        Local $colorDetectado = PixelGetColor($x, $y)
        ConsoleWrite("Color detectado en (" & $x & "," & $y & "): " & Hex($colorDetectado, 6) & @CRLF)

        If $colorDetectado = $colorEsperado Then
            Local $elapsedTime = TimerDiff($startTime)  ; Tiempo en milisegundos
            ConsoleWrite("Color detectado correctamente en (" & $x & "," & $y & "). Tiempo esperado: " & ($elapsedTime / 1000) & " segundos." & @CRLF)
            ExitLoop
        EndIf

        If TimerDiff($startTime) >= 40000 Then
            MsgBox(16, "Timeout", "La ejecución se ha detenido inesperadamente. Vuelva a ejecutar el programa.")
            Exit  ; Detener la ejecución del script
        EndIf

        Sleep(500)
    WEnd
EndFunc

Func MostrarVerificacionPantalla($sRutaImagen)
    Local $iAncho = 600, $iAlto = 550
    Local $hGUI = GUICreate("Verificación de Pantalla", $iAncho, $iAlto)
    Local $hPic = GUICtrlCreatePic($sRutaImagen, 10, 10, 580, 300)

    Local $sMensaje = "			?? Para iniciar el programa:" & @CRLF & _
                      " 				  ?? Cierra todas las pantallas de EDGE." & @CRLF & _
                      "  				  ??? Comprueba que al abrir EDGE se abra en pantalla completa." & @CRLF & _
                      "  				  (Se recomienda cerrar otras aplicaciones, aunque no es obligatorio)." & @CRLF & _
                      "  				  ? No cierres AutoIt (el programa que lo ejecuta)." & @CRLF & _
                      "   				  ?? Ubica AutoIt en la pantalla del portátil antes de presionar F5." & @CRLF & @CRLF & _
                      "			???? Si por algún motivo el programa se detiene:" & @CRLF & @CRLF & _
                      "   				?? Presiona la tecla ESC para detenerlo," & @CRLF & _
                      "  				o en AutoIt, ve a Tools y selecciona 'Stop Executing'."

    Local $hLabel = GUICtrlCreateLabel($sMensaje, 10, 320, 580, 180)
    Local $hBtnCorrecto = GUICtrlCreateButton("Esta correcto", 100, 500, 150, 40)
    Local $hBtnMal = GUICtrlCreateButton("Esta mal", 350, 500, 150, 40)
    GUISetState(@SW_SHOW, $hGUI)

    While True
        Switch GUIGetMsg()
            Case $GUI_EVENT_CLOSE
                Exit
            Case $hBtnCorrecto
                ExitLoop
            Case $hBtnMal
                Exit
        EndSwitch
    WEnd

    GUIDelete($hGUI)
EndFunc

;=============================================================
Func BuscarColorVerticalYClick($xInicial, $yInicio, $yFin, $colorObjetivo)
    Local $paso = 1 ; número de píxeles que avanza cada iteración (puedes ajustar la precisión)
    Local $colorDetectado

    For $y = $yInicio To $yFin Step $paso
        $colorDetectado = PixelGetColor($xInicial, $y)
        ConsoleWrite("Comprobando (" & $xInicial & "," & $y & "): " & Hex($colorDetectado, 6) & @CRLF)

        If $colorDetectado = $colorObjetivo Then
            ConsoleWrite("? Color encontrado en (" & $xInicial & "," & $y & ")" & @CRLF)
            MouseMove($xInicial, $y, 5)
            Sleep(200)
            MouseClick("left", $xInicial, $y, 2) ; doble clic
            Return True
        EndIf

        Sleep(10) ; pequeña pausa para no saturar CPU
    Next

    ConsoleWrite("? Color no encontrado entre Y=" & $yInicio & " y Y=" & $yFin & @CRLF)
    Return False
EndFunc

; ==================================================================
; ?? Función para guardar registros en el archivo de histórico
Func GuardarHistorico($evento, $mensaje)
    Local $hFile = FileOpen($sLogFile, $FO_APPEND)  ; Abrir archivo en modo añadir (append)
    If $hFile = -1 Then Return  ; Si no se puede abrir, salir de la función

    Local $sFechaHora = @YEAR & "-" & @MON & "-" & @MDAY & " " & @HOUR & ":" & @MIN & ":" & @SEC

    ; ?? Agregamos un salto de línea extra antes de cada nueva ejecución
    If $evento = "INICIO" Then FileWriteLine($hFile, @CRLF)  ; Solo lo hace cuando el script empieza

    FileWriteLine($hFile, "[" & $sFechaHora & "] [" & $evento & "] " & $mensaje)
    FileClose($hFile)  ; Cerrar archivo
EndFunc
;===================================================================

; ====================== NUEVO: función robusta CP -> Provincia ======================
; Devuelve la provincia a partir de un código postal (cadena desde el portapapeles).
; Limpia todo y se queda solo con dígitos. Si no hay 2 dígitos, devuelve "" y @error <> 0
Func ProvinciaDesdeCP($cp)
    ; Normalizar: quitar NBSP y dejar solo dígitos
    $cp = StringReplace($cp, Chr(160), "")              ; NBSP
    $cp = StringStripWS($cp, 3)                         ; quitar espacios extremos
    $cp = StringRegExpReplace($cp, "[^\d]", "")         ; Solo dígitos

    If StringLen($cp) < 2 Then Return SetError(1, 0, "")

    Local $pref = StringLeft($cp, 2)

    ; Diccionario estático (se crea una vez)
    Static $oMap = 0
    If Not IsObj($oMap) Then
        $oMap = ObjCreate("Scripting.Dictionary")
        $oMap.Add("01", "Álava")
        $oMap.Add("02", "Albacete")
        $oMap.Add("03", "Alicante")
        $oMap.Add("04", "Almería")
        $oMap.Add("05", "Ávila")
        $oMap.Add("06", "Badajoz")
        $oMap.Add("07", "Baleares")
        $oMap.Add("08", "Barcelona")
        $oMap.Add("09", "Burgos")
        $oMap.Add("10", "Cáceres")
        $oMap.Add("11", "Cádiz")
        $oMap.Add("12", "Castellón")
        $oMap.Add("13", "Ciudad Real")
        $oMap.Add("14", "Córdoba")
        $oMap.Add("15", "La Coruña")
        $oMap.Add("16", "Cuenca")
        $oMap.Add("17", "Gerona")
        $oMap.Add("18", "Granada")
        $oMap.Add("19", "Guadalajara")
        $oMap.Add("20", "Guipúzcoa")
        $oMap.Add("21", "Huelva")
        $oMap.Add("22", "Huesca")
        $oMap.Add("23", "Jaén")
        $oMap.Add("24", "León")
        $oMap.Add("25", "Lérida")
        $oMap.Add("26", "La Rioja")
        $oMap.Add("27", "Lugo")
        $oMap.Add("28", "Madrid")
        $oMap.Add("29", "Málaga")
        $oMap.Add("30", "Murcia")
        $oMap.Add("31", "Navarra")
        $oMap.Add("32", "Orense")
        $oMap.Add("33", "Asturias")
        $oMap.Add("34", "Palencia")
        $oMap.Add("35", "Las Palmas")
        $oMap.Add("36", "Pontevedra")
        $oMap.Add("37", "Salamanca")
        $oMap.Add("38", "Santa Cruz de Tenerife")
        $oMap.Add("39", "Cantabria")
        $oMap.Add("40", "Segovia")
        $oMap.Add("41", "Sevilla")
        $oMap.Add("42", "Soria")
        $oMap.Add("43", "Tarragona")
        $oMap.Add("44", "Teruel")
        $oMap.Add("45", "Toledo")
        $oMap.Add("46", "Valencia")
        $oMap.Add("47", "Valladolid")
        $oMap.Add("48", "Vizcaya")
        $oMap.Add("49", "Zamora")
        $oMap.Add("50", "Zaragoza")
        $oMap.Add("51", "Ceuta")
        $oMap.Add("52", "Melilla")
    EndIf

    If $oMap.Exists($pref) Then
        Return $oMap.Item($pref)
    EndIf

    Return SetError(2, 0, "")
EndFunc
; ==================================================================
;============================================================
; Vigilante permanente de la ventana emergente de Aliquo
Func VigilarVentanaAliquo()
    Local $sVentana = "Aliquo Software (5.0.2511.12221)"

    If WinExists($sVentana) Then
        ConsoleWrite("?? Ventana emergente detectada: " & $sVentana & @CRLF)

        WinActivate($sVentana)
        Sleep(150)
        WinClose($sVentana)
        Sleep(300)

        If WinExists($sVentana) Then
            WinKill($sVentana)
        EndIf

Sleep(1000)
        ; Marcamos que hay que repetir el click
        If $g_LastClickX <> -1 Then
            $g_RepetirClickPendiente = True
        EndIf
    EndIf

    ; Repetir el último click si quedó pendiente
    If $g_RepetirClickPendiente Then
        ConsoleWrite("?? Repitiendo último click tras cerrar popup" & @CRLF)
        Sleep(300)
        MouseMove($g_LastClickX, $g_LastClickY, 10)
        MouseClick($g_LastClickButton, $g_LastClickX, $g_LastClickY, $g_LastClickCount)
        $g_RepetirClickPendiente = False
    EndIf
EndFunc


Func ClickSeguro($button, $x, $y, $count = 1)
    ; Guardamos el último click importante
    $g_LastClickX = $x
    $g_LastClickY = $y
    $g_LastClickButton = $button
    $g_LastClickCount = $count
    $g_RepetirClickPendiente = False

    MouseMove($x, $y, 10)
    MouseClick($button, $x, $y, $count)
EndFunc
