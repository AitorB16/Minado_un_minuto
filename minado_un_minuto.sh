#!/bin/sh
#minado_un_minuto.sh by AitorB16
{
    sleep 1m
    rm tmp.txt #sino no es borrado
    kill $$
} &

touch tmp.txt
cat $1 > tmp.txt
gr=$2
echo $gr
num=$(openssl rand -hex 4) #Primer numero para pasar a HEX
numz=1
printf "%s\n" $num >> tmp.txt #Guardar el numero en HEX (8 chars) en ficheroro
num2=$(cat tmp.txt | md5sum | cut -c 1-$numz) #Usar los primeros numz valores hash

#Crear string tamaño $2 de 0s para comparar el inicio del hash
zeros="0"

while true
do
echo "Buscando un fichero, cuyo hash comience por: " $zeros "\n"

#Realizar comparacion y actualizar num
while [ $num2 != $zeros ]
   do
        num=$(openssl rand -hex 4)
        cat $1 > tmp.txt
        #printf "\n" >> tmp.txt
        printf "%s %s\n" $num $gr >> tmp.txt
        num2=$(cat tmp.txt | md5sum | cut -c 1-$numz)
    done

#Guardar en fichero definitivo
cat tmp.txt > $1-$numz-CEROS

numz=$(($numz + 1))
zeros="${zeros}0" #encadenar 0 extra
done
