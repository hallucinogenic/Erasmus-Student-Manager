# Alterar dados de uma universidade
Change_Universidade()
{
    if [ -f "$file_uni" ]
        then
            Relatorio_Universidades

            echo -n "${blue}Seleciona a Sigla da Universidade que pretendes alterar: ${default}"
            read sigla_uni

            sigla=$(grep ":$sigla_uni:" $file_uni | cut -d : -f 3)

            # Enquanto não estiver, será pedido novamente ao utilizador;
            while [ "$sigla" != "$sigla_uni" ]
            do
                echo "${red}Não existem Universidades com esta Sigla!${default}"
                echo -n "${blue}Insere novamente: ${default}"
                read sigla_uni

                sigla=$(grep ":$sigla_uni:" $file_uni | cut -d : -f 3)
            done

            nome_uni=$(grep ":$sigla_uni:" $file_uni | cut -d : -f 2)
            pais_uni=$(grep ":$sigla_uni:" $file_uni | cut -d : -f 4)
            local_uni=$(grep ":$sigla_uni:" $file_uni | cut -d : -f 5)

            echo "${blue}Dados da Universidade:${default} "
            echo "1) ${yellow}Nome: $nome_uni;${default}"
            echo "2) ${yellow}Sigla: $sigla_uni;${default}"
            echo "3) ${yellow}País: $pais_uni;${default}"
            echo "4) ${yellow}Local: $local_uni;${default}"
            echo -n "${blue}Insere a opção que pretendes alterar: ${default}"
            
            read opcao

            case $opcao in
                1) 
                    # Pede ao utilizador para escrever o novo nome da Universidade;
                    echo -n "${blue}Insere o novo Nome da Universidade: ${default}"
                    read nome_uni_new

                    # Substitui o nome da universidade no ficheiro das universidades;
                    sed -i "s/:$nome_uni:/:$nome_uni_new:/" $file_uni ;;
                2)  
                    # Pede ao utilizador para escrever a nova sigla da Universidade;
                    echo -n "${blue}Insere a nova Sigla da Universidade: ${default}"
                    read sigla_uni_new

                    dir="$PWD/$sigla_uni"
                    dir_new="$PWD/$sigla_uni_new"

                    # Caso exista alguma pasta com essa sigla, será pedido uma nova sigla ao utilizador;
                    while [ -d $dir_new ]
                        do
                            echo "${red}Já existe uma Universidade com essa sigla!${default}"
                            echo -n "${blue}Insere novamente:${default} "
                            read sigla_uni_new
                            didir_newr="$PWD/$sigla_uni"
                    done

                    # Substitui a sigla da universidade no ficheiro das universidades;
                    sed -i "s/:$sigla_uni:/:$sigla_uni_new:/" $file_uni

                    # Cria a diretoria com a nova sigla;
                    mkdir -p $dir_new

                    # Move todo o conteúdo da antiga diretoria com a sigla da faculdade, para a nova diretoria;
                    mv -T $dir $dir_new ;;
                3)  
                    # Pede ao utilizador para escrever o novo local da Universidade;
                    echo -n "${blue}Insere o novo País da Universidade: ${default}"
                    read pais_uni_new

                    # Substitui o local da universidade no ficheiro das universidades;
                    sed -i "s/:$pais_uni/:$pais_uni_new/" $file_uni ;;
                4)  
                    # Pede ao utilizador para escrever o novo local da Universidade;
                    echo -n "${blue}Insere o novo Local da Universidade: ${default}"
                    read local_uni_new

                    # Substitui o local da universidade no ficheiro das universidades;
                    sed -i "s/:$local_uni/:$local_uni_new/" $file_uni ;;
                *) echo "${red}Opção Desconhecida! Tenta outra vez!${default}" ;;
            esac
    fi
}

