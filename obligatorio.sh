#! /bin/bash
# Santiago Brito(287318) Manuela Martinicorena Pintos(282670) Joaquin Tate Acosta (315797)
menu (){
    echo "-----------------------------------------"
    echo "Bienvenido!"
    echo
    echo "1)Opcion 1. Ingresar Usuario y Contrasena"
    echo "2)Opcion 2. Ingresar al sistema."
    echo "3)Salir del Sistema."
    echo "-----------------------------------------"
}


menu2(){
    input=0
    echo "-----------------------------------------"
    echo "Bienvenido "$usuarioDeIngreso
    if grep -q "$usuarioDeIngreso" fechas.txt
    then
        fecha=$(date)
        echo $usuarioDeIngreso":"$fecha >> "fechas.txt"
        fecha=$(grep $usuarioDeIngreso fechas.txt | tail -2 | head -1 | sed "s/\([^:]*\)\(.*\)/\2/")
        echo "Usted ingresó por última vez el $fecha"
       
    else 
        fecha=$(date)
        echo $usuarioDeIngreso":"$fecha >> fechas.txt
        echo "Usted ingresó por última vez el $fecha"

    fi
    echo "1) Cambiar Contrasena."
    echo "2) Escoger una letra."
    echo "3) Buscar palabras en el diccionario que finalicen con la letra escogida."
    echo "4) Contar las palabras de la Opcion 3."
    echo "5) Guardar las palabras en un archivo.txt, en conjunto con la fecha y hora de realizado el informe."
    echo "6) Volver al Menu Principal"
    echo "-----------------------------------------"

    read input2
    echo "-----------------------------------------"

    if [ $input2 -eq 1 ]
    then
        read -p "Ingrese nueva contrasena: " nuevaContrasena
        sed -i s/$usuarioDeIngreso.*/$usuarioDeIngreso":"$nuevaContrasena/ usuariosYcontrasenas.txt
    elif [ $input2 -eq 2 ]
    then
        echo "Ingrese letra"
        read letra
    elif [ $input2 -eq 3 ]
    then
        if [ $letra == "" ]
        then
            grep -i "a$" diccionario.txt > listaLetraParaContar.txt
            letraContador="a"
            fechaInforme=$(date)
            echo $fechaInforme >> listaLetraParaContar.txt
        else
            grep -i "$letra$" diccionario.txt > listaLetraParaContar.txt
            letraContador=$letra
            fechaInforme=$(date)
            echo $fechaInforme >> listaLetraParaContar.txt
        fi
    elif [ $input2 -eq 4 ]
    then 
        grep -ic "$letraContador$" listaLetraParaContar.txt
    elif [ $input2 -eq 5 ]
    then 
        cat listaLetraParaContar.txt >> informe.txt
    elif [ $input2 -eq 6 ]
    then 
        input2=6
    else
        echo "No es una opción válida."
    fi
    
}



touch informe.txt
touch listaLetraParaContar.txt
touch fechas.txt
input=0
while [ $input -ne 3 ];
    do
        menu 
        read input
        echo "-----------------------------------------"
    if [ $input -eq 1 ];
    then 
        read -p "Ingrese nombre de Usuario a registrar: " usuario
        read -p "Ingrese Contrasena a registrar: " contrasena
        echo $usuario":"$contrasena >> usuariosYcontrasenas.txt
    elif [ $input -eq 2 ];
    then
        read -p "Ingrese nombre de Usuario: " usuarioDeIngreso
        read -p "Ingrese contrasena: " contrasenaDeIngreso       
        if grep -xq "$usuarioDeIngreso":"$contrasenaDeIngreso" usuariosYcontrasenas.txt;
        then
            while [ "$input2" != 6 ]  
            do
                menu2
            done 
        fi
    elif [ $input -eq 3 ];
    then
        input=3
    else
        echo "No es una opción válida."
    fi
done
