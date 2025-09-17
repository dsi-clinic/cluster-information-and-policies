---
title: Troubleshooting & FAQ
layout: single
permalink: /faq/
classes: parent-centered
---

This section provides answers to common questions and a snapshot of current cluster specifications.

<style>
.tile-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 1.5rem;
  padding: 2rem 0;
  list-style: none;
  margin: 0;
}

@media (max-width: 1024px) {
  .tile-grid { grid-template-columns: repeat(2, 1fr); }
}
@media (max-width: 600px) {
  .tile-grid { grid-template-columns: 1fr; }
}

.tile {
  display: block;
  padding: 2rem;
  border: 1px solid #ddd;
  border-radius: 8px;
  text-decoration: none;
  color: inherit;
  background-color: #fff;
  transition: transform 0.2s, box-shadow 0.2s;
  height: 100%;
}
.tile:hover {
  transform: translateY(-5px);
  box-shadow: 0 4px 12px rgba(0,0,0,0.1);
  text-decoration: none;
}
.tile h4 { margin-top: 0; color: #800000; }
</style>

{% assign nav_item = site.data.navigation.main | where: "url", page.url | first %}
{% if nav_item.children %}
<div class="tile-grid">
  {% for child in nav_item.children %}
    <a href="{{ child.url | relative_url }}" class="tile">
      <h4>{{ child.title }}</h4>
    </a>
  {% endfor %}
</div>
{% endif %}


