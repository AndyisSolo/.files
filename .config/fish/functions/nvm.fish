function nvm
    if test -f ~/.nvm/nvm.sh
        set nvmDir ~/.nvm/nvm.sh
    else
        set nvmDir ~/.config/nvm/nvm.sh
    end

    # if nvmDir exist
    if test -f $nvmDir; and type -qs bass
        bass source $nvmDir --no-use ';' nvm $argv
    end

end
