#!/bin/sh

#cd /var/duxd/git-bak

if [ -n "$1" ] ; then
fix=$1
else
fix=old
fi

root_dir=$(pwd)
echo $root_dir
git_list=`find . -type d -name "*\.git" | sort`
for mygit in $git_list
do
#        myproj=$(dirname $mygit)
        myproj=$mygit
        echo $root_dir/$myproj
        cd $root_dir/$myproj
        echo `pwd` > ../$myproj-$fix.log
        git log --reverse  --pretty=format:"%h,%an,%ai,%s" >> ../$myproj-$fix.log
done
cd ${root_dir}

