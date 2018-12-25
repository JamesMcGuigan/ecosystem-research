Git Subtree Merging
-------------------

### DOCS
- https://www.atlassian.com/blog/git/alternatives-to-git-submodule-git-subtree

### Importing external github repos as subdirectories
```bash
git remote add -f subtree-awkmath                git@github.com:JamesMcGuigan/awkmath
git remote add -f subtree-tutorial-java8-sandbox git@github.com:JamesMcGuigan/tutorial-java8-sandbox

git remote -v
git checkout                     # Fix: Working tree has modifications

git subtree add --prefix awkmath subtree-awkmath                master --squash
git subtree add --prefix java8   subtree-tutorial-java8-sandbox master --squash

git reset --hard origin/master   # revert subtree changes
```

### Merge changes from upstream repo 
If --squash was used for initial import, then it must be used for all future merges, else | fatal: refusing to merge unrelated histories 
```bash
git subtree pull --prefix awkmath subtree-awkmath master --squash
```

### Pushing changes back to upstream
Use git@github.com: remote urls rather than https:// to permit ssh key logins with: git subtree push 
```bash
git subtree push --prefix awkmath subtree-awkmath master 
```

##  Fixing Broken Git Repos

### Fix: Working tree has modifications.  Cannot add.
```bash
git status                       # this may seem empty
git diff-index HEAD              # but this is not actually empty 
git checkout                     # sometimes this acts as a fix, but not always
git reset --hard                 # clean out any modifications
git reset --hard origin/master   # revert changes back to github
```

### Revert unfixable .git back to github
```bash
# Delete everything and restart - most reliable
cd ..
mv ecosystem-research{,.backup}
git clone git@github.com:JamesMcGuigan/ecosystem-research.git
cd ecosystem-research
rsync -vr --exclude .git ../ecosystem-research.backup/ ./

# Inplace
rm -rf .git
git init
git remote add origin git@github.com:JamesMcGuigan/ecosystem-research.git
git fetch origin
git checkout origin/master -ft
```