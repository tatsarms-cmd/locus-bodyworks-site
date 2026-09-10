# Locus Bodyworks — website source

A static rebuild of locusbodyworks.com, built with [Eleventy](https://www.11ty.dev/) (11ty).
Plain HTML/CSS output, no database, no CMS login — cheap to host and easy to keep online.

## 1. First-time setup

You'll need [Node.js](https://nodejs.org/) installed (the free LTS version).

```
npm install
```

### Images — already local, not on Squarespace

All site images live in `src/images/` and are committed to this repo — none
of them are pulled from Squarespace's servers anymore, so cancelling that
subscription won't break anything on this site. `scripts/download-images.sh`
is kept around only as a record of where the originals came from; you don't
need to run it.

### Preview the site locally

```
npm run serve
```

Then open the local address it prints (usually `http://localhost:8080`).

## 2. Add a new blog post (this is the whole workflow)

1. Go to `src/posts/`.
2. Copy any existing `.md` file as a starting point, rename it to your new post's slug, e.g. `src/posts/my-new-post.md`.
3. Edit the top block (the "front matter" between the `---` lines):
   ```
   ---
   layout: post.njk
   title: Your Post Title
   date: 2026-08-01
   excerpt: One or two sentences that show up on the Notes list page.
   image: /images/your-image.jpg       (optional — put the file in src/images/ first)
   category: Poems                     (optional)
   permalink: /notes/my-new-post/
   ---
   ```
4. Write the post underneath in plain text or Markdown (blank line between paragraphs, `**bold**`, `*italic*`, `[link text](https://example.com)`).
5. Save, then either:
   - Run `npm run build` locally and upload the `_site` folder, or
   - If deployed via GitHub (recommended, see below), just commit and push — the host rebuilds automatically in about a minute.

No code, no database — just a text file per post.

## 3. Contact form

The Contact page's form (email/topic/message) submits via Netlify Forms
(see the deploy section below), so responses show up under **Forms** in
your Netlify dashboard once deployed there. Site configuration → Forms →
Form notifications lets you get emailed on every new submission instead
of checking the dashboard manually.

The footer's email sign-up (a Google Form link) was removed per request —
the footer is now just the logo and contact/hours info. If you want a
newsletter sign-up back at some point, `src/_includes/layout.njk`'s
`<footer>` is where it would go.

## 3b. Design update

The whole site's visual language (fonts, colors, buttons, the highlight-wipe
text effect, fade-ins, FAQ accordions) was reskinned to match a new design
mockup, while keeping all the real content, photos, and blog posts already
in this repo. The real logo, the succulents photo on the Yoga page's closing
quote section, and the Ganesha altar photo are all wired in and committed
under `src/images/`.

Also fixed along the way: `src/css/style.css` had somehow ended up
containing a stale copy of the page layout's HTML instead of CSS (so the
site's styling was silently broken) — that's corrected now.

"Notes" was removed from the nav menu (per request) — the `/notes/` listing
page and all the individual posts are untouched and still live at their
URLs, just no longer linked from the header. Easy to re-add a nav link
(`src/_includes/layout.njk`) if you change your mind later.

## 4. Deploying — recommended host: Netlify (free tier)

1. Create a free account at [netlify.com](https://www.netlify.com) and a free [github.com](https://www.github.com) account if you don't have one.
2. Push this folder to a new GitHub repository.
3. In Netlify: **Add new site → Import an existing project → GitHub** → pick the repo.
4. Build settings:
   - Build command: `npx @11ty/eleventy`
   - Publish directory: `_site`
5. Deploy. Netlify gives you a free `*.netlify.app` URL immediately.
6. **Connect your real domain**: Site settings → Domain management → Add a domain → follow the DNS instructions.
7. Netlify auto-provisions free HTTPS (SSL) once the domain is connected.

The Contact page's form uses Netlify's built-in form handling (Netlify
Forms), so this site is now tied to Netlify specifically for that feature —
if you ever move to a different host, you'd need to swap in a different
form backend (e.g. Formspree) for the contact form to keep working.

## 5. Things to double check before going live

- **Domain/DNS**: you'll need access to wherever your domain (locusbodyworks.com) is registered — either move it off Squarespace Domains to a registrar like Namecheap/Cloudflare Registrar, or just repoint the DNS records if you keep it registered with Squarespace.
- **Three blog posts contain full third-party poems** ("The Guest House" by Rumi, "What Grief Is Like" by Jennifer Williamson, and "Walk Slowly" by Danna Faulds) — I left the surrounding post structure in place but placeholder text instead of the copyrighted poem text, so you'll want to paste those back in yourself from your current live site (a quick copy-paste) before publishing. See `src/posts/the-guest-house-a-poem.md`, `src/posts/grief-poem.md`, and `src/posts/a-poem-for-the-change-of-spring.md`.
- **Booking/gift cards**: still point at your existing Square links, so nothing changes there.
- **Old blog post URL**: your live site's "Healing Through Consistent Yoga Practice" post has a random-character URL; I gave it a clean one (`/notes/healing-through-consistent-yoga-practice/`) instead. If that old URL is linked anywhere (social media, Google's index), consider adding a redirect from the old URL to the new one so you don't lose any traffic or search ranking to it.
