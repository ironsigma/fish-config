function man --description 'Open man page in a separate konsole'
    if set -q KDE_SESSION_UID
        konsole --separate --hide-menubar --hide-tabbar -e man $argv &
    else
        command man $argv
    end
end