# Alterar os dados um determinado aluno
Change_Aluno()
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
                            Pais=$(echo $Pais | cut -d "|" -f 1)
                            echo -e "${yellow}$ID)\t$Nome\t$Idade\t$Sexo\t$CC\t$Pais${default}"
                        done < "$dir/$file_student"

                        echo -n "${blue}Seleciona o ID do Aluno que queres alterar: ${default}"
                        read ID


                        # Vai buscar o 
                        nome_student=$(grep "|$ID:" "$sigla/$file_student" | cut -d : -f 2)
                        idade_student=$(grep "|$ID:" "$sigla/$file_student" | cut -d : -f 3)
                        sexo_student=$(grep "|$ID:" "$sigla/$file_student" | cut -d : -f 4)
                        cc_student=$(grep "|$ID:" "$sigla/$file_student" | cut -d : -f 5)
                        pais_student=$(grep "|$ID:" "$sigla/$file_student" | cut -d : -f 6)
                        pais_student=$(echo $pais_student | cut -d "|" -f 1)

                        echo "${blue}Dados do Aluno:${default} "
                        echo "1) ${yellow}Nome: $nome_student;${default}"
                        echo "2) ${yellow}Idade: $idade_student;${default}"
                        echo "3) ${yellow}Sexo: $sexo_student;${default}"
                        echo "4) ${yellow}CC: $cc_student;${default}"
                        echo "5) ${yellow}País: $pais_student;${default}"
                        echo -n "${blue}Insere a opção que pretendes alterar: ${default}"
                        read option

                        case $option in
                            1) 
                                # Pede ao utilizador para escrever o novo nome do aluno;
                                echo -n "${blue}Insere o novo Nome do Aluno: ${default}"
                                read nome_student_new

                                # Substitui o nome do aluno no ficheiro dos alunos;
                                sed -i "s/:$nome_student:/:$nome_student_new:/" "$sigla/$file_student" ;;
                            2)
                                # Pede ao utilizador para escrever a nova idade do Aluno
                                echo -n "${blue}Insere a nova Idade do Aluno: ${default}"
                                read idade_student_new

                                # Substitui a idade do aluno no ficheiro dos alunos
                                sed -i "s/:$idade_student:/:$idade_student_new:/" "$sigla/$file_student" ;;
                            3)
                                # Pede ao utilizador para escrever o novo sexo do Aluno
                                echo -n "${blue}Insere o novo Sexo do Aluno: ${default}"
                                read sexo_student_new

                                # Substitui a idade do aluno no ficheiro dos alunos
                                sed -i "s/:$sexo_student:/:$sexo_student_new:/" "$sigla/$file_student" ;;
                            4)
                                # Pede ao utilizador para escrever o novo CC do Aluno
                                echo -n "${blue}Insere o novo CC do Aluno: ${default}"
                                read cc_student_new

                                cc_aux=$(grep ":$cc_student_new:" "$sigla_uni/$file_student" | cut -d : -f 5)

                                # Verifica se já existe algum aluno com esse CC;
                                while [ "$cc_aux" == "$cc_student_new" ]
                                do
                                    echo "${red}Já existe um aluno com esse cartão de Cidadão!${default}"
                                    echo -n "${blue}Insere novamente: ${default}"
                                    read cc_student_new

                                    cc_aux=$(grep ":$cc_student_new:" "$sigla_uni/$file_student" | cut -d : -f 5)
                                done

                                # Substitui o sexo do aluno no ficheiro dos alunos
                                sed -i "s/:$cc_student:/:$cc_student_new:/" "$sigla/$file_student" ;;
                            5)
                                # Pede ao utilizador para escrever o novo país do Aluno
                                echo -n "${blue}Insere o novo país do Aluno: ${default}"
                                read pais_student_new

                                while [ "$(grep ":$pais_student_new:" $file_uni | cut -d : -f 4)" == "$pais_student_new" ]
                                do
                                    echo "${red}O país não pode ser o mesmo da Universidade!${default}"
                                    echo -n "${blue}Escreve novamente o país do aluno: ${default}"
                                    read pais_student_new
                                done

                                # Substitui o país do aluno no ficheiro dos alunos
                                sed -i "s/:$pais_student|/:$pais_student_new|/" "$sigla/$file_student" ;;
                            
                            *) echo "${red}Opção Desconhecida! Tenta outra vez!${default}" ;;
                        esac

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

