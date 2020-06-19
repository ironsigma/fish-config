function tig --description 'Execute tig'
    if set -q argv[1]
        command tig $argv
    else
        command tig --all
    end
end
