--- 
layout: post
title: Active Resource - Associations and Nested Resources
created: 1268004483
disqus_url: http://wholemeal.co.nz/node/7
---
I've been working on a <a href="http://github.com/malclocke/pivotal_tracker">wrapper library</a> for the <a href="http://www.pivotaltracker.com/">Pivotal Tracker</a> API, and found it difficult to find a single source of documentation on how to map deep nested restful Rails routes into ARes classes.

Using the classic 'Blog posts' and 'Comments' as an example, you have RESTful URL's like these to work with:

    /posts
    /posts/1
    /posts/1/comments
    /posts/1/comments/1

The documentation is a little hazy on how you map these, in particular the 'comments', in ARes.

After a little poking around, I've come up with the following solution:

{% highlight ruby %}
class Post < ActiveResource::Base
  self.site = "http://site.com/"

  def comments(scope = :all)
    Comment.find(scope, :params => {:post_id => self.id})
  end

  def comment(id)
    comments(id)
  end
end

class Comment < ActiveResource::Base
  # :post_id gets swapped out by ARes based on the :prefix_options hash
  self.site = "http://site.com/posts/:post_id"

  def post
    Post.find(self.prefix_options[:post_id])
  end

  def post=(post)
    self.prefix_options[:post_id] = post.id
  end
end
{% endhighlight %}

You can then use these classes like this:

{% highlight ruby %}
# Find post id 1
post = Post.find(1)

# Find all comments for a post
post.comments.each { |comment| puts comment.body }

# Find comment id 1 for a post
comment = post.comment(1)

# Create a new comment and assign it to a post
comment = Comment.new :body => body_text
comment.post = post
comment.save
{% endhighlight %}

The key to all this is the `:prefix_options` hash, which is not very well documented, and allows you to create the 'belongs_to' relationship which nested resources typically represent in a Rails app.
