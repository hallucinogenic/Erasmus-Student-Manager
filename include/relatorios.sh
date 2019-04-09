# Listar Universidades
Relatorio_Universidades()
{
    if [ -f "$file_uni" ]
        then
            echo "-----------------------------"
            echo "-- Lista das Universidades --"
            echo "-----------------------------"
            
            # Vai ler cada linha do ficheiro das universidades;
            # Através disso, vai dividir a linha em 4 "strings", com os devidos dados da universidade;
            while  read -r line  ;
            do
                ID=$(echo $line | cut -d : -f 1)
                ID=$(echo $ID | cut -d "|" -f 2)
                Nome=$(echo $line | cut -d : -f 2)
                Sigla=$(echo $line | cut -d : -f 3)
                Pais=$(echo $line | cut -d : -f 4)
                Localidade=$(echo $line | cut -d : -f 5)
                Localidade=$(echo $Localidade | cut -d "|" -f 1)
                echo -e "${yellow}$ID)\t$Nome\t$Sigla\t$Pais\t$Localidade${default}"
            done < $file_uni

            echo "-----------------------------"
    else
        echo "${red}Não existem Universidades registadas!${default}"
    fi
}

# Listar disciplinas atribuidas a alunos
Relatorio_Disciplinas_Atribuidas()
{
    if [ -f "$file_uni" ]
        then
            Relatorio_Universidades

            echo -n "${blue}Insere a Sigla da Universidade que pretendes saber a lista de Disciplinas atribuidas:${default}"
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

            # E só para ficar mais explícito, vamos guardar o nome da universidade em que vamos listar os seus alunos
            nome_uni=$(grep ":$sigla_uni:" $file_uni | cut -d : -f 2)

            dir="$PWD/$sigla"

            if [ -d $dir ]
                then
                    # Caso o ficheiro exista, significa que existem alunos guardados;
                    if [ -f "$dir/$file_disc_student" ]
                        then

                        cat "$dir/$file_disc_student" | cut -d : -f 3 > in1.txt

                        sort < in1.txt | uniq > in2.txt

                        rm -rf "$PWD/in1.txt"

                        echo "-----------------------------"
                        echo "--- Lista das Disciplinas Atribuidas ---"
                        echo "-- ${cyan}$nome_uni${default} --"
                        echo "-----------------------------"
                        while  read -r line  ;
                            do
                                line=$(echo $line | cut -d "|" -f 1)
                                nome_disc=$(grep "$line:" "$dir/$file_disc" | cut -d : -f 2)

                                grep ":$line|" "$dir/$file_disc_student" | cut -d : -f 3 > in1.txt
                                counter=$(wc -l < in1.txt)
                                echo "Nome: $nome_disc ($counter)"
                        done < in2.txt
                        echo "-----------------------------"

                        rm -rf "$PWD/in1.txt"
                        rm -rf "$PWD/in2.txt"

                    # Caso contrário, não existem alunos atribuídos a esta Universidade
                    else
                        echo "${red}Não existem alunos registados nesta universidade!${default}"
                    fi
            else
                echo "${red}A pasta da Universidade não existe!${default}"
            fi

    else
        echo "${red}Não existem Universidades registadas!${default}"
    fi
}

