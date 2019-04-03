# Registar Disciplina
Registar_Disciplina_Aluno()
{
    if [ -f "$file_uni" ]
        then
            Relatorio_Universidades

        echo -n "${blue}Seleciona a Sigla da Universidade que pretendes registar a disciplina:${default}"
        read sigla_uni

        # Vai verificar se a sigla existe (para ver se foi inserida sem erros)
        sigla=$(grep ":$sigla_uni:" $file_uni | cut -d : -f 3)

        if [ "$sigla" == "$sigla_uni" ]
            then

                sigla_dir="$PWD/$sigla"

                if [ -d "$sigla_dir" ]
                    then
                        if [ -f "$sigla_dir/$file_disc" ]
                            then
                                echo "-----------------------------"
                                echo "--- Lista das Disciplinas ---"
                                echo "-- $nome_uni --"
                                echo "-----------------------------"
                                    while  read -r line  ;
                                    do
                                        ID_disc=$(echo $line | cut -d : -f 1)
                                        Nome_disc=$(echo $line | cut -d : -f 2)
                                        Max_Alunos_disc=$(echo $line | cut -d : -f 3)
                                        echo -e "${yellow}$ID_disc)\t$Nome_disc\t$Max_Alunos_disc${default}"
                                    done < "$sigla_dir/$file_disc"
                                echo "-----------------------------"

                                echo -n "${blue}Insere o ID da disciplina que pretendemos atribuir: ${default}"
                                read ID_atrib_disc

                                max_aluno_disc_atrib=$(grep "$ID_atrib_disc:" "$sigla_dir/$file_disc" | cut -d : -f 3)
                                nome_disc_atrib=$(grep "$ID_atrib_disc:" "$sigla_dir/$file_disc" | cut -d : -f 2)

                                while [ $(grep -o "$nome_disc_atrib" "$sigla_dir/$file_disc" | wc -l) -eq $max_aluno_disc_atrib ]
                                    do
                                        echo "${red}Esta disciplina já se encontra cheia!${default}"
                                        echo -n "${blue}Escolhe o ID de outra disciplina: ${default}"
                                        read ID_atrib_disc
                                        max_aluno_disc_atrib=$(grep "$ID_atrib_disc:" "$sigla_dir/$file_disc" | cut -d : -f 3)
                                        nome_disc_atrib=$(grep "$ID_atrib_disc:" "$sigla_dir/$file_disc" | cut -d : -f 2)
                                done

                                if [ -f "$sigla_dir/$file_student" ]
                                    then
                                        echo "-----------------------------"
                                        echo "--- Lista dos Alunos ---"
                                        echo "-- ${cyan}$nome_uni${default} --"
                                        echo "-----------------------------"
                                            while  read -r line  ;
                                            do
                                                ID=$(echo $line | cut -d : -f 1)
                                                Nome=$(echo $line | cut -d : -f 2)
                                                Idade=$(echo $line | cut -d : -f 3)
                                                Sexo=$(echo $line | cut -d : -f 4)
                                                CC=$(echo $line | cut -d : -f 5)
                                                Pais=$(echo $line | cut -d : -f 6)
                                                echo -e "${yellow}$ID)\t$Nome\t$Idade\t$Sexo\t$CC\t$Pais${default}"
                                            done < "$sigla_dir/$file_student"
                                        echo "-----------------------------"

                                        echo -n "${blue}Insere o ID do aluno que pretendes atribuir a disciplina: ${default}"
                                        read ID_aluno_atrib

                                        id_ultima_disciplina_atrib=0

                                        # Caso o ficheiro exista, vai-se buscar o ID da última disciplina inserida;
                                        if [ -f "$sigla_uni/$file_disc_student" ]
                                            then
                                                id_ultima_disciplina_atrib=$(tail -1 "$sigla/$file_disc_student" | cut -d : -f 1)
                                                id_ultima_disciplina_atrib=$(echo $id_ultima_disciplina_atrib | cut -d "|" -f 2)
                                        fi

                                        let id_disciplinas_atrib_aux=id_ultima_disciplina_atrib+1

                                        if [ $id_disciplinas_atrib_aux -eq 1 ]
                                            then
                                                echo "|$id_disciplinas_atrib_aux:$ID_aluno_atrib:$ID_atrib_disc|" > in1.txt
                                                mv -T in1.txt "$sigla/$file_disc_student"
                                        # Caso contrário, apenas será incrementado no ficheiro "$file_disc", que se encontra na pasta cujo nome é a Sigla da Universidade;
                                        else
                                            echo "|$id_disciplinas_atrib_aux:$ID_aluno_atrib:$ID_atrib_disc|" >> "$sigla/$file_disc_student"
                                        fi
                                        
                                else
                                    echo "${red}Não existem alunos registados nesta universidade!${default}"
                                fi

                        else
                            echo "${red}Não existem disciplinas registadas!${default}"
                        fi
                else
                    echo "${red}Houve um erro!${default}"
                fi
        else
            echo "${red}Não existem universidades com essa sigla!${default}"
        fi
    else
        echo "${red}Não existem universidades registadas!${default}"
    fi
}

