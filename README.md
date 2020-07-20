git-nflow
========

A collection of Git extensions to provide high-level repository operations
for [new git branching model](https://blog.csdn.net/bingospunky/article/details/105931271).

<img src="https://img-blog.csdnimg.cn/20200505131508750.jpeg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTE2NDc5NjI=,size_16,color_FFFFFF,t_70" alt="git-new-flow分支模型" width="360" height="480" align="bottom" />

Installing git-nflow
-------------------
```
curl -L -O https://raw.githubusercontent.com/binbincivil/git-new-flow/master/contrib/gitnflow-installer.sh
sudo bash gitnflow-installer.sh
```

### Initialization

To initialize a new repo with the basic branch structure, use:

```
git nflow init [-d]
```

This will then interactively prompt you with some questions on which branches
you would like to use as development and test and preview and production branches, and how you
would like your prefixes be named. You may simply press Return on any of
those questions to accept the (sane) default suggestions.

The ``-d`` flag will accept all defaults.


### feature branches

* To list/start feature branches, use:
```
git nflow feature [list] [-v]
git nflow feature start <name> [<base>]
```
  For feature branches, the `<base>` arg must be a commit on `master`.

* To track feature branches, use:
```
git nflow feature track <name>
```
* To push/pull a feature branch to the remote repository, use:
```
git nflow feature push <name>
git nflow feature pull <name>
```
* To merge feature branch into develop/test/preview branch, use:
```
git nflow feature dev [<name|nameprefix>]
git nflow feature test [<name|nameprefix>]
git nflow feature preview [<name|nameprefix>]
```
* To finish feature branches(merge branch into master branch), use:
```
git nflow feature finish [<name|nameprefix>]
```
* To delete feature branches, use:
```
git nflow feature delete [<name|nameprefix>]
```
