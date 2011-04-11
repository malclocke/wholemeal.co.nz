---
layout: post
title: find_or_create - Did you find, or create?
---

`find_or_create_by_*` is a great utility in the Rails toolbox.  It allows
you search for an object in the database by an arbitrary field, and if a
matching object is not found, a new one is created.

{% highlight ruby %}
# If a user with the given email address is present in the database, it is
# fetched and returned.  Otherwise, a new one is created and saved.
@user = User.find_or_create_by_email('user@example.com')
{% endhighlight %}

However, there does not appear to find out whether an object was found, or
whether a new one was created.

One solution is to use the related `find_or_initialize_by_*` method, which is
identical, except that is a matching record is found, a new object is returned

{% highlight ruby %}
@user = User.find_or_initialize_by_email("user@example.com")
if @user.new_record?
  # Do whatevahs ...
end
{% endhighlight %}

Here's my solution to doing it with `find_or_create`.  It makes use of the fact
that an optional block can be passed to `find_or_create_by`, which is only
executed when a matching record is **not** found.

{% highlight ruby %}
class User < ActiveRecord::Base
  # A flag to store whether the record was created by find_or_create_by_*
  attr_accessor :was_created
end

@user = User.find_or_create_by_email('user@example.com') do |u|
  u.was_created = true
end

if @user.was_created
  # Do whatevahs
end
{% endhighlight %}

I'd be interested in alternative approaches.
