function venv_activate
    
    if test -e venv/bin/activate.fish
        source venv/bin/activate.fish
    else if test -e .venv/bin/activate.fish
        source .venv/bin/activate.fish
    else if test -n "$argv[1]"
        if test -e $argv[1]/bin/activate.fish
            source $argv[1]/bin/activate.fish
        else if test -e ../$argv[1]/bin/activate.fish
            source ../$argv[1]/bin/activate.fish
        else
            printf "No virtual environment found."
        end
    else
        printf "No virtual environment found."
    end
end
