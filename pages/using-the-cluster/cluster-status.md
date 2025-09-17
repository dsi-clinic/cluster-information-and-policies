---
title: "Cluster Status"
layout: single
nav_order: 2
parent: Using the Cluster
category: using-the-cluster
permalink: /using-the-cluster/cluster-status/
classes: [cluster-status-page]
hide_hero: True
---

# Cluster Status


<style>
.status-tile {
  border: 1px solid #ccc;
  border-radius: 8px;
  padding: 1.5rem;
  background-color: #f9f9f9;
  text-align: center;
  max-width: 600px; /* Keeps the tile from getting too wide on large screens */
  margin-top: 2rem;
  margin-left: auto;
  margin-right: aut
  /* Adds vertical space below the tile, pushing the footer down. 15vh = 15% of the viewport height. Adjust as needed. */
  margin-bottom: 15vh;
  box-shadow: 0 2px 6px rgba(0,0,0,0.1);
}
.status-tile h2 {
  margin-top: 0;
  font-size: 1.5rem;
  color: #800000;
}
.status-tile p {
  font-size: 1rem;
  color: #333;
}
.status-tile a.button {
  display: inline-block;
  margin-top: 1rem;
  padding: 0.6rem 1.2rem;
  background-color: #800000;
  color: white;
  text-decoration: none;
  border-radius: 5px;
  font-weight: bold;
}
.status-tile a.button:hover {
  background-color: #a00000;
}
</style>

<div class="status-tile">
  <h2>Check Live Cluster Status</h2>
  <a class="button" href="https://cluster-status.ds.uchicago.edu/status/uchicago-dsi-cluster" target="_blank">View Dashboard</a>
</div>
