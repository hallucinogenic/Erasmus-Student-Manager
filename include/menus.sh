# Menu dos Registos
Registo()
{
    opcao=1
    while [ $opcao -ne 0 ]
    do
        echo "---------------------------------"
        echo "Register's Menu:"
        echo "${cyan}1) University${default}"
        echo "${cyan}2) Professor${default}"
        echo "${cyan}3) Student${default}"
        echo "${cyan}4) Subject${default}"
        echo "${cyan}5) Assign Subject to a Student${default}"
        echo "${cyan}0) Back to Main Menu${default}"
        echo "---------------------------------"
        echo -n "${blue}Insert your choice: ${default}"
        read opcao

        case $opcao in
            1) Registar_Universidade ;;
            2) Registar_Professor ;;
            3) Registar_Estudante ;;
            4) Registar_Disciplina ;;
            5) Registar_Disciplina_Aluno ;;
            0) Main_Menu ;;
            *) echo "${red}Invalid Option! Try again!${default}" ;;
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
        echo "Backup's Menus:"
        echo "${cyan}1) Create a Backup${default}"
        echo "${cyan}2) Restore a Backup${default}"
        echo "${cyan}3) Delete a Backup${default}"
        echo "${cyan}0) Back to Main Menu${default}"
        echo "---------------------------------"
        echo -n "${blue}Insert your choice: ${default}"
        read opcao

        case $opcao in
            1) Backup_Total ;;
            2) Backup_Restore ;;
            3) Backup_Remove ;;
            0) Main_Menu ;;
            *) echo "${red}Invalid Option! Try again!${default}" ;;
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
        echo "Change's Menu:"
        echo "${cyan}1) University${default}"
        echo "${cyan}2) Professor${default}"
        echo "${cyan}3) Student${default}"
        echo "${cyan}4) Subject${default}"
        echo "${cyan}0) Back to Main Menu${default}"
        echo "---------------------------------"
        echo -n "${blue}Insert your choice: ${default}"
        read opcao

        case $opcao in
            1) Change_Universidade ;;
            2) Change_Professor ;;
            3) Change_Aluno ;;
            4) Change_Disciplina ;;
            0) Main_Menu ;;
            *) echo "${red}Invalid Option! Try again!${default}" ;;
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
        echo "List's Menu:"
        echo "${cyan}1) List Universitys${default}"
        echo "${cyan}2) List Subjects${default}"
        echo "${cyan}3) List Students${default}"
        echo "${cyan}4) List Professores${default}"
        echo "${cyan}5) List Subjects com Students Inscritos${default}"
        echo "${cyan}0) Back to Main Menu${default}"
        echo "---------------------------------"
        echo -n "${blue}Insert your choice: ${default}"
        read opcao

        case $opcao in
            1) Relatorio_Universidade ;;
            2) Relatorio_Disciplinas ;;
            3) Relatorio_Alunos ;;
            4) Relatorio_Professores ;;
            5) Relatorio_Disciplinas_Atribuidas ;;
            0) Main_Menu ;;
            *) echo "${red}Invalid Option! Try again!${default}" ;;
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
        echo "Remove's Menu:"
        echo "${cyan}1) Remove Universitys${default}"
        echo "${cyan}2) Remove Professores${default}"
        echo "${cyan}3) Remove Students${default}"
        echo "${cyan}4) Remove Subjects${default}"
        echo "${cyan}0) Back to Main Menu${default}"
        echo "---------------------------------"
        echo -n "${blue}Insert your choice: ${default}"
        read opcao

        case $opcao in
            1) Remove_Universidades ;;
            2) Remove_Professor ;;
            3) Remove_Aluno ;;
            4) Remove_Disciplinas ;;
            0) Main_Menu ;;
            *) echo "${red}Invalid Option! Try again!${default}" ;;
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
        echo "Main Menu:"
        echo "${cyan}1) Regist Data${default}"
        echo "${cyan}2) Change Data${default}"
        echo "${cyan}3) Remove Data${default}"
        echo "${cyan}4) List Data${default}"
        echo "${cyan}5) Backup File's Menu${default}"
        echo "${cyan}0) Exit the program${default}"
        echo "---------------------------------"
        echo -n "${blue}Insert your choice: ${default}"
        read opcao

        case $opcao in
            1) Registo ;;
            2) Alterar ;;
            3) Remove ;;
            4) Relatorios ;; 
            5) Backup ;;
            0) exit ;;
            *) echo "${red}Invalid Option! Try again!${default}" ;;
        esac
    done
}