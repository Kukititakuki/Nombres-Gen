#!/bin/bash

echo -e "\e[35m
╔═╦╦═╦╗╔═╦═╦═╦╗
║╣╣║║║║║╔╣╦╣║║║
╚═╩╩╩═╝╚═╩═╩╩═╝\e[0m"

echo -e "\e[31mGENERADOR DE NOMBRESKUKITITA\e[0m"
# Directorio de la tarjeta SD
sd_dir="/sdcard/password_generator"

# Crear el directorio si no existe
mkdir -p "$sd_dir"

# Nombre de archivo para guardar las contraseñas
output_file="$sd_dir/passwords.txt"

# Caracteres válidos para la contraseña
chars="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()_+\-=[]{}|;:,.<>?"

# Función para generar una contraseña
generate_password() {
    length=$1
    include_symbols=$2
    password=""
    for i in $(seq $length); do
        if [ "$include_symbols" = true ]; then
            password+="${chars:$((RANDOM%${#chars})):1}"
        else
            password+="${chars:$((RANDOM%(${#chars}-22))):1}"
        fi
    done
    echo "$password"
}

# Función para generar nombres latinos
generate_name() {
    # Lista de nombres latinos
    names=("Alejandro" "Sofía" "Hernán" "Valeria" "Gustavo" "Daniela" "Enrique" "Camila" "Diego" "Lucía" "Javier" "Ángela" "Rodrigo" "Isabella" "Pablo" "Natalia")
    
    # Seleccionar un nombre aleatorio
    name="${names[$((RANDOM%${#names[@])])]}
    echo "$name"
}

# Función principal
main() {
    echo -n "¿Cuántas contraseñas deseas generar? "
    read num_passwords

    echo -n "¿Quieres incluir símbolos en las contraseñas? (s/n) "
    read include_symbols
    if [ "$include_symbols" = "s" ]; then
        include_symbols=true
    else
        include_symbols=false
    fi

    echo "Generando $num_passwords contraseñas seguras con nombres latinos..."

    for i in $(seq $num_passwords); do
        name=$(generate_name)
        password=$(generate_password 16 $include_symbols)
        echo "$name: $password" >> "$output_file"
    done

    echo "Las contraseñas se han guardado en $output_file"
}

main