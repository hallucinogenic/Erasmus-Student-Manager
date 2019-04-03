# Remove uma determinada faculdade
Remove_Universidades()
{
    if [ -f "$file_uni" ]
        then
            Relatorio_Universidades

            echo -n "${blue}Seleciona o ID da universidade que queres remover: ${default}"
            read ID

            # Vai verificar se a sigla existe (para ver se foi inserida sem erros)
            sigla=$(grep "|$ID:" $file_uni | cut -d : -f 3)
            nome_uni=$(grep "|$ID:" $file_uni | cut -d : -f 2)


            while [ ! -d "$sigla" ]
            do
                echo "${red}Esta universidade não existe!${default}"
                echo -n "${blue}Insere novamente o ID da Universidade: "
                read ID
            done

            # Chama uma função customizada para apagar o determinado ficheiro
            Remove_Data "" "$file_uni" "$ID"

            uni_dir="$PWD/$sigla"

            # Verifica se a Diretoria existe, para ser apagada
            if [ -d "$uni_dir" ]
                then
                    rm -rf $uni_dir
            fi

            echo "${green} A Universidade \"$nome_uni\" (ID: $ID) foi removida com sucesso!${default}"
    else
        echo "${red} Não existem universidades registadas!${default}"
    fi
}

# Remove um determinado aluno
Remove_Aluno()
{
    if [ -f "$file_uni" ]
        then
            Relatorio_Universidades

            echo -n "${blue}Insere a Sigla da Universidade que pretendes saber a lista de Alunos: ${default}"
            read sigla_uni

            # Vai procurar a ver se a sigla que o utilizador inseriu, se encontra registada na base de dados;
            sigla=$(grep ":$sigla_uni:" $file_uni | cut -d : -f 3)

            # Enquanto não estiver, será pedido novamente ao utilizador;
            while [ "$sigla" != "$sigla_uni" ]
            do
                echo "${red}Não existem Universidades com esta Sigla!${default}"
                echo -n "${blue}Insere novamente: ${default}"
                read sigla_uni

                sigla=$(grep ":$sigla_uni:" $file_uni | cut -d : -f 3)
            done

            # E só para ficar mais explícito, vamos guardar o nome da universidade em que vamos listar os seus alunos;
            nome_uni=$(grep ":$sigla_uni:" $file_uni | cut -d : -f 2)

            dir="$PWD/$sigla"

            # Para verificar se não houve um erro, verificamos se existe a pasta da universidade;
            if [ -d $dir ]
                then
                    # Caso o ficheiro exista, significa que existem alunos guardados;
                    if [ -f "$dir/$file_student" ]
                        then
                        echo "-----------------------------"
                        echo "------ Lista dos Alunos -----"
                        echo "-- $nome_uni --"
                        echo "-----------------------------"
                        
                        while  read -r line  ;
                        do
                            ID=$(echo $line | cut -d : -f 1)
                            ID=$(echo $ID | cut -d "|" -f 2)
                            Nome=$(echo $line | cut -d : -f 2)
                            Idade=$(echo $line | cut -d : -f 3)
                            Sexo=$(echo $line | cut -d : -f 4)
                            CC=$(echo $line | cut -d : -f 5)
                            Pais=$(echo $line | cut -d : -f 6)
                            echo -e "${yellow}$ID)\t$Nome\t$Idade\t$Sexo\t$CC\t$Pais${default}"
                        done < "$dir/$file_student"

                        echo -n "${blue}Seleciona o ID do Aluno que queres remover: ${default}"
                        read ID

                        # Vai verificar se o aluno existe
                        nome_disc=$(grep "$ID:" "$sigla/$file_student" | cut -d : -f 2)

                        Remove_Data "$sigla" "$file_student" "$ID"

                    # Caso contrário, não existem alunos atribuídos a esta Universidade
                    else
                        echo "${red}Não existem Alunos registados nesta Universidades!${default}"
                    fi
            else
                echo "${red}A pasta da Universidade não existe!${default}"
            fi
    else
        echo "${red}Não existem Universidades registadas!${default}"
    fi
}

