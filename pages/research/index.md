---
layout: single
title: Affiliated Research
permalink: /research/
classes: parent-centered
---

This page showcases an evolving list of affiliated research projects that have utilized the UChicago DSI Cluster, highlighting current work that benefits from the cluster’s computing resources.

## Publications


{% assign pubs = site.data.publications | sort: "Year" | reverse %}
{% assign years = pubs | map: "Year" | uniq %}

{% for year in years %}
### {{ year }}

{% assign year_pubs = pubs | where: "Year", year %}
{% for pub in year_pubs %}
- <a href="{{ pub.Link }}" target="_blank"><strong>{{ pub.Paper }}</strong></a>  
  <span class="citation">{{ pub.Author_Names }}</span>
{% endfor %}

{% endfor %}