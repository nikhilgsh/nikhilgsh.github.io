---
layout: default
permalink: /blog/
title: blog
nav: true
nav_order: 1
pagination:
  enabled: true
  collection: posts
  permalink: /page/:num/
  per_page: 5
  sort_field: date
  sort_reverse: true
  trail:
    before: 1
    after: 3
---

<div class="post blog-index">
  <header class="post-header">
    <h1 class="post-title">Blog</h1>
  </header>

{% if page.pagination.enabled %}
{% assign postlist = paginator.posts %}
{% else %}
{% assign postlist = site.posts %}
{% endif %}

{% assign posts_by_year = postlist | group_by_exp: 'post', "post.date | date: '%Y'" %}
{% for year in posts_by_year %}

<section class="blog-year-group">
<h2 class="blog-year">{{ year.name }}</h2>
<ul class="post-list">
{% for post in year.items %}
<li>
<h3>
{% if post.redirect == blank %}
<a class="post-title" href="{{ post.url | relative_url }}">{{ post.title }}</a>
{% elsif post.redirect contains '://' %}
<a class="post-title" href="{{ post.redirect }}" target="_blank" rel="noopener noreferrer">{{ post.title }}</a>
{% else %}
<a class="post-title" href="{{ post.redirect | relative_url }}">{{ post.title }}</a>
{% endif %}
</h3>
<p class="post-meta">
{{ post.date | date: '%B %-d, %Y' }}
{% if post.paper %}
&nbsp;·&nbsp; <a href="{{ post.paper }}" target="_blank" rel="noopener noreferrer">Paper</a>
{% endif %}
{% if post.code %}
&nbsp;·&nbsp; <a href="{{ post.code }}" target="_blank" rel="noopener noreferrer">Code</a>
{% endif %}
</p>
</li>
{% endfor %}
</ul>
</section>
{% endfor %}

{% if page.pagination.enabled %}
{% include pagination.liquid %}
{% endif %}

</div>
