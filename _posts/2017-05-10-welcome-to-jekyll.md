---
layout: post
title:  "Welcome to Jekyll!"
subtitle: "Post example Skeleton Jekyll"
date:   2017-05-10 05:16:01 -0300 
category: [jekyll]
# Add tags to make search easier
tags: ['example','welcome','jekyll']
published: true
comments: true
share: true
excerpted: |
    You’ll find this post in your `_posts` directory. Go ahead and edit it and re-build the site ...

# Does not change and does not remove 'script_js' variables
script_js: [jekyll-search.min.js, post.min.js]

# Events Google Analytics
ga_event: false

# Does not change and does not remove 'script_html' variables
script_html: [search.html]
---

* Table Of Contents
{:toc}

Hi!

You’ll find this post in your `_posts` directory. Go ahead and edit it and re-build the site to see your changes. You can rebuild the site in many different ways, but the most common way is to run `jekyll serve`, which launches a web server and auto-regenerates your site when a file is updated.

To add new posts, simply add a file in the `_posts` directory that follows the convention `YYYY-MM-DD-name-of-post.ext` and includes the necessary front matter. Take a look at the source for this post to get an idea about how it works.

{% fa fa-code|20px %} Jekyll also offers powerful support for code snippets: 

{% highlight ruby %}
def print_hi(name)
  puts "Hi, #{name}"
end
print_hi('Tom')
#=> prints 'Hi, Tom' to STDOUT.
{% endhighlight %}

Check out the [Jekyll docs][jekyll-docs]{:target="_blank"} for more info on how to get the most out of Jekyll. File all bugs/feature requests at [Jekyll’s GitHub repo][jekyll-gh]{:target="_blank"}. If you have questions, you can ask them on [Jekyll Talk][jekyll-talk]{:target="_blank"}.

# Examples
<br>
**Titles with icon - Plugin Fa**

## {% fa fa-table|20px %} Table

First Header | Second Header
------------ | -------------
Content from cell 1 | Content from cell 2
Content in the first column | Content in the second column

## {% fa fa-list|20px %} List

- [x] @mentions, #refs, [links](){:target="_blank"}, **formatting**, and <del>tags</del> supported
- [x] list syntax required (any unordered or ordered list supported)
- [x] this is a complete item
- [ ] this is an incomplete item

* Item 1
* Item 2
  * Item 2a
  * Item 2b

1. Item 1
2. Item 2
3. Item 3
   1. Item 3a
   2. Item 3b

**Notes:**

> We're living the future so
> the present is our past.

## {% fa fa-file-image-o|20px %} Image responsive (plugin Imager)

{% imager example.png|center %}

Lorem ipsum dolor sit amet, consectetur adipisicing elit. Commodi eaque, temporibus quia praesentium dolores repellat minus corporis illo sequi ab numquam laborum blanditiis eveniet. Unde libero ex qui quas temporibus.
Lorem ipsum dolor sit amet, consectetur adipisicing elit. Commodi eaque, temporibus quia praesentium dolores repellat minus corporis illo sequi ab numquam laborum blanditiis eveniet. Unde libero ex qui quas temporibus.
Lorem ipsum dolor sit amet, consectetur adipisicing elit. Commodi eaque, temporibus quia praesentium dolores repellat minus corporis illo sequi ab numquam laborum blanditiis eveniet. Unde libero ex qui quas temporibus.

{% imager example.png|left %}

Lorem ipsum dolor sit amet, consectetur adipisicing elit. Commodi eaque, temporibus quia praesentium dolores repellat minus corporis illo sequi ab numquam laborum blanditiis eveniet. Unde libero ex qui quas temporibus.
Lorem ipsum dolor sit amet, consectetur adipisicing elit. Commodi eaque, temporibus quia praesentium dolores repellat minus corporis illo sequi ab numquam laborum blanditiis eveniet. Unde libero ex qui quas temporibus.
Lorem ipsum dolor sit amet, consectetur adipisicing elit. Commodi eaque, temporibus quia praesentium dolores repellat minus corporis illo sequi ab numquam laborum blanditiis eveniet. Unde libero ex qui quas temporibus.

{% imager example.png|right %}

Lorem ipsum dolor sit amet, consectetur adipisicing elit. Commodi eaque, temporibus quia praesentium dolores repellat minus corporis illo sequi ab numquam laborum blanditiis eveniet. Unde libero ex qui quas temporibus.
Lorem ipsum dolor sit amet, consectetur adipisicing elit. Commodi eaque, temporibus quia praesentium dolores repellat minus corporis illo sequi ab numquam laborum blanditiis eveniet. Unde libero ex qui quas temporibus.
Lorem ipsum dolor sit amet, consectetur adipisicing elit. Commodi eaque, temporibus quia praesentium dolores repellat minus corporis illo sequi ab numquam laborum blanditiis eveniet. Unde libero ex qui quas temporibus.
Commodi eaque, temporibus quia praesentium dolores repellat minus corporis illo sequi ab numquam laborum blanditiis eveniet. Unde libero ex qui quas temporibus.  

<br>
<br>

{% label Ruby|10px %}
{% label HTML5|20px %}
{% label CSS3|30px %}
{% label JQuery|40px %}

<br>
<br>

## Code in one line - Text

`Featured`

## Unlighted code

``` javascript
function fancyAlert(arg) {
  if(arg) {
    $.facebox({div:'#foo'})
  }
}
```

[jekyll-docs]: https://jekyllrb.com/docs/home 
[jekyll-gh]:   https://github.com/jekyll/jekyll
[jekyll-talk]: https://talk.jekyllrb.com/

<br>

Goodbye! :wink:

{% endpost #9D9D9D %}
