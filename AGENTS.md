# UChicago DSI Cluster Information Site

## Project Overview
Jekyll-based documentation website for the University of Chicago Data Science Institute's GPU cluster. Provides information about cluster resources, policies, tools, and usage guidelines.

- **Live site**: https://cluster-policy.ds.uchicago.edu/
- **Deployment**: GitHub Pages (automatic on push to main)

## Technology Stack
- Jekyll 4.3.2 with Minimal Mistakes theme
- Ruby 3.1 via Docker
- Docker + Make workflow

## Development Workflow

**All development must go through Make/Docker. Never run Jekyll directly.**

```bash
make build    # Build Docker image
make serve    # Dev server at http://localhost:4000
make inter    # Interactive shell in container
make trace    # Build with debug/trace output
make clean    # Remove Docker resources
make rebuild  # Full clean + build + serve
```

## Site Structure

### Content Locations
| Directory | Purpose |
|-----------|---------|
| `_pages/` | Main site pages |
| `_policies/` | Usage guidelines and purchasing policies |
| `_resources/` | Cluster information and monitoring |
| `_tools/` | Tool documentation (e.g., dsiquota) |
| `pages/quickstart/` | Account setup, SSH, client tools |
| `pages/using-the-cluster/` | Environments, containers, batch jobs |
| `pages/advanced-topics/` | CUDA changes, file transfers |
| `pages/faq/` | Troubleshooting and common errors |
| `pages/contact/` | Contact information |
| `pages/research/` | Affiliated research |

### Configuration
| File | Purpose |
|------|---------|
| `_config.yml` | Main Jekyll configuration |
| `_config_local.yml` | Local development overrides |
| `_data/navigation.yml` | Site navigation structure |
| `_data/publications.csv` | Research publications data |

### Layouts and Templates
| Directory | Purpose |
|-----------|---------|
| `_layouts/` | Page layout templates (home, single, collection, splash) |
| `_includes/` | Reusable template fragments |
| `assets/` | CSS, images, static assets |

## Content Conventions

- Pages use `single` layout with sidebar navigation
- Frontmatter includes: `title`, `layout`, `permalink`, `classes`, `nav_order`, `parent`, `category`
- Some pages use `toc: true` with `toc_sticky: true` for table of contents
- Header overlays use UChicago maroon: `#800000`
- Navigation is managed centrally in `_data/navigation.yml`
- Jekyll collections: `resources`, `policies`, `tools`, `howto`

## Adding / Editing Content

1. Create or edit markdown files in the appropriate directory
2. Include proper frontmatter (see existing pages for patterns)
3. Update `_data/navigation.yml` if adding to main navigation
4. Test with `make serve`
5. Push to main to deploy

## Dependencies
Key gems: jekyll (~> 4.3.2), minimal-mistakes-jekyll, jekyll-sitemap, jekyll-feed, jekyll-paginate, webrick, sass-embedded. See `Gemfile` for full list.

## Landing the Plane (Session Completion)

**When ending a work session**, you MUST complete ALL steps below. Work is NOT complete until `git push` succeeds.

**MANDATORY WORKFLOW:**

1. **File issues for remaining work** - Create issues for anything that needs follow-up
2. **Run quality gates** (if code changed) - Tests, linters, builds
3. **Update issue status** - Close finished work, update in-progress items
4. **PUSH TO REMOTE** - This is MANDATORY:
   ```bash
   git pull --rebase
   bd sync
   git push
   git status  # MUST show "up to date with origin"
   ```
5. **Clean up** - Clear stashes, prune remote branches
6. **Verify** - All changes committed AND pushed
7. **Hand off** - Provide context for next session

**CRITICAL RULES:**
- Work is NOT complete until `git push` succeeds
- NEVER stop before pushing - that leaves work stranded locally
- NEVER say "ready to push when you are" - YOU must push
- If push fails, resolve and retry until it succeeds

<!-- BEGIN BEADS INTEGRATION v:1 profile:minimal hash:ca08a54f -->
## Beads Issue Tracker

This project uses **bd (beads)** for issue tracking. Run `bd prime` to see full workflow context and commands.

### Quick Reference

```bash
bd ready              # Find available work
bd show <id>          # View issue details
bd update <id> --claim  # Claim work
bd close <id>         # Complete work
```

### Rules

- Use `bd` for ALL task tracking — do NOT use TodoWrite, TaskCreate, or markdown TODO lists
- Run `bd prime` for detailed command reference and session close protocol
- Use `bd remember` for persistent knowledge — do NOT use MEMORY.md files

## Session Completion

**When ending a work session**, you MUST complete ALL steps below. Work is NOT complete until `git push` succeeds.

**MANDATORY WORKFLOW:**

1. **File issues for remaining work** - Create issues for anything that needs follow-up
2. **Run quality gates** (if code changed) - Tests, linters, builds
3. **Update issue status** - Close finished work, update in-progress items
4. **PUSH TO REMOTE** - This is MANDATORY:
   ```bash
   git pull --rebase
   bd dolt push
   git push
   git status  # MUST show "up to date with origin"
   ```
5. **Clean up** - Clear stashes, prune remote branches
6. **Verify** - All changes committed AND pushed
7. **Hand off** - Provide context for next session

**CRITICAL RULES:**
- Work is NOT complete until `git push` succeeds
- NEVER stop before pushing - that leaves work stranded locally
- NEVER say "ready to push when you are" - YOU must push
- If push fails, resolve and retry until it succeeds
<!-- END BEADS INTEGRATION -->
