---
layout: single
title: Affiliated Research
permalink: /research/
---

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