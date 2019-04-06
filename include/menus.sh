# Menu dos Registos
Registo()
{
    opcao=1
    while [ $opcao -ne 0 ]
    do
        echo "---------------------------------"
        echo "Menu dos Registos:"
        echo "${cyan}1) Universidade${default}"
        echo "${cyan}2) Professor${default}"
        echo "${cyan}3) Estudante${default}"
        echo "${cyan}4) Disciplina${default}"
        echo "${cyan}5) Atribuir Disciplina a Aluno${default}"
        echo "${cyan}0) Voltar para o Menu Principal${default}"
        echo "---------------------------------"
        echo -n "${blue}Introduz a tua escolha: ${default}"
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
        echo "${cyan}1) Criar um Backup${default}"
        echo "${cyan}2) Restaurar um Backup${default}"
        echo "${cyan}3) Apagar um Backup${default}"
        echo "${cyan}0) Voltar para o Menu Principal${default}"
        echo "---------------------------------"
        echo -n "${blue}Introduz a tua escolha: ${default}"
        read opcao

        case $opcao in
            1) Backup_Total ;;
            2) Backup_Restore ;;
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
        echo "${cyan}1) Universidade${default}"
        echo "${cyan}2) Professor${default}"
        echo "${cyan}3) Aluno${default}"
        echo "${cyan}4) Disciplina${default}"
        echo "${cyan}0) Voltar para o Menu Principal${default}"
        echo "---------------------------------"
        echo -n "${blue}Introduz a tua escolha: ${default}"
        read opcao

        case $opcao in
            1) Change_Universidade ;;
            2) Change_Professor ;;
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
        echo "${cyan}1) Listar Universidades${default}"
        echo "${cyan}2) Listar Disciplinas${default}"
        echo "${cyan}3) Listar Alunos${default}"
        echo "${cyan}4) Listar Professores${default}"
        echo "${cyan}5) Listar Disciplinas com alunos Inscritos${default}"
        echo "${cyan}0) Voltar para o Menu Principal${default}"
        echo "---------------------------------"
        echo -n "${blue}Introduz a tua escolha: ${default}"
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
        echo "${cyan}1) Remover Universidades${default}"
        echo "${cyan}2) Remover Professores${default}"
        echo "${cyan}3) Remover Alunos${default}"
        echo "${cyan}4) Remover Disciplinas${default}"
        echo "${cyan}0) Voltar para o Menu Principal${default}"
        echo "---------------------------------"
        echo -n "${blue}Introduz a tua escolha: ${default}"
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
        echo "${cyan}1) Registar Dados${default}"
        echo "${cyan}2) Alterar Dados${default}"
        echo "${cyan}3) Remover Dados${default}"
        echo "${cyan}4) Relatórios${default}"
        echo "${cyan}5) Gestão do(s) Ficheiro(s) de Base de Dados${default}"
        echo "${cyan}0) Sair do Programa${default}"
        echo "---------------------------------"
        echo -n "${blue}Introduz a tua escolha: ${default}"
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