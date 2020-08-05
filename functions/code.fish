function code --description 'Visual Studo Code'
    if env | grep WSLENV 2>&1 > /dev/null
        "/mnt/c/Users/juanf/AppData/Local/Programs/Microsoft VS Code/Code.exe" $argv
    else
        command code $argv
    end
end
