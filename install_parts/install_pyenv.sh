# To update 
# pyenv update

read -p "Install pyenv? (yes/no)" userResponse
if [ "$userResponse" = 'yes' ]; then

    # Verific daca am packetele instalate
    is_installed="$(package_installed curl)"
    if [[ "$is_installed" == 0 ]]; then
            # is not installed
            echo "curl not installed"
            return
    fi

    curl https://pyenv.run | bash

    # Adaug la .bashrc exporturile
    cat $LOCATION_OF_UTILITIES_FOLDER/configurations/pyenv_insert >> $HOME_FOLDER/.bashrc

fi
