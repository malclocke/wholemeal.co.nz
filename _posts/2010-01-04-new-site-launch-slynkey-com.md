--- 
layout: post
title: "New site launch: slynkey.com"
created: 1262555516
---
We're pleased to announce a new site release for the new year, the womens magazine and community website <a href="http://slynkey.com/">slynkey.com</a>
<!--break-->
The site development was an interesting project because it involved a large content and user base migration from an existing Joomla! based website.  Whilst we don't usually recommend a platform migration for a site of this size, the platform was proving to be a real problem for the client.

The decision to move to <a href="http://drupal.org/">Drupal</a> was a fairly easy one.  The following aspects of the site made it an excellent choice for Drupal:

<ul>
<li>The site has a very large user base, and has a vibrant community of readers.</li>
<li>The site has a large number of contributing authors, with various levels of access required.</li>
</ul>

<h3>Challenges</h3>

There were a few challenges surrounding the site build.

<h4>Data migration</h4>

The site had a very large user base to import, and a large number of archived articles.  Wholemeal updated <a href="http://drupal.org/project/joomla">an existing Joomla import module</a>, porting it to Drupal 6.x and implementing a lot of new functionality and bug fixes, and submitting the code back to the community which, judging by the <a href="http://drupal.org/project/usage/joomla">project usage statistics</a>, have proved fairly popular (we started working on the module in July 2009).

<h4>Contextual content</h4>

Another challenge was serving contextual content to users, both anonymous and logged in.  The site is highly targeted, with users selecting their home town and being served specific content and advertisements related to their location.  This gives the site a great marketing lead over its competitors, but proved to be a technical challenge.  Thankfully, Drupal provided ample flexibility to solve these challenges.