# Registar Disciplina
Registar_Disciplina()
{
    # Caso existam universidades registadas, vamos prosseguir
    if [ -f "$file_uni" ]
        then
            Relatorio_Universidades

        echo -n "${blue}Seleciona a Sigla da Universidade que pretendes registar a disciplina:${default}"
        read sigla_uni

        # Vai verificar se a sigla existe (para ver se foi inserida sem erros)
        sigla=$(grep ":$sigla_uni:" $file_uni | cut -d : -f 3)

        if [ "$sigla" == "$sigla_uni" ]
            then
                sigla_dir="$PWD/$sigla"

                # Caso a diretoria exista, prossiga
                if [ -d $sigla_dir ]
                    then
                        # Por segurança, definimos no início, o último ID da disciplina como 0;
                        id_ultima_disciplina=0

                        # Caso o ficheiro exista, vai-se buscar o ID da última disciplina inserida;
                        if [ -f "$sigla_uni/$file_disc" ]
                            then
                                id_ultima_disciplina=$(tail -1 "$sigla/$file_disc" | cut -d : -f 1)
                                id_ultima_disciplina=$(echo $id_ultima_disciplina | cut -d "|" -f 2)
                        fi
                        
                        echo -n "${blue}Introduz o nome da Disciplina:${default}"
                        read disc_nome

                        echo -n "${blue}Introduz o número máximo de alunos:${default}"
                        read disc_max_alunos

                        let id_disciplinas_aux=id_ultima_disciplina+1

                        # Caso seja a primeira disciplina a ser inserida, será criado um ficheiro temporário e depois será movido
                            # para um ficheiro que se encontra na pasta cujo nome é a Sigla da Universidade (Caso não exista, cria-se automaticamente)
                        if [ $id_disciplinas_aux -eq 1 ]
                            then
                                echo "|$id_disciplinas_aux:$disc_nome:$disc_max_alunos|" > in1.txt
                                mv -T in1.txt "$sigla/$file_disc"
                        # Caso contrário, apenas será incrementado no ficheiro "$file_disc", que se encontra na pasta cujo nome é a Sigla da Universidade;
                        else
                            echo "|$id_disciplinas_aux:$disc_nome:$disc_max_alunos|" >> "$sigla/$file_disc"
                        fi

                        echo "${green} A Disciplina $disc_nome (ID: $id_disciplinas_aux) foi registada com sucesso!${default}"
                else
                    echo "${red}Esta diretoria não existe!${default}"
                fi
        else
            echo "${red}Lamento, mas inseriste uma Sigla que não corresponde a alguma das Universidades registadas!${default}"
        fi
    else
        echo "${red}Não existem Universidades para inserir disciplinas!${default}"
    fi 
}

