---
layout: post
---
`assert_difference` is a really useful assertion baked in to Rails.  It
allows you to check that a value has changed by a given amount after a
block has been executed.

Here's a pretty common use case, check a comment gets created in your
`CommentsControllerTest`:

{% highlight ruby %}
# Make sure one new comment is created
assert_difference 'Comment.count', 1 do
  post :create, :comment => @comment_attributes
end
{% endhighlight %}

You can also check that several different values change by a given amount:

{% highlight ruby %}
# Make sure one new comment and one notification email is created
assert_difference ['Comment.count', 'ActionMailer::Base.deliveries.size'], 1 do
  post :create, :comment => @comment_attributes
end
{% endhighlight %}

But, you cannot check if multiple values change by difference amounts, i.e.
check that 1 comment and 2 notification emails get created.

The following method will allow you to do just that, drop it into
`test/test_helper.rb` and you're away.

{% highlight ruby %}
# Runs assert_difference with a number of conditions and varying difference
# counts.
#
# Call as follows:
#
# assert_differences([['Model1.count', 2], ['Model2.count', 3]])
#
def assert_differences(expression_array, message = nil, &block)
  b = block.send(:binding)
  before = expression_array.map { |expr| eval(expr[0], b) }

  yield

  expression_array.each_with_index do |pair, i|
    e = pair[0]
    difference = pair[1]
    error = "#{e.inspect} didn't change by #{difference}"
    error = "#{message}\n#{error}" if message
    assert_equal(before[i] + difference, eval(e, b), error)
  end
end
{% endhighlight %}
