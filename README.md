# Ostwald Lab website

Built with [Quarto](https://quarto.org) and published on GitHub Pages. Every push to `main` rebuilds and publishes the site automatically.

## First-time setup (once)

1. Put this folder somewhere permanent (e.g. Documents/GitHub/lab-website).
2. In GitHub Desktop: File > Add Local Repository, choose this folder, click "create a repository", set Git ignore and License to None, and click Create Repository.
3. Click Publish repository and untick "Keep this code private".
4. On github.com, open the repo and go to Settings > Pages. Under "Build and deployment", set Source to "GitHub Actions".
5. Go to the Actions tab, click "Publish site", then "Run workflow". After a couple of minutes, the site address appears under Settings > Pages.

From then on, every push to `main` republishes the site automatically. No command line needed.

## Custom domain (optional)

1. Buy a domain (e.g. ostwaldlab.org) from any registrar.
2. Create a file called `CNAME` in this folder containing only the domain name.
3. Uncomment the `resources:` lines in `_quarto.yml`.
4. Follow GitHub's guide to point the domain's DNS at GitHub Pages, then enter the domain under Settings > Pages.

## Everyday updates

These can all be done in the GitHub web editor, without installing anything.

**Add yourself to the People page**

1. Copy `people/_template.qmd` to `people/your-name.qmd`.
2. Fill in your details and set `group:` (for example `PhD`).
3. Upload a square photo (at least 600px, under 300 KB) to `images/` and point `image:` at it.

**Post news**

1. Create a folder `posts/YYYY-MM-DD-short-title/`.
2. Inside it, add `index.qmd` with a title, date, description and categories (copy an existing post).
3. Put any images for the post in the same folder.

**Add or change the home page video**

Save the video as `images/hero.mp4` (MP4, muted, 10 to 20 seconds, about 1920px wide, ideally under 10 MB) and a still frame as `images/hero-poster.jpg`. Edit the caption in `index.qmd`.

**Update publications**

Export your publications as BibTeX from Zotero, ORCID or Google Scholar and replace the contents of `references.bib`.

## Structure

```
_quarto.yml        site settings and navigation
index.qmd          home page: video, about us, latest news
research.qmd       research
people.qmd         people listings (one file per person in people/)
publications.qmd   generated from references.bib
contact.qmd        contact details and opportunities
news.qmd           full news archive (posts in posts/), linked from the home page
styles/            colours, fonts and layout
images/            shared images and the home page video
```
