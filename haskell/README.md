# Haskell

## Install Ecosystem

```
echo export PATH="$PATH:~/.local/bin"              >> ~/.bash_profile
echo export PATH="$PATH:~/.cabal/bin"              >> ~/.bash_profile
echo export cabal_helper_libexecdir=~/.local/bin/  >> ~/.bash_profile


brew  install ghc cabal-install haskell-stack
stack install hlint phoityne-vscode hspec-discover haskell-dap hoogle
stack build intero  --copy-compiler-tool
stack install happy ghc-mod --resolver lts-8.24  # Broken 
hoogle  # generate hoogle database

cd /usr/local/src/
git clone https://github.com/haskell/haskell-ide-engine --recurse-submodules; 
cd haskell-ide-engine;
stack install
stack install haskell-ide-engine:hie-wrapper
stack install cabal-helper
ln -s ~/.local/bin/hie-8.6.5 ~/.local/bin/hie -vf  # FIX mismatching HIE versions
```

#### Debugging - TODO
```
stack exec intero
stack ghci --with-ghc intero
```

#### VS Code Errors
```
[Error - 2:46:42 AM] haskell-lsp:no handler for. Object (fromList [("jsonrpc",String "2.0"),("params",Object (fromList [("value",String "off")])),("method",String "$/setTraceNotification")])
``` 

## Links

#### Books

Reading:
- [Get Programming with Haskell](https://learning.oreilly.com/library/view/get-programming-with/9781617293764/)

Unread:
- [Haskell Programming from First Principles](http://haskellbook.com/)
- [Getting Started with Haskell Data Analysis](https://learning.oreilly.com/library/view/getting-started-with/9781789802863/)
- [Beginning Haskell: A Project-Based Approach](https://learning.oreilly.com/library/view/beginning-haskell-a/9781430262503/)

#### Courses
- [Professor Frisby Introduces Composable Functional JavaScript](https://egghead.io/courses/professor-frisby-introduces-composable-functional-javascript)

#### Blog Posts
- [How to install Haskell on Mac OS](https://stackoverflow.com/questions/22499433/how-to-install-haskell-on-mac-os)
- [Hello World in Haskell](https://www.devdungeon.com/content/hello-world-haskell)
- [The Evolution of a Haskell Programmer](https://www.willamette.edu/~fruehr/haskell/evolution.html)

#### Deployment - Broken
- https://github.com/zeit/now-examples/pull/55/commits/3a578a130926f30d5e7eb61575a5f9360ee713a0#diff-7ffa443b950cedfb98cc524210cdd596

#### IDE
- [Haskell state of editor/IDE support](https://github.com/rainbyte/haskell-ide-chart)
- Atom: [https://atom.io/packages/ide-haskell]
- IntelliJ: [http://haskforce.com/]


# VS Code Installation
- [https://medium.com/@dogwith1eye/setting-up-haskell-in-vs-code-on-macos-d2cc1ce9f60a]()
- [https://www.vacationlabs.com/haskell/environment-setup.html]()
- [https://github.com/DanielG/ghc-mod/wiki/Installing]()
- [https://github.com/chrisdone/intero/blob/master/TOOLING.md]()


