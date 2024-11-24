#!/data/data/com.termux/files/usr/bin/bash

echo -e "\e[35m───────────╔╗───────╔═╗
╔═╦╗╔═╗╔══╗║╚╗╔╦╗╔═╗║═╣
║║║║║╬║║║║║║╬║║╔╝║╩╣╠═║
╚╩═╝╚═╝╚╩╩╝╚═╝╚╝─╚═╝╚═╝\e[0m"

echo -e "\e[31mGENERADOR DE NOMBRES\e[0m"

# Función para generar una contraseña segura
generate_password() {
    phrases=(
        "perro"
        "gato"
        "playa"
        "sol"
        "montaña"
        "libro"
        "amigo"
        "familia"
    )

    # Generar una contraseña aleatoria con un nombre latino, símbolos y números
    pass=$(openssl rand -base64 12 | tr -dc 'a-zA-Z0-9!@#$%^&*' | head -c 12)
    
    # Seleccionar un nombre latino aleatorio de la lista
    phrase=${phrases[$((RANDOM % ${#phrases[@]}))]}

    # Crear la contraseña combinando el nombre latino, símbolos y números
    password="${phrase}_${pass}"
    
    echo "$password"
}

# Solicitar al usuario la cantidad de contraseñas a generar
read -p "¿Cuántas contraseñas deseas generar? " num_passwords

# Crear un directorio en la tarjeta SD si no existe
output_dir="/sdcard/passwords"
mkdir -p $output_dir

# Generar contraseñas y guardarlas en un archivo en la tarjeta SD
for ((i=1; i<=$num_passwords; i++)); do
    password=$(generate_password)
    echo $password >> "$output_dir/passwords.txt"
done

echo "Contraseñas generadas y guardadas en $output_dir/passwords.txt"