function pkgs --description 'display fedora-update-check logs'
    journalctl -t fedora-update-check -r $argv;
end
