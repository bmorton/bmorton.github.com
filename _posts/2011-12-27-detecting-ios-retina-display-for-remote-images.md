---
layout: post
title: "Off-topic Tuesday: Detecting iOS Retina Display for Remote Images"
---

I feel bad that Today in Ruby's first piece of real content isn't in fact about Ruby, but they don't call this Off-topic Tuesday for nothing!

Today I stumbled across some neat ways to figure out if you're displaying graphics on a mobile device equipped with Apple's Retina display (an iPhone 4 or 4S).  If you're an iOS developer, you're probably aware that you can name files as File.png and File@2x.png and the operating system handles all the magic for you.  Ninety-five percent of the time, that gets you where you need to be.  Here are some solutions to 2 exceptions of this:

* If you're creating a mobile-friendly website, you'll have to add some CSS to add support.

{% highlight css %}
div#Ampersand {
  background: url('AmpersandBurned.png');
  width:43px;
  height:97px;
  float:left;
  -webkit-background-size: 43px 97px;
}

@media screen and (-webkit-device-pixel-ratio: 2) {
  div#Ampersand {
    background: url('AmpersandBurned@2x.png');
    width:43px;
    height:97px;
    float:left;
  }
}
{% endhighlight %}

* If you're loading images remotely through Objective-C, you have to litter your code with this if blocks.

{% highlight objc %}
if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2) {
  // Use high resolution images
} else {
  // Use normal resolution images
}
{% endhighlight %}

Source: [Stack Overflow](http://stackoverflow.com/questions/3652930/high-resolution-images-in-a-uiwebview)