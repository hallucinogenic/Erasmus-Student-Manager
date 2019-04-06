# Cria o backup das pastas

Backup_Total()
{
    # Caso o ficheiro exista, prossegue
    if [ -f "$file_uni" ]
        then
            # Vamos criar o ficheiro cujo nome é a data atual (até segundos)
            date=$(date +'%Y-%m-%d_%H-%M-%S')
            
            dir_backup="$date"

            # Cria-se a directoria com a data atual
            mkdir -p $dir_backup

            # Vai buscar todas as siglas da faculdade, para copiar as pastas para a pasta de backup
            while read -r line 
            do
                sigla=$(echo $line | cut -d : -f 3)

                # Copia a diretoria com a sigla da universidade
                cp -R "$sigla" "$date/$sigla/"
                
                # Copia todos os ficheiros incluido na diretoria
                cp -R "$sigla/." "$date/$sigla/"
            done < $file_uni

                # Copia no final, o ficheiro das universidades;
                cp -R "$file_uni" "$date/"

                # Comprime-se a diretoria para um ficheiro tar.bz2
                tar -cjf "$date.tar.bz2" "$dir_backup"

                # Como se encontra na diretoria principal do projeto, será movida para a diretoria dos backups
                mv "$date.tar.bz2" "$PWD/backup"

                # No final, remove-se o ficheiro que foi copiado, tal como a diretoria que se encontra na diretoria dos backups;
                # Assim, resta apenas o ficheiro comprimido
                rm -rf "$date.tar.bz2"
                rm -rf "$dir_backup"

            # Imprime para um ficheiro, os dados dos backups (para saber quantos backups estão feitos)
            echo "$date.tar.bz2" >> "$file_backups"
    else
        echo "${red}Não existem universidades registadas para realizar o backup!${default}"
    fi
}

# Remove um determinado backup de segurança
Backup_Remove()
{
    # Caso exista algum backup, prossegue
    if [ -f "$file_backups" ]
        then
        # Inicializa-se o ID a 1, visto ser a 1ª opção do menu
        let ID=1

        # Vai ler todas as linhas do ficheiro, de forma a que liste todos os backups;
        while read -r line    
        do
            echo "${yellow}$ID) $line${default}"
            let ID++
        done < "$file_backups"

        echo "0) Voltar para o menu principal!"

        # Pede ao utilizador para inserir o backup que pretende remover;
        echo -n "${blue}Insere a tua opção: ${default}"
        read option

        # Caso seja 0, significa que não queremos eliminar, logo será reencaminhado para o menu principal;
        if [ $option -eq 0 ]
            then
                Main_Menu
        else
            # Vai-se buscar a linha que inserimos, que se trata do ficheiro de backup que pretendemos remover;
            filename=$(head -$option "$file_backups" | tail -1)

            # Remove-se o ficheiro backup;
            rm -rf "$PWD/backup/$filename"

            # Caso só haja um dado no ficheiro, este será removido, pois não vale a pena existir
            if [ $(wc -l < "$file_backups") -eq 1 ]
                then
                    rm -rf "$file_backups"
            else
                # Remove o dado registado
                grep -v "$filename" "$file_backups" > in1.txt
                mv -T in1.txt "$file_backups"
            fi
        fi        
    else
        echo "${red}Não existem backups criados neste momento!${default}"
    fi
}

# Restaurar um backup anterior;
Backup_Restore()
{

    # Caso exista algum backup, prossegue
    if [ -f "$file_backups" ]
        then
        # Inicializa-se o ID a 1, visto ser a 1ª opção do menu
        let ID=1

        # Vai ler todas as linhas do ficheiro, de forma a que liste todos os backups;
        while read -r line    
        do
            echo "${yellow}$ID) $line${default}"
            let ID++
        done < "$file_backups"

        echo "0) Voltar para o menu principal!"

        # Pede ao utilizador para inserir o backup que pretende remover;
        echo -n "${blue}Insere a tua opção: ${default}"
        read option

        # Caso seja 0, significa que não queremos eliminar, logo será reencaminhado para o menu principal;
        if [ $option -eq 0 ]
            then
                Main_Menu
        else
            # Vai-se buscar a linha que inserimos, que se trata do ficheiro de backup que pretendemos remover;
            filename=$(head -$option "$file_backups" | tail -1)

            # Como temos de o descomprimir, vamos guardar o nome da sua pasta.
            filename_folder=$(echo $filename | cut -d "." -f 1)

            # Vamos guardar a diretoria onde se encontram os backups todos comprimidos;
            dir_backups="$PWD/backup"

            # Vai-se descomprimir o ficheiro que pretendemos restaurar, em que o resultado ficará na pasta principal
            tar xjvf "$dir_backups/$filename"

            # Vai-se guardar o caminho da diretoria onde se encontra o backup descomprimido;
            dir_uncomp_folder="$PWD/$filename_folder"

            # Move-se todos os ficheiros e diretorias dentro dessa pasta, para a pasta principal;
            cp -r "$dir_uncomp_folder/." "."

            # Remove-se a pasta do antigo backup, pois foi tudo substituído e esta pasta já não é necessária.
            rm -rf "$dir_uncomp_folder"
        fi        
    else
        echo "${red}Não existem backups criados neste momento!${default}"
    fi
}