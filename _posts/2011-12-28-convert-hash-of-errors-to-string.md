---
layout: post
title: Convert hash of errors to a string
---

Most of my development recently has been 90% Objective-C/iOS and 10% Ruby.  I stumbled across this while implementing a POST call from our in-development iPhone app to our API written in Ruby using [Grape](https://github.com/intridea/grape).

Using [RestKit](http://restkit.org/) to make the post call, I realized that our API wanted to return a hash that looked like this:

{% highlight js %}
{
  "error": {
    "email":["has already been taken"],
    "password":["is too short (minimum is 8 characters)"]
  }
}
{% endhighlight %}

This confused RestKit as it is simply expecting a string in the error key of the JSON response.  Here's how this cleaned up:

{% highlight ruby %}
  error_message = errors.collect { |k, v| "#{k.capitalize} #{v.to_sentence}. " }.join
  error!({:error => error_message}, 422)
{% endhighlight %}

This allows us to iterate over our errors hash (that has values of arrays of errors) and turn it into something easily readable in a UIAlertView on the iPhone.

The collect method allows us to iterate over the hash and collect an array of values, 1 for each hash element.  Within the collect, we are making sure to capitalize the first letter of our hash key and turn the value into a nice [sentence](http://api.rubyonrails.org/classes/Array.html#method-i-to_sentence) fragment that will be prefixed nicely by the hash key.

Finally, we tell Grape to return the error as a [422 Unprocessable Entity](http://en.wikipedia.org/wiki/List_of_HTTP_status_codes#4xx_Client_Error) which RestKit handles gracefully and we see our error message pop up on the UIAlertView on the iPhone.
