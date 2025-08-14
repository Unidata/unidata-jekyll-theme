---
title: Annotated Code Blocks
last_updated: 2025-08-14
toc: false
sidebar: unidata_sidebar
permalink: annotated_code_blocks.html
lcb: "{"
---
Code annotations are visual markers inside a code block that can be used to highlight a line of code and referenced outside of the code block for further discussion.
A simplistic way of implementing a code annotation would be something like:

~~~xml
<?xml version='1.0' encoding='UTF-8'?>
<runtimeConfig>
  ...
(1) <configTag attr1='1' attr2='58'>value</configTag>
(2) <otherConfigTag attr1='hello' attr2='goodbye'>another value</otherConfigTag>
  ...
</runtimeConfig>
~~~

* (1) Explanation of `configTag`...
* (2) Explanation of `otherConfigTag`...

which in markdown is simply:

~~~~none
~~~xml
<?xml version='1.0' encoding='UTF-8'?>
<runtimeConfig>
  ...
(1) <configTag attr1='1' attr2='58'>value</configTag>
(2) <otherConfigTag attr1='hello' attr2='goodbye'>another value</otherConfigTag>
  ...
</runtimeConfig>
~~~

* (1) Explanation of `configTag`...
* (2) Explanation of `otherConfigTag`...
~~~~

While this technically "works", it's not very friendly for documentation, as before using the code inside the block, a user must manually:
* remove annotations (e.g. `(1)`, `(2)`)
* fix indentation

Better would be something like this:

{% highlight_with_annotations xml %}
<runtimeConfig>
  ...
  <configTag attr1='1' attr2='58'>value</configTag>{% raw %}{% annotation 1 %}{% endraw %}
  <otherConfigTag attr1='hello' attr2='goodbye'>another value</otherConfigTag>{% raw %}{% annotation 2 %}{% endraw %}
  ...
</runtimeConfig>
{% endhighlight_with_annotations %}

* {% annotation 1 %} Explanation of `configTag`...
* {% annotation 2 %} Explanation of `otherConfigTag`...

which is copy-pastable and retains proper indentation.
This is archived though the `highlight_with_annotations` block:

~~~none
{% raw %}{% highlight_with_annotations xml %}{% endraw %}
<runtimeConfig>
  ...
  <configTag attr1='1' attr2='58'>value</configTag>{{page.lcb}}% raw %}{{page.lcb}}% annotation 1 %}{{page.lcb}}% endraw %}
  <otherConfigTag attr1='hello' attr2='goodbye'>another value</otherConfigTag>{{page.lcb}}% raw %}{{page.lcb}}% annotation 2 %}{{page.lcb}}% endraw %}
  ...
</runtimeConfig>

{% raw %}{% endhighlight_with_annotations %}{% endraw %}

* {% raw %}{% annotation 1 %}{% endraw %} Explanation of `configTag`...
* {% raw %}{% annotation 2 %}{% endraw %} Explanation of `otherConfigTag`...
~~~