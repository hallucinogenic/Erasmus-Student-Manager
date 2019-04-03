#!/bin/bash
#some stuff

# Devido a haver vários "custom includes", será necessário guardar a diretoria;
include_dir="$PWD/include"

# Caso a pasta dos includes exista, vamos verificar se estão todos na mesma pasta;
if [ -d $include_dir ]
    then
        # Neste caso, se existirem todos os includes, vai-se buscar toda a sua informação e será aberto o Menu Principal;
        if [ -f "$include_dir/globals.sh" ] && [ -f "$include_dir/menus.sh" ] && [ -f "$include_dir/backup.sh" ] && [ -f "$include_dir/change.sh" ] && [ -f "$include_dir/register.sh" ] && [ -f "$include_dir/relatorios.sh" ] && [ -f "$include_dir/custom_functions.sh" ] && [ -f "$include_dir/remove.sh" ] ;
            then
                source "$include_dir/globals.sh"
                source "$include_dir/custom_functions.sh"
                source "$include_dir/backup.sh"
                source "$include_dir/relatorios.sh"
                source "$include_dir/remove.sh"
                source "$include_dir/register.sh"
                source "$include_dir/change.sh"
                source "$include_dir/menus.sh"
                Main_Menu
            # Caso não exista um dos ficheiros , não vale a pena continuar a usar o programa;
            else
                echo "Algum include não existe na pasta \"includes\"! Programa vai fechar!"
                exit
        fi
# Caso não exista esta pasta, não vale a pena continuar a usar o programa;
else
    echo "Os ficheiros \"includes\" não existem nesta pasta! Programa vai fechar!"
    exit
fi