# Alterar os dados uma determinada disciplina
Change_Disciplina()
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

            # E só para ficar mais explícito, vamos guardar o nome da universidade em que vamos listar as suas disciplinas;
            nome_uni=$(grep ":$sigla_uni:" $file_uni | cut -d : -f 2)

            dir="$PWD/$sigla"

            # Para verificar se não houve um erro, verificamos se existe a pasta da universidade;
            if [ -d $dir ]
                then
                    # Caso o ficheiro exista, significa que existem disciplinas guardadas;
                    if [ -f "$dir/$file_disc" ]
                        then
                        echo "-----------------------------"
                        echo "------ Lista das Disciplinas -----"
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

                        echo -n "${blue}Seleciona o ID da disciplina que queres alterar: ${default}"
                        read ID


                        # Vai buscar o 
                        nome_disc=$(grep "|$ID:" "$sigla/$file_disc" | cut -d : -f 2)
                        max_alunos_disc=$(grep "|$ID:" "$sigla/$file_disc" | cut -d : -f 3)
                        max_alunos_disc=$(echo $max_alunos_disc | cut -d "|" -f 1)

                        echo "${blue}Dados da Disciplina:${default} "
                        echo "1) ${yellow}Nome: $nome_disc;${default}"
                        echo "2) ${yellow}Nº Máximo de Alunos: $max_alunos_disc;${default}"
                        echo -n "${blue}Insere a opção que pretendes alterar: ${default}"
                        read option

                        case $option in
                            1) 
                                # Pede ao utilizador para escrever o novo nome da disciplina;
                                echo -n "${blue}Insere o novo Nome da Disciplina: ${default}"
                                read nome_disc_new

                                # Substitui o nome da disciplina no ficheiro das disciplinas;
                                sed -i "s/:$nome_disc:/:$nome_disc_new:/" "$sigla/$file_disc" ;;
                            2)
                                # Pede ao utilizador para escrever o novo Nº Máximo de Alunos
                                echo -n "${blue}Insere o novo Nº Máximo de Alunos da Disciplina: ${default}"
                                read max_alunos_disc_new

                                # Substitui o nº máximo de alunos no ficheiro das disciplinas
                                sed -i "s/:$max_alunos_disc|/:$max_alunos_disc_new|/" "$sigla/$file_disc" ;;
                            *) echo "${red}Opção Desconhecida! Tenta outra vez!${default}" ;;
                        esac

                    # Caso contrário, não existem disciplinas atribuídos a esta Universidade
                    else
                        echo "${red}Não existem Disciplinas registadas nesta Universidades!${default}"
                    fi
            else
                echo "${red}A pasta da Universidade não existe!${default}"
            fi
    else
        echo "${red}Não existem Universidades registadas!${default}"
    fi
}

# Alterar os dados um determinado professor
Change_Professor()
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
                            Pais=$(echo $line | cut -d : -f 3)
                            Pais=$(echo $Pais | cut -d "|" -f 1)
                            echo -e "${yellow}$ID)\t$Nome\t$Pais${default}"
                        done < "$dir/$file_prof"

                        echo -n "${blue}Seleciona o ID do Professor que queres alterar: ${default}"
                        read ID


                        # Vai buscar o 
                        nome_prof=$(grep "|$ID:" "$sigla/$file_prof" | cut -d : -f 2)
                        pais_prof=$(grep "|$ID:" "$sigla/$file_prof" | cut -d : -f 3)
                        pais_prof=$(echo $pais_prof | cut -d "|" -f 1)

                        echo "${blue}Dados da Disciplina:${default} "
                        echo "1) ${yellow}Nome: $nome_prof;${default}"
                        echo "2) ${yellow}País Responsável: $pais_prof;${default}"
                        echo -n "${blue}Insere a opção que pretendes alterar: ${default}"
                        read option

                        case $option in
                            1) 
                                # Pede ao utilizador para escrever o novo nome do professor;
                                echo -n "${blue}Insere o novo Nome do Professor: ${default}"
                                read nome_prof_new

                                # Substitui o nome do professor no ficheiro dos professores;
                                sed -i "s/:$nome_prof:/:$nome_prof_new:/" "$sigla/$file_prof" ;;
                            2)
                                # Pede ao utilizador para escrever o novo país que este professor é responsável
                                echo -n "${blue}Insere o novo país que o professor é responsável: ${default}"
                                read pais_prof_new

                                # Substitui o país responsável do professor no ficheiro dos professores
                                sed -i "s/:$pais_prof|/:$pais_prof_new|/" "$sigla/$file_disc" ;;
                            *) echo "${red}Opção Desconhecida! Tenta outra vez!${default}" ;;
                        esac

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