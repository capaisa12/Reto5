class Preguntas
  attr_accessor :array_hash

  def initialize
    @array_hash=[]
    Obtener_Archivo("preguntas.txt")
  end

  #Metodo para escoger una pregunta entre el array de hash
  def Hacer_pregunta
    @array_hash = @array_hash.shuffle
    return(@array_hash.first[:question])
  end

  #Metodo para verificar que la respuesta es correcta o erronea
  def Verificar_Respuesta(respuesta)
    if(@array_hash.first[:answer]==respuesta.downcase)
      @array_hash.shift
      return true
    else
      return false
    end
  end

private
  # Metodo para leer y obtener los datos de un archivo.txt y luego guardarlo en un array de hash
  def Obtener_Archivo(file)
    if File.file?(file)
      linea = IO.readlines(file)
      linea.each do |hash|
        pregunta, respuesta = hash.chomp.split('-')
        hash = {question: pregunta, answer: respuesta}
        @array_hash << hash
      end
    else
      p 'Ha ocurrido un error, No se encuentra el archivo'
    end
  end

  #Metodo que me imprime la variable de instancia tipo hash
  def imprimir_hash
    p @array_hash
  end

end #Fin Clase preguntas

class Reto5
  @jugador
  def initialize
    @jugador = Preguntas.new
  end

  def eleccion_M_Principal
    menu_principal
    opcion = gets.chomp.to_i
    if(opcion==1)
      jugando
    else
      return 0
    end
  end

private

  def menu_principal
    system("clear")
    puts "¿?-¿?-¿?-¿?-¿?-¿?-¿?-¿?-¿?-¿?-¿?-¿?-¿?-¿?-¿?-¿?-¿?-¿?-¿?-¿?-¿?-¿?-¿?-¿?"
    puts "                MENU PRINCIPAL - JUEGO DE PREGUNTAS RETO5              "
    puts "¿?-¿?-¿?-¿?-¿?-¿?-¿?-¿?-¿?-¿?-¿?-¿?-¿?-¿?-¿?-¿?-¿?-¿?-¿?-¿?-¿?-¿?-¿?-¿?\n\n"
    puts "Opciones:"
    puts "1. Jugar"
    puts "2. Salir\n\n"

    puts 'escogio? :'
  end


  def instrucciones
    puts "\n\n"
    puts "==========================================================================================================="
    puts "Instrucciones: "
    puts "Reto5 consta de #{@jugador.array_hash.length} preguntas diferentes, las cuales se mostraran de forma aleatoria"
    puts "Si usted las responde de forma correcta, se visualizara un mensaje de felicitacion y se le realizara la"
    puts "siguiente pregunta hasta que las responda todas, de manera que si usted responde todas las preguntas de forma"
    puts "correcta, GANARA EL JUEGO!!!"
    puts "Si usted se equivoca en una pregunta, podra intentar responderla nuevamente o salir del juego"
    puts "===========================================================================================================\n\n"
  end

  def jugando
    system("clear")
    cont=1
    salir=false
    instrucciones
    puts "...Ahora asi QUE COMIENZE EL JUEGO!!!!!!!"
    while(@jugador.array_hash.length!=0 && salir!=true)
        puts "Pregunta # #{cont} : #{@jugador.Hacer_pregunta}"
        respuesta = gets.chomp
        if (@jugador.Verificar_Respuesta(respuesta)==true)
          respuesta_acertada
          cont+=1
        else
          acierto=false
          salir = respuesta_equivocada
          while(salir==false && acierto==false)
            puts "Responde Nuevamente la pregunta #{cont}: #{@jugador.array_hash.first[:question]}"
            respuesta = gets.chomp
            if (@jugador.Verificar_Respuesta(respuesta)==true)
              respuesta_acertada
              cont+=1
              acierto=true
            else
              salir = respuesta_equivocada
            end # Fin if 2
          end # Fin While 2
        end #Fin if 1
    end # Fin while 1
    if(@jugador.array_hash.length==0)
      gano_juego
    else
      puts "Lo siento eres un perdedor"
    end
  end

  def respuesta_equivocada
    puts "¡¡¡Oooh lo lamento!!! Te has equivocado\n\n"
    puts "Que deseas Hacer?"
    puts "1. Intentarlo nuevamente"
    puts "2. Salir"
    intento = gets.chomp.to_i
    if(intento==1)
      return false
    else
      return true
    end
  end

  def respuesta_acertada
    puts "¡¡¡FELICITACIONES!!!"
    puts "Has respondido de forma correcta\n\n\n"
  end

  def gano_juego
    system("clear")
    puts "$$$$$$$$$$$$$$$$$$$$ FELICITACIONES $$$$$$$$$$$$$$$$$$$$$$\n\n"
    puts "Haz GANADO EL JUEGO\n\n"
    puts "...We are the championsss...."
  end
end

a = Reto5.new
a.eleccion_M_Principal
