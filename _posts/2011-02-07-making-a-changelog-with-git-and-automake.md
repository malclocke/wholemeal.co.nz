--- 
layout: post
title: Making a ChangeLog with git and automake
created: 1297044084
---
Here's my solution to this, based upon the solution from <a href="http://erikhjortsberg.blogspot.com/2010/06/using-automake-to-generate-changelog.html">Erik Hjortsberg</a>.

This will only get called by `make dist` or `make distcheck` and will only get updated when `configure.ac` gets updated, which is where I increment my release version numbers.

{% highlight make %}
# In the top level Makefile.am
dist-hook: ChangeLog

ChangeLog: configure.ac
    git log --stat --name-only --date=short --abbrev-commit > ChangeLog
{% endhighlight %}
