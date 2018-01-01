git init
touch foo.txt
git add foo.txt
git commit -m "First"
touch bar.txt
git add bar.txt
git commit -m "Second"
touch cat.txt
git add cat.txt
git commit -m "third"
git log
git checkout HEAD~1
git checkout -b otherbranch
touch otherfile.txt
git add otherfile.txt
git commit -m "commit other branch" otherfile.txt
git log
git checkout master
git log