# Registar Professores Responsáveis
Registar_Professor()
{
    # Caso existam universidades registadas, vamos prosseguir
    if [ -f "$file_uni" ]
        then
            Relatorio_Universidades

        echo -n "${blue}Seleciona a Sigla da Universidade que pretendes registar o professor:${default}"
        read sigla_uni

        # Vai verificar se a sigla existe (para ver se foi inserida sem erros)
        sigla=$(grep ":$sigla_uni:" $file_uni | cut -d : -f 3)

        if [ "$sigla" == "$sigla_uni" ]
            then
                sigla_dir="$PWD/$sigla"

                # Caso a diretoria exista, prossiga
                if [ -d $sigla_dir ]
                    then
                        # Por segurança, definimos no início, o último ID do professor como 0;
                        id_ultimo_professor=0

                        # Caso o ficheiro exista, vai-se buscar o ID do último professor inserido;
                        if [ -f "$sigla_uni/$file_prof" ]
                            then
                                id_ultimo_professor=$(tail -1 "$sigla/$file_disc" | cut -d : -f 1)
                                id_ultimo_professor=$(echo $id_ultimo_professor | cut -d "|" -f 2)
                        fi
                        
                        echo -n "${blue}Introduz o nome do Professor${default}"
                        read prof_nome

                        echo -n "${blue}Introduz a idade do Professor${default}"
                        read prof_idade

                        let id_professores_aux=id_ultimo_professor+1

                        # Caso seja o primeiro professor a ser inserida, será criado um ficheiro temporário e depois será movido
                            # para um ficheiro que se encontra na pasta cujo nome é a Sigla da Universidade (Caso não exista, cria-se automaticamente)
                        if [ $id_professores_aux -eq 1 ]
                            then
                                echo "|$id_professores_aux:$prof_nome:$prof_idade|" > in1.txt
                                mv -T in1.txt "$sigla/$file_prof"
                        # Caso contrário, apenas será incrementado no ficheiro, que se encontra na pasta cujo nome é a Sigla da Universidade;
                        else
                            echo "|$id_professores_aux:$prof_nome:$prof_idade|" >> "$sigla/$file_prof"
                        fi

                        echo "${green}O Professor $prof_nome (ID: $id_professores_aux) foi registado com sucesso!${default}"
                else
                    echo "${red}Esta diretoria não existe${default}!"
                fi
        else
            echo "${red}Lamento, mas inseriste uma Sigla que não corresponde a alguma das Universidades registadas${default}"
        fi
    else
        echo "${red}Não existem Universidades para inserir Professores!${default}"
    fi 
}

# Registar Estudante
Registar_Estudante()
{
    # Caso existam universidades registadas, vamos prosseguir
    if [ -f "$file_uni" ]
        then
            Relatorio_Universidades

        echo -n "${blue}Seleciona a Sigla da Universidade que pretendes registar a disciplina: ${default}"
        read sigla_uni

        # Vai verificar se a sigla existe (para ver se foi inserida sem erros)
        sigla=$(grep ":$sigla_uni:" $file_uni | cut -d : -f 3)

        if [ "$sigla" == "$sigla_uni" ]
            then
                sigla_dir="$PWD/$sigla"

                # Caso a diretoria exista, prossiga
                if [ -d $sigla_dir ]
                    then
                        # Por segurança, definimos no início, o último ID do aluno como 0;
                        id_ultimo_aluno=0

                        # Caso o ficheiro exista, vai-se buscar o ID do último aluno inserido;
                        if [ -f "$sigla_uni/$file_student" ]
                            then
                                id_ultimo_aluno=$(tail -1 "$sigla/$file_student" | cut -d : -f 1)
                                id_ultimo_aluno=$(echo $id_ultimo_aluno | cut -d "|" -f 2)
                        fi
                        
                        echo -n "${blue}Introduz o nome do Aluno: ${default}"
                        read student_nome

                        echo -n "${blue}Introduz a idade do Aluno: ${default}"
                        read student_idade

                        echo "${blue}Introduz o Sexo do Aluno:"
                        echo "F -> Feminino"
                        echo "M -> Masculino${default}"
                        read student_sexo

                        echo -n "${blue}Introduz o nº de Cartão de Cidadão (CC) do aluno: ${default}"
                        read student_cc

                        if [ -f "$sigla_uni/$file_student" ]
                            then
                                # Vai procurar a ver se existe mais algum aluno com o cartão de cidadão;
                                cc_aux=$(grep ":$student_cc:" "$sigla_uni/$file_student" | cut -d : -f 5)

                                # Enquanto não estiver, será pedido novamente ao utilizador;
                                while [ "$cc_aux" == "$student_cc" ]
                                do
                                    echo "${red}Já existe um aluno com esse cartão de Cidadão!${default}"
                                    echo -n "${blue}Insere novamente: ${default}"
                                    read student_cc

                                    cc_aux=$(grep ":$student_cc:" "$sigla_uni/$file_student" | cut -d : -f 5)
                                done
                        fi

                        echo -n "${blue}Seleciona o país do Aluno: ${default}"
                        read student_country

                        while [ $(Check_For_Country "$student_country" "$sigla_uni") -eq 1 ]
                            do
                                echo "${red}O país não pode ser o mesmo da Universidade!${default}"
                                echo -n "${blue}Escreve o país do aluno: ${default}"
                                read student_country
                        done

                        let id_alunos_aux=id_ultimo_aluno+1

                        # Caso seja o primeiro aluno a ser inserido, será criado um ficheiro temporário e depois será movido
                            # para um ficheiro que se encontra na pasta cujo nome é a Sigla da Universidade (Caso não exista, cria-se automaticamente)
                        if [ $id_alunos_aux -eq 1 ]
                            then
                                echo "|$id_alunos_aux:$student_nome:$student_idade:$student_sexo:$student_cc:$student_country|" > in1.txt
                                mv -T in1.txt "$sigla/$file_student"
                        # Caso contrário, apenas será incrementado no ficheiro dos alunos, que se encontra na pasta cujo nome é a Sigla da Universidade;
                        else
                            echo "|$id_alunos_aux:$student_nome:$student_idade:$student_sexo:$student_cc:$student_country|" >> "$sigla/$file_student"
                        fi
                else
                    echo "${red}Esta diretoria não existe!${default}"
                fi
        else
            echo "${red}Lamento, mas inseriste uma Sigla que não corresponde a alguma das Universidades registadas!${default}"
        fi
    else
        echo "${red}Não existem Universidades para inserir disciplinas!${default}"
    fi 
}

