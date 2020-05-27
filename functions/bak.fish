function bak --description 'Backup file'
    for file in $argv
        cp "$file" "$file.bak"
    end
end
