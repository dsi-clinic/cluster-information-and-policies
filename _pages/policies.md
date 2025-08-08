---
title: Cluster Policies
layout: single
permalink: /policies/
collection: policies
classes: wide
header:
  overlay_color: "#800000"
  overlay_filter: "0.5"
---

## Cluster Policies

This section contains comprehensive policies governing the use of the DSI cluster. These policies help ensure fair resource allocation, efficient usage, and provide guidelines for adding new hardware to the cluster.

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
  .tile-grid {
    grid-template-columns: repeat(2, 1fr);
  }
}
@media (max-width: 600px) {
  .tile-grid {
    grid-template-columns: 1fr;
  }
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
.tile h4 {
  margin-top: 0;
  color: #800000;
}
</style>

### Policy Categories

- General usage policies and guidelines  
- Storage allocation and quota policies  
- Hardware purchasing and priority access guidelines  
- Lifecycle policies for cluster resources  

<div class="tile-grid">
  {% assign sorted_policies = site.policies | sort: 'title' %}
  {% for policy in sorted_policies %}
    <a href="{{ policy.url | relative_url }}" class="tile">
      <h4>{{ policy.title }}</h4>
    </a>
  {% endfor %}
</div>
