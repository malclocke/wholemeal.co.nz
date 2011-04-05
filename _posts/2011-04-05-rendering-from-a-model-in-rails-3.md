---
layout: post
---
Despite the plethora of advice available on the net to never, ever, ever
render in a model, I still think there are occasional requirements to do
so.

Here's one way to do it in Rails 3:

{% highlight ruby %}
class MyModel < ActiveRecord::Base
  # Use the my_models/_my_model.txt.erb view to render this object as a string
  def to_s
    ActionView::Base.new(Rails.configuration.paths.app.views.first).render(
      :partial => 'my_models/my_model', :format => :txt,
      :locals => { :my_model => self}
    )
  end
end
{% endhighlight %}
