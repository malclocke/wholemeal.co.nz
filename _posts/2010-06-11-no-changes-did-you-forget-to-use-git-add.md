--- 
layout: post
title: No changes - did you forget to use 'git add'?
created: 1276255183
disqus_url: http://wholemeal.co.nz/node/9
---
Generally the error messages from git are fairly helpful, and often guide you
to a resolution.  Occasionally, they're not.

I ran across this little problem today during a rebase.  When a conflict occurs
during a rebase, you are asked to resolve it manually and then use `git
rebase --continue`.

If you decide during the conflict resolution to scrap the checked out branch changes, and just keep the file as-is from the other branch, you may get a little confused.

{% highlight console %}
$ git rebase otherbranch
First, rewinding head to replay your work on top of it...
Applying: This change will create a conflict during rebase
Using index info to reconstruct a base tree...
Falling back to patching base and 3-way merge...
Auto-merging foo.txt
CONFLICT (content): Merge conflict in foo.txt
Failed to merge in the changes.
Patch failed at 0001 Commit message from checked out branch which creates conflict

When you have resolved this problem run "git rebase --continue".
If you would prefer to skip this patch, instead run "git rebase --skip".
To restore the original branch and stop rebasing run "git rebase --abort".
{% endhighlight %}

Ok, have a look at the conflict.

{% highlight console %}
$ cat foo.txt 
<<<<<<< HEAD
Foo
=======
Bar
>>>>>>> Commit message from checked out branch which creates conflict
{% endhighlight %}

Here, <code>HEAD</code> is the other branch version, not the one that is checked out.

I decide I want to keep the 'otherbranch' version and drop all of the changes I've made on the checked out branch

{% highlight console %}
$ echo "Foo" > foo.txt 
$ git rebase --continue
You must edit all merge conflicts and then
mark them as resolved using git add
{% endhighlight %}

Ok, so I need to tell git the conflict is resolved, makes sense.

{% highlight console %}
$ git add foo.txt
$ git rebase --continue
Applying: This change will create a conflict during rebase
No changes - did you forget to use 'git add'?

When you have resolved this problem run "git rebase --continue".
If you would prefer to skip this patch, instead run "git rebase --skip".
To restore the original branch and stop rebasing run "git rebase --abort".
{% endhighlight %}

Huh?!?  No, I didn't forget to use `git add`, I did it ... like ... 2 seconds
ago!

Turns out that because there is no change from the patch git suspects something
has gone wrong.  Git expects a patch to have been applied, but the file has
remained unchanged.

The error message is not very intuitive, but it does contain the answer.  We
just need to tell rebase to skip this patch.  It's also not necessary to fix
the conflict markers in the file.  You will end up with the file version from
the branch you are rebasing on.

{% highlight console %}
$ git rebase --skip
{% endhighlight %}
