get_os() {
    for i in $(uname -a)
    do
        os=$i
    done
    echo $i
}
pdir="/usr/bin"
go=$(get_os)
cpmv=cp
if [[ $go == "Android" ]]
then
    pdir="/data/data/com.termux/files/usr/bin"
fi
if [[ $1 == "install" ]]
then
    if [[ $2 == "clean" ]]
    then
        cpmv=mv
    fi
    printf "Copying msleep to $pdir... "
    $cpmv msleep $pdir && echo "done" && \
    printf "Making msleep executable... " && \
    chmod +x $pdir/msleep && echo "done" && \
    echo "Installed"
elif [[ $1 == "uninstall" ]]
then
    if [[ -e $pdir/msleep ]]
    then
        printf "Removing msleep from $pdir... "
        if ! [[ -e $PWD/msleep ]]
        then
            cp $pdir/msleep $PWD
        fi
        rm $pdir/msleep && echo "done" && \
        echo "Uninstalled"
    else
        echo "msleep is not installed"
    fi
else
    echo "setup.sh install         installing"
    echo "setup.sh install clean   installing and removing msleep from $PWD"
    echo "setup.sh uninstall       uninstalling"
fi
