# Locus Bodyworks — website source

A static rebuild of locusbodyworks.com, built with [Eleventy](https://www.11ty.dev/) (11ty).
Plain HTML/CSS output, no database, no CMS login — cheap to host and easy to keep online.

## 1. First-time setup

You'll need [Node.js](https://nodejs.org/) installed (the free LTS version).

```
npm install
```

### Download the images (do this once, before you cancel Squarespace)

The site's images are still hosted on Squarespace's own servers right now, so
they'll break the day that subscription ends. Run this once, from your own
computer, to pull them all down and store them in the project itself:

```
bash scripts/download-images.sh
```

That saves every photo into `src/images/`, already named to match what the
templates expect — nothing else to configure.

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

## 3. Email sign-up — Google Form, linked (not embedded)

The footer's "Sign Up" button links out to a Google Form in a new tab,
styled to match the rest of the site (this replaced the earlier iframe
embed, which couldn't be restyled to match — see "Design update" below).
To finish wiring it up:

1. Create a form at [forms.google.com](https://forms.google.com).
2. Add one "Short answer" question — e.g. "Email address" — and under that
   question's ⋮ menu, turn on **Response validation → Text → Email address**,
   so it rejects anything that isn't a valid email.
3. Click **Send** (top right) → the **link** tab → copy the shareable URL.
4. Open `src/_includes/layout.njk`, find the line with
   `href="https://docs.google.com/forms/d/e/YOUR_FORM_ID/viewform"`,
   and replace it with your real URL.
5. Your form responses collect in a spreadsheet in your Google Drive
   (in the form editor, click the **Responses** tab → the green sheet icon).

The Contact page's standalone form (email/topic/message) is back — it
submits via Netlify Forms (see the deploy section below), so responses
show up under **Forms** in your Netlify dashboard once deployed there.

## 3b. Design update

The whole site's visual language (fonts, colors, buttons, the highlight-wipe
text effect, fade-ins, FAQ accordions) was reskinned to match a new design
mockup, while keeping all the real content, photos, and blog posts already
in this repo. Two spots are still placeholders pending real photos:

- **Yoga page quote section** (`src/yoga.njk`, near the bottom) — currently
  a solid green background. Once you upload a `succulents.png` to
  `src/images/`, follow the comment right above the `.yoga-quote-frame` div
  to swap in the photo background.
- If you'd rather use a different altar/statue photo than the existing
  `yoga-hero.jpeg` on the Yoga page, upload it (e.g. `altar.png`) to
  `src/images/` and swap the filename in `src/yoga.njk`.

Also fixed along the way: `src/css/style.css` had somehow ended up
containing a stale copy of the page layout's HTML instead of CSS (so the
site's styling was silently broken) — that's corrected now.

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
