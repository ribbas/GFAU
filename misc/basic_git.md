# Basic Git

Here are the basic usages of git that we'll most likely be using a lot over the year. These are primarily based on experience on Linux machines - if you're on a Windows, tough luck! Try something with the Git GUI.

Why is this necessary? Because it is currently the fourth week of school, and we are currently juggling 3 versions of `contract.tex` from 3 people. I am having to resolve the conflicts on my end - so to prevent this in the future, please refer to at least some of the steps below.

## Local Copy
Make sure to have Git installed and configured at first. Then, clone the repo:<br>
`git clone https://github.com/sabbirahm3d/GFAU`

This should only have to be done once to have a local copy of the repo on your machine.

## First Usage

Branching versions will definitely be necessary. Type in: `git branch` to make sure you're on master after cloning the repo.

You need to make your own branch to contribute your changes, otherwise things will get very messy later in the year when we each have 10 different files that may or may not overlap each other.

Type in `git checkout -b <YOUR-BRANCH-NAME>` to create and switch over to your branch. You can now add/delete/modify whatever you want on this branch. To make sure you are on the correct branch, just type `git branch`.
Once you've made changes to files in your branch, go ahead and add them:<br>

`git add <FILENAME1> <FILENAME2> <DIR1> <DIR2>`  # for adding the individual files you worked on (recommended)<br>
or `git add -A`  # to add all changes you've made to your branch

Once you're satisfied with the changes you've made, go ahead and commit:<br>
`git commit -m "<YOUR MESSAGE>"`<br>
or `git commit -am "<YOUR MESSAGE>"`  # for adding and commiting on the files that are already on the tree in one command

Your branch should now be updated with your changes. You can make as many commits as you wish without pushing. When you are ready to push upstream, type: `git push origin <YOUR-BRANCH-NAME>`.<br>
**BE CAREFUL OF THE BRANCH NAME: accidentally typing in `git push origin :<YOUR-BRANCH-NAME>` (with a ':' in front of the branch name) will forcefully delete your branch from the tree without warning.**<br>
You will now be able to see your branch on GitHub updated with all your changes.


## Everyday Usage

When you are getting ready to contribute, there are some checks you should go through to make sure you don't cause any conflicts with the other branches.<br>
  - `git branch` to make sure you are on the branch you want to be in
  - `git fetch origin <YOUR-BRANCH-NAME>` to make sure no one else made changes to your branch while you were sleeping
  - `git checkout master` then `git pull origin master` to bring your local copy of master up to date

## Troubleshooting

If you accidentally made changes to files while you're on master, either abort all changes: `git checkout .` or stash your changes and wait for someone else to inspect the issue `git stash`

## Merging

**NEVER EVER EVER contribute directly to master**.


If you want to be held responsible for **everyone's hard work of 4000+ hours and 3 million lines of code**, you can go ahead and merge your changes **SAFELY** with master.


You can compare your changes with master, just in case someone else has already made a change there:<br>
`git diff --name-status <YOUR-BRANCH-NAME>..master`


If you see that the changes **SHOULD NOT** cause any conflicts, go ahead and switch over to master: `git checkout master`. Compare your local copy to the upstream master: `git fetch origin master`. If you see that your HEAD is not aligned, you will definitely need to pull the changes `git pull origin master`.<br>
Then, merge your branch to master: **NOTE THAT YOU HAVE TO BE ON MASTER FOR THIS**<br>
`git merge <YOUR-BRANCH-NAME>`


If you don't see any error messages, congratulations, you will not receive any passive-aggressive messages from the other 3 members. Then push `git push origin master`


If you do see errors, stop what you are doing and rethink about your purpose in life. Abort your changes, and move away from the repo before causing any further harm.


If you don't want to be in responsible for all that, just ask another member to merge your branch for you. Yes, anyone can merge any branches, this is a democracy.

## Summary

Just make changes to the files in your branch. Once you are certain that the updates need to be pushed to master, inform the team to make sure no one else is working on the same files. Push your changes, then merge them.
