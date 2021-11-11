menutext(){
echo "1) COMANDOS GENERALES 2)USUARIOS"
echo "3) SISTEMA DE ARCHIVOS 4)TERMINAR"
}

continuar(){
read -p "pulse ENTER paraa continuar" none
$1
}

usuarios (){
  clear
  echo MENU VARIOS USUARIOS
}

permisos(){
  clear
  local PS3='Seleccione opciones de PERMISOS '
  local options=("TODOS LOS PERMISOS (ESCRITURA,LECTURA,EJECUCION)" "QUITAR TODOS LOS PERMISOS" 
  "LECTURA/ESCRITURA" "SOLO LECTURA" "SOLO EJECUCION" "REGRESAR")
  local opt
  select opt in "${options[@]}"
  do
      case $opt in
        "TODOS LOS PERMISOS (ESCRITURA,LECTURA,EJECUCION)")
              chmod 777 $1
              continuar archivos
            ;;
        "QUITAR TODOS LOS PERMISOS")
              chmod 000 $1
              continuar archivos
              ;;
         "LECTURA/ESCRITURA")
              chmod 666 $1 
              continuar archivos
              ;;
        "SOLO LECTURA")
              clear
              chmod 444 $1  
              continuar archivos
              ;;
        "SOLO EJECUCION")
              clear
              chmod 111 $1  
              continuar archivos
              ;;
        "REGRESAR")
              clear
              return
              ;;
        "REGRESAR")
            
            return
              ;;
          *) echo "OPCION INVALIDA $REPLY";;
      esac
  done
}


usuarios () {
  clear
  echo USUARIOS
  local PS3='Selecciona una opcion de MENU USUARIOS: '
  local options=("MOSTRAR NOMBRE USUARIOS CONECTADOS" 
  "MOSTRAR NUMERO USUARIOS CONECTADOS" "AVERIGUAR SI UN USUARIO ESTA CONECTADO" "ENVIAR MENSAJE A UN USUARIO" "REGRESAR")
    local opt
  select opt in "${options[@]}"
  do
      case $opt in
        "MOSTRAR NOMBRE USUARIOS CONECTADOS")
            clear
            who
            continuar usuarios
            return
            ;;
        "MOSTRAR NUMERO USUARIOS CONECTADOS")  
            clear
            echo "Usuarios conectados:"
 	          who |wc -l;;
            continuar usuarios
            return
            ;;

         "AVERIGUAR SI UN USUARIO ESTA CONECTADO")  
            clear
 	            echo Usuario a buscar:
              read usuario
              
              if who | grep $usuario;
              then 
                echo el usuario $usuario esta conectado
              else 
                echo el usuario $usuario NO esta conectado
              fi
            continuar usuarios
            return
            ;;

        "ENVIAR MENSAJE A UN USUARIO")  
          clear
            read -p"Digite nombre del usuario al que le va a enviar un mensaje " user
            read -p"Digite el mensaje " msg
            if grep $user /etc/passwd; then
                echo $msg | write $user
            else
                echo "El usuario no existe"
            fi
            continuar usuarios
            ;;
        "REGRESAR")
            clear
            menutext
            return
              ;;
          *) echo "OPCION INVALIDA $REPLY";;
      esac
  done
}


archivos (){
  clear
  echo ARCHIVOS
  local PS3='Selecciona una opcion de MENU ARCHIVOS: '
  local options=("CREAR DIRECTORIO" "COPIAR ARCHIVOS" 
  "MODIFICAR PERMISOS DE UN ARCHIVO" "CAMBIAR NOMBRE DE UN ARCHIVO" "BORRAR UN DIRECTORIO" "REGRESAR")
  local opt
  select opt in "${options[@]}"
  do
      case $opt in
        "CREAR DIRECTORIO")
            clear
            read -p "Ingrese el nombre del directorio " nombre
	          mkdir $nombre
            continuar archivos
            return
            ;;
        "COPIAR ARCHIVOS")
              clear
              read -p "Ingrese el nombre del directorio a copiar " fichero_a_copiar
              read -p "Ingrese destino " carpeta_destino
              cp $fichero_a_copiar $carpeta_destino

              continuar archivos
              return
              ;;
         "MODIFICAR PERMISOS DE UN ARCHIVO")
              clear
              ls 
              read -p "Ingrese el nombre de un archivo listado " file
              permisos $file
              continuar archivos
              return
              ;;
        "CAMBIAR NOMBRE DE UN ARCHIVO")
              clear
              read -p "Ingrese el nombre del archivo " f
              read -p "Ingrese el NUEVO NOMBRE del archivo " n
              mv $f $n || echo "DATOS ERRONEOS VERIFICAR VALORES"
              continuar archivos
              return
              ;;
        "BORRAR UN DIRECTORIO")
              clear
              read -p "Ingrese un directorio listado que desea borrar " directory
              rm -d $directory
              clear
              continuar archivos
              return
              ;;
        "REGRESAR")
            clear
            menutext
            return
              ;;
          *) echo "OPCION INVALIDA $REPLY";;
      esac
  done
}



comandos (){
  clear
  echo COMANDOS GENERALES
  local PS3='Selecciona una opcion de MENU COMANDOS GENERALES... '
  local options=("VISUALIZAR HORA DEL SISTEMA" "PATH O RUTA ACTUAL" "CAMBIO DE PASSWORD" "MOSTRAR DISCO LIBRE" "MOSTRAR DISCO UTILIZADO"
"VISUALIZAR PROCESOS ACTIVOS" "CANCELAR UN PROCESO" "REGRESAR" )
  local opt
  select opt in "${options[@]}"
  do
      case $opt in
        "VISUALIZAR HORA DEL SISTEMA")
             clear
             date
             continuar comandos
             return
              ;;
        "PATH O RUTA ACTUAL")
              clear
              pwd
              continuar comandos
              return
              ;;
         "CAMBIO DE PASSWORD")
              clear
              read -p "Ingrese el usuario " user
              read -p "Ingrese su nueva password " pass
              echo $pass | passwd --stdin $user
              continuar comandos
              return
              ;;
        "MOSTRAR DISCO LIBRE")
              clear
               df -h
               continuar comandos
               return
                ;;
        "MOSTRAR DISCO UTILIZADO")
               clear
                echo "MOSTRAR DISCO UTILIZADO"
                df -h
                continuar comandos
                return
                    ;;
        "VISUALIZAR PROCESOS ACTIVOS")
                clear
                 ps -ef
                continuar comandos
                    ;;
        "CANCELAR UN PROCESO")
                clear
                ps -ef
                read -p"Ingrese el id del proceso a cancelar " process
                kill -9 $process
                return
                ;;
          "REGRESAR")
            clear
             menutext
            return
              ;;
          *) echo "OPCION INVALIDA $REPLY";;
      esac
  done
}

# main menu
clear
PS3='Por favor seleccione una opcion de MENU PRINCIPAL...: '
options=("COMANDOS GENERALES" "USUARIOS" "SISTEMA DE ARCHIVOS" "TERMINAR")
select opt in "${options[@]}"
do
    case $opt in
        "COMANDOS GENERALES")
            comandos
            ;;
        "USUARIOS")
            usuarios
            ;;
        "SISTEMA DE ARCHIVOS")
           archivos
            ;;
        "TERMINAR")
            exit
            return
            ;;
        *) echo "OPCION INVALIDA $REPLY";;
    esac
done