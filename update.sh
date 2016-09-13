update_git_repo(){
     local url;
     url=$(git status 2>&1 | grep 'On branch');
     if [ $? -eq 0 ]; then
         git pull upstream master || git pull origin master
     else
     echo "Something went wrong"
     fi;

}

update_svn_repo(){
     local url;
     url=$(svn info 2>&1 | grep 'Relative URL');
     if [ $? -eq 0 ]; then
         svn update
     else
     echo "not svn, trying git"
     update_git_repo
     fi;
 }
export -f update_svn_repo update_git_repo

## $WORKSPACE is a system variable for the workspace where your repos are held, this can be changed to any directory.
cd $WORKSPACE
for d in */ ; do
    cd $d
    update_svn_repo
    cd ..
done
