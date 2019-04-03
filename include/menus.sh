# Menu dos Registos
Registo()
{
    opcao=1
    while [ $opcao -ne 0 ]
    do
        echo "---------------------------------"
        echo "Menu dos Registos:"
        echo "1) Universidade"
        echo "2) Professor"
        echo "3) Estudante"
        echo "4) Disciplina"
        echo "5) Atribuir Disciplina a Aluno"
        echo "0) Voltar para o Menu Principal"
        echo "---------------------------------"
        echo -n "Introduz a tua escolha: "
        read opcao

        case $opcao in
            1) Registar_Universidade ;;
            2) Registar_Professor ;;
            3) Registar_Estudante ;;
            4) Registar_Disciplina ;;
            5) Registar_Disciplina_Aluno ;;
            0) Main_Menu ;;
            *) echo "${red}Opção Desconhecida! Tenta outra vez!${default}" ;;
        esac
    done
}

# Menu dos Backups
Backup()
{
    opcao=1
    while [ $opcao -ne 0 ]
    do
        echo "---------------------------------"
        echo "Menu dos Backups:"
        echo "1) Criar um Backup"
        echo "2) Restaurar um Backup"
        echo "3) Apagar um Backup"
        echo "0) Voltar para o Menu Principal"
        echo "---------------------------------"
        echo -n "Introduz a tua escolha: "
        read opcao

        case $opcao in
            1) Backup_Total ;;
            2) echo "${blue}Esta opção encontra-se em beta!${default}" ;;
            3) Backup_Remove ;;
            0) Main_Menu ;;
            *) echo "${red}Opção Desconhecida! Tenta outra vez!${default}" ;;
        esac
    done
}

# Menu das Alterações
Alterar()
{
    opcao=1
    while [ $opcao -ne 0 ]
    do
        echo "---------------------------------"
        echo "Menu das Alterações:"
        echo "1) Universidade"
        echo "2) Professor"
        echo "3) Aluno"
        echo "4) Disciplina"
        echo "0) Voltar para o Menu Principal"
        echo "---------------------------------"
        echo -n "Introduz a tua escolha: "
        read opcao

        case $opcao in
            1) Change_Universidade ;;
            2) echo "${blue}Esta opção encontra-se em beta!${default}" ;;
            3) Change_Aluno ;;
            4) Change_Disciplina ;;
            0) Main_Menu ;;
            *) echo "${red}Opção Desconhecida! Tenta outra vez!${default}" ;;
        esac
    done
}

# Menu dos Relatórios
Relatorios()
{
    opcao=1
    while [ $opcao -ne 0 ]
    do
        echo "---------------------------------"
        echo "Menu dos Relatórios:"
        echo "1) Listar Universidades"
        echo "2) Listar Disciplinas"
        echo "3) Listar Alunos"
        echo "4) Listar Professores"
        echo "5) Listar Disciplinas com alunos Inscritos"
        echo "0) Voltar para o Menu Principal"
        echo "---------------------------------"
        echo -n "Introduz a tua escolha: "
        read opcao

        case $opcao in
            1) Relatorio_Universidades ;;
            2) Relatorio_Disciplinas ;;
            3) Relatorio_Alunos ;;
            4) Relatorio_Professores ;;
            5) Relatorio_Disciplinas_Atribuidas ;;
            0) Main_Menu ;;
            *) echo "${red}Opção Desconhecida! Tenta outra vez!${default}" ;;
        esac
    done
}

# Menu dos Relatórios
Remove()
{
    opcao=1
    while [ $opcao -ne 0 ]
    do
        echo "---------------------------------"
        echo "Menu das Remoções:"
        echo "1) Remover Universidades"
        echo "2) Remover Professores"
        echo "3) Remover Alunos"
        echo "4) Remover Disciplinas"
        echo "0) Voltar para o Menu Principal"
        echo "---------------------------------"
        echo -n "Introduz a tua escolha: "
        read opcao

        case $opcao in
            1) Remove_Universidades ;;
            2) Remove_Professor ;;
            3) Remove_Aluno ;;
            4) Remove_Disciplinas ;;
            0) Main_Menu ;;
            *) echo "${red}Opção Desconhecida! Tenta outra vez!${default}" ;;
        esac
    done
}

# Menu Principal do Programa;
Main_Menu()
{
    opcao=1
    while [ $opcao -ne 0 ]
    do
        echo "---------------------------------"
        echo "Menu Principal:"
        echo "1) Registar Dados"
        echo "2) Alterar Dados"
        echo "3) Remover Dados"
        echo "4) Relatórios"
        echo "5) Gestão do(s) Ficheiro(s) de Base de Dados"
        echo "0) Sair do Programa"
        echo "---------------------------------"
        echo -n "Introduz a tua escolha: "
        read opcao

        case $opcao in
            1) Registo ;;
            2) Alterar ;;
            3) Remove ;;
            4) Relatorios ;; 
            5) Backup ;;
            0) exit ;;
            *) echo "${red}Opção Desconhecida! Tenta outra vez!${default}" ;;
        esac
    done
}