# Listar Alunos de uma determinada universidade
Relatorio_Alunos()
{
    # Primeiro verifica se existe alguma universidade registada
    if [ -f "$file_uni" ]
        then
            # Para sabermos qual será a Universidade em que o utilizador pretende saber os alunos,
            # será pedido a este a sigla da universidade (será imprimida a lista de universidades para ele selecionar sem erros)
            Relatorio_Universidades

            echo -n "${blue}Insere a Sigla da Universidade que pretendes saber a lista de Alunos:${default}"
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

            # E só para ficar mais explícito, vamos guardar o nome da universidade em que vamos listar os seus alunos
            nome_uni=$(grep ":$sigla_uni:" $file_uni | cut -d : -f 2)

            dir="$PWD/$sigla"

            # Para verificar se não houve um erro, verificamos se existe a pasta da universidade;
            if [ -d $dir ]
                then
                    # Caso o ficheiro exista, significa que existem alunos guardados;
                    if [ -f "$dir/$file_student" ]
                        then
                        echo "-----------------------------"
                        echo "--- Lista dos Alunos ---"
                        echo "-- ${cyan}$nome_uni${default} --"
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
                                Pais=$(echo $Pais | cut -d "|" -f 1)
                                echo -e "${yellow}$ID)\t$Nome\t$Idade\t$Sexo\t$CC\t$Pais${default}"
                            done < "$dir/$file_student"
                        echo "-----------------------------"

                    # Caso contrário, não existem alunos atribuídos a esta Universidade
                    else
                        echo "${red}Não existem alunos registados nesta universidade!${default}"
                    fi
            else
                echo "${red}A pasta da Universidade não existe!${default}"
            fi
    else
        echo "${red}Não existem Universidades registadas!${default}"
    fi
}

# Listar Professores Responsáveis de uma determinada universidade
Relatorio_Professores()
{
    # Primeiro verifica se existe alguma universidade registada
    if [ -f "$file_uni" ]
        then
            # Para sabermos qual será a Universidade em que o utilizador pretende saber os professores,
            # será pedido a este a sigla da universidade (será imprimida a lista de universidades para ele selecionar sem erros)
            Relatorio_Universidades

            echo -n "${blue}Insere a Sigla da Universidade que pretendes saber a lista de Alunos:${default}"
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

            # E só para ficar mais explícito, vamos guardar o nome da universidade em que vamos listar os seus professores
            nome_uni=$(grep ":$sigla_uni:" $file_uni | cut -d : -f 2)

            dir="$PWD/$sigla"

            # Para verificar se não houve um erro, verificamos se existe a pasta da universidade;
            if [ -d $dir ]
                then
                    # Caso o ficheiro exista, significa que existem professores guardados;
                    if [ -f "$dir/$file_prof" ]
                        then
                        echo "-----------------------------"
                        echo "--- Lista dos Professores ---"
                        echo "-- ${cyan}$nome_uni${default} --"
                        echo "-----------------------------"
                            while  read -r line  ;
                            do
                                ID=$(echo $line | cut -d : -f 1)
                                ID=$(echo $ID | cut -d "|" -f 2)
                                Nome=$(echo $line | cut -d : -f 2)
                                Idade=$(echo $line | cut -d : -f 3)
                                Idade=$(echo $Idade | cut -d "|" -f 1)
                                echo -e "${yellow}$ID)\t$Nome\t$Idade${default}"
                            done < "$dir/$file_prof"
                        echo "-----------------------------"

                    # Caso contrário, não existem professores atribuídos a esta Universidade
                    else
                        echo "${red}Não existem professores registados nesta universidade!${default}"
                    fi
            else
                echo "${red}A pasta da Universidade não existe!${default}"
            fi
    else
        echo "${red}Não existem Universidades registadas!${default}"
    fi
}

# Listar Disciplinas de uma determinada universidade
Relatorio_Disciplinas()
{
    if [ -f "$file_uni" ]
        then
            # Para sabermos qual será a Universidade em que o utilizador pretende saber as disciplinas,
            # será pedido a este a sigla da universidade (será imprimida a lista de universidades para ele selecionar sem erros)
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
                                Max_Alunos=$(echo $Max_Alunos | cut -d "|" -f 1)
                                echo -e "${yellow}$ID)\t$Nome\t$Max_Alunos${default}"
                            done < "$dir/$file_disc"
                        echo "-----------------------------"

                    # Caso contrário, não existem disciplinas atribuídas a esta Universidade
                    else
                        echo "${red}Não existem disciplinas registadas nesta universidades!${default}"
                    fi
            else
                echo "${red}A pasta da Universidade não existe!${default}"
            fi

    else
        echo "${red}Não existem universidades registadas!${default}"
    fi
}