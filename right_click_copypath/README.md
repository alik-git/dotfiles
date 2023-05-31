# Right Click to Copy Path in Nautilus

## Nautilus scripts
I am using nautilus scripts to do this https://help.ubuntu.com/community/NautilusScriptsHowto

## The Scripts

CopyPath

```bash
#!/bin/bash
echo -n "$(realpath "$1")" | xclip -selection clipboard
```

CopyFolder
```bash
#!/bin/bash
echo -n "${PWD}" | xclip -selection clipboard
```


## REMEMBER TO

MAKE SURE TO MAKE IT EXECUTABLE (`chmod +x CopyPath`)

```bash
chmod +x CopyPath
chmod +x CopyFolder
```

Then restart nautilus with 

```bash
nautilus -q
```

## Make the link 

Make a symlink to the script in the nautilus scripts folder

```bash
ln -s /home/kuwajerw/repos/dotfiles/right_click_copypath/CopyPath /home/kuwajerw/.local/share/nautilus/scripts/CopyPath
ln -s /home/kuwajerw/repos/dotfiles/right_click_copypath/CopyFolder /home/kuwajerw/.local/share/nautilus/scripts/CopyFolder
```