# Registar Universidade
Registar_Universidade()
{
    # Por questões de "segurança", cada vez que se regista uma Universidade, o seu número total registadas será igual a 0 
    id_ultima_universidade=0

    # Caso esteja alguma universidade no sistema, vai buscar o ID da última faculdade registada;
    if [ -f "$file_uni" ]
        then
            id_ultima_universidade=$(tail -1 $file_uni | cut -d : -f 1)
            id_ultima_universidade=$(echo $id_ultima_universidade | cut -d "|" -f 2)
    fi

    echo -n "${blue}Introduz o nome da Universidade:${default} "
    read nome_uni

    # Caso o nome da Universidade já se encontre na base de dados, será pedido para inserir novamente o nome;
    while [ $(Universidade_Nome_Repetido "$nome_uni") -eq 1 ]
        do
            echo "${red}Já existe uma Universidade com esse nome!${default}"
            echo -n "${blue}Insere novamente:${default} "
            read nome_uni
    done

    echo -n "${blue}Introduz uma Sigla para a Universidade:${default} "
    read sigla_uni

    
    dir_sigla="$PWD/$sigla_uni"

    # Caso exista alguma pasta com essa sigla, será pedido uma nova sigla ao utilizador;
    while [ -d $dir_sigla ]
        do
            echo "${red}Já existe uma Universidade com essa sigla!${default}"
            echo -n "${blue}Insere novamente:${default} "
            read sigla_uni
            dir_sigla="$PWD/$sigla_uni"
    done

    # Será criada uma pasta com o nome colocado na "Sigla" da Universidade
    mkdir -p $dir_sigla

    echo -n "${blue}Introduz o país dessa Universidade: ${default}"
    read pais_uni


    echo -n "${blue}Introduz a localidade dessa Universidade:${default} "
    read localidade_uni

    # Como será colocada em último lugar, terá um ID incrementado por 1, ao último inserido;
    let id_universidades_aux=id_ultima_universidade+1
    echo "|$id_universidades_aux:$nome_uni:$sigla_uni:$pais_uni:$localidade_uni|" >> $file_uni

    echo "${green}A Universidade \"$nome_uni\" ($sigla_uni) (ID: $id_universidades_aux) foi registada com sucesso!${default}"
}