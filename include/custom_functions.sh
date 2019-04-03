# Verifica se a Universidade já existe na base de dados;
Universidade_Nome_Repetido()
{
    # Caso o ficheiro das universidades não exista, significa que não há repetidos, logo retorna 0
    if [ ! -f "$file_uni" ]
        then
            echo 0
        else
            # Vai tentar encontrar o mesmo nome que a Universidade que foi pedida
            # Retorna vazio caso não encontre
            nome=$(grep ":$1:" "$file_uni" | cut -d : -f 2)

            # Caso a string encontrada seja igual ao nome da universidade, retorna 1
            if [ "$1" == "$nome" ]
                then
                    echo 1
                else
                    echo 0
            fi
    fi 
}

# Remove um determinado dado de um determinado ficheiro
Remove_Data()
{
    if [ -z "$1" ]
        then
            dir="$2"
    else
        dir="$1/$2"
    fi

    # Caso só haja um dado no ficheiro, este será removido, pois não vale a pena existir
    if [ $(wc -l < "$dir") -eq 1 ]
        then
            rm -rf "$dir"
    else
        # Remove o dado registado
        grep -v "|$3:" "$dir" > in1.txt
        mv -T in1.txt "$dir"
    fi
}

Check_For_Country()
{
    uni_country=$(grep ":$2:" $file_uni | cut -d : -f 4)

    if [ "$uni_country" == "$1" ]
        then
            echo 1
    else
        echo 0
    fi
}