# Remove um determinado professor
Remove_Professor()
{
    if [ -f "$file_uni" ]
        then
            Relatorio_Universidades

            echo -n "${blue}Insere a Sigla da Universidade que pretendes saber a lista de Professores: ${default}"
            read sigla_uni

            # Vai procurar a ver se a sigla que o utilizador inseriu, se encontra registada na base de dados;
            sigla=$(grep ":$sigla_uni:" $file_uni | cut -d : -f 3)

            # Enquanto não estiver, será pedido novamente ao utilizador;
            while [ "$sigla" != "$sigla_uni" ]
            do
                echo "${red}Não existem Universidades com esta Sigla!${default}"
                echo -n "${blue}Insere novamente: ${default}"
                read sigla_uni

                sigla=$(grep ":$sigla_uni:" $file_uni | cut -d : -f 3)
            done

            # E só para ficar mais explícito, vamos guardar o nome da universidade em que vamos listar os seus professores;
            nome_uni=$(grep ":$sigla_uni:" $file_uni | cut -d : -f 2)

            dir="$PWD/$sigla"

            # Para verificar se não houve um erro, verificamos se existe a pasta da universidade;
            if [ -d $dir ]
                then
                    # Caso o ficheiro exista, significa que existem professores guardados;
                    if [ -f "$dir/$file_prof" ]
                        then
                        echo "-----------------------------"
                        echo "------ Lista dos Professores -----"
                        echo "-- $nome_uni --"
                        echo "-----------------------------"
                        
                        while  read -r line  ;
                        do
                            ID=$(echo $line | cut -d : -f 1)
                            ID=$(echo $ID | cut -d "|" -f 2)
                            Nome=$(echo $line | cut -d : -f 2)
                            Idade=$(echo $line | cut -d : -f 3)
                            Sexo=$(echo $line | cut -d : -f 4)
                            CC=$(echo $line | cut -d : -f 5)
                            Pais=$(echo $line | cut -d : -f 6)
                            echo -e "${yellow}$ID)\t$Nome\t$Idade\t$Sexo\t$CC\t$Pais${default}"
                        done < "$dir/$file_prof"

                        echo -n "${blue}Seleciona o ID do Professor que queres remover: ${default}"
                        read ID

                        # Vai verificar se o professor existe
                        nome_disc=$(grep "$ID:" "$sigla/$file_prof" | cut -d : -f 2)

                        # Chama uma função customizada para apagar o determinado ficheiro
                        Remove_Data "$sigla" "$file_prof" "$ID"

                    # Caso contrário, não existem professores atribuídos a esta Universidade
                    else
                        echo "${red}Não existem Professores registados nesta Universidades!${default}"
                    fi
            else
                echo "${red}A pasta da Universidade não existe!${default}"
            fi
    else
        echo "${red}Não existem Universidades registadas!${default}"
    fi
}

# Remove uma determinada disciplina
Remove_Disciplinas()
{
    if [ -f "$file_uni" ]
        then
            Relatorio_Universidades

            echo -n "${blue}Insere a Sigla da Universidade que pretendes saber a lista de Disciplinas: ${default}"
            read sigla_uni

            # Vai procurar a ver se a sigla que o utilizador inseriu, se encontra registada na base de dados;
            sigla=$(grep ":$sigla_uni:" $file_uni | cut -d : -f 3)

            # Enquanto não estiver, será pedido novamente ao utilizador;
            while [ "$sigla" != "$sigla_uni" ]
            do
                echo "${red}Não existem Universidades com esta Sigla!${default}"
                echo -n "${blue}Insere novamente: ${default}"
                read sigla_uni

                sigla=$(grep ":$sigla_uni:" $file_uni | cut -d : -f 3)
            done

            # E só para ficar mais explícito, vamos guardar o nome da universidade em que vamos listar as suas disciplinas
            nome_uni=$(grep ":$sigla_uni:" $file_uni | cut -d : -f 2)

            dir="$PWD/$sigla"

            # Para verificar se não houve um erro, verificamos se existe a pasta da universidade;
            if [ -d $dir ]
                then
                    # Caso o ficheiro exista, significa que existem disciplinas guardadas;
                    if [ -f "$dir/$file_disc" ]
                        then
                        echo "-----------------------------"
                        echo "--- Lista das Disciplinas ---"
                        echo "-- $nome_uni --"
                        echo "-----------------------------"
                            while  read -r line  ;
                            do
                                ID=$(echo $line | cut -d : -f 1)
                                ID=$(echo $ID | cut -d "|" -f 2)
                                Nome=$(echo $line | cut -d : -f 2)
                                Max_Alunos=$(echo $line | cut -d : -f 3)
                                echo -e "${yellow}$ID)\t$Nome\t$Max_Alunos${default}"
                            done < "$dir/$file_disc"

                    echo -n "${blue}Seleciona o ID da Disciplina que queres remover: ${default}"
                    read ID

                    # Vai verificar se a disciplina existe
                    nome_disc=$(grep "$ID:" "$sigla/$file_disc" | cut -d : -f 2)

                    # Chama uma função customizada para apagar o determinado ficheiro
                    Remove_Data "$sigla" "$file_disc" "$ID"

                    # Caso contrário, não existem disciplinas atribuídas a esta Universidade
                    else
                        echo "${red}Não existem disciplinas registadas nesta universidades!${default}"
                    fi
            else
                echo "${red}A pasta da Universidade não existe!${default}"
            fi
    else
        echo "${red}Não existem Universidades registadas!${default}"
    fi
}