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

## 3. Email sign-up — Google Form embed

Per your request, the footer's email sign-up is now a **Google Form embed**
instead of a contact form service. To finish wiring it up:

1. Create a form at [forms.google.com](https://forms.google.com).
2. Add one "Short answer" question — e.g. "Email address" — and under that
   question's ⋮ menu, turn on **Response validation → Text → Email address**,
   so it rejects anything that isn't a valid email.
3. Click **Send** (top right) → the **`<>`** embed tab → copy the `src="..."`
   URL out of the `<iframe>` code it gives you.
4. Open `src/_includes/layout.njk`, find the line that says
   `src="https://docs.google.com/forms/d/e/YOUR_FORM_ID/viewform?embedded=true"`,
   and replace it with your real URL.
5. Your form responses collect in a spreadsheet in your Google Drive
   (in the form editor, click the **Responses** tab → the green sheet icon).

**Worth knowing:** a Google Form embed renders inside an iframe with Google's
own styling — white background, Google's fonts — so it won't perfectly match
the rest of the site's look. If that bothers you, an alternative is a plain
button/link ("Sign up for updates") that opens the Google Form in a new tab
instead of embedding it inline; that keeps your site's design fully
consistent at the cost of one extra click for the visitor. Say the word if
you'd like that swapped in instead.

The standalone contact form (name/email/message) has been removed from the
Contact page per your request — that page now just has the phone number,
Square booking link, and address/hours.

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

Since the site no longer uses Netlify's built-in form handling (the sign-up
is now a Google Form embed, and the contact form was removed), you're no
longer tied to Netlify specifically — [Cloudflare Pages](https://pages.cloudflare.com)
works equally well as a free alternative with the same build command and
publish directory, if you'd rather use that instead.

## 5. Things to double check before going live

- **Domain/DNS**: you'll need access to wherever your domain (locusbodyworks.com) is registered — either move it off Squarespace Domains to a registrar like Namecheap/Cloudflare Registrar, or just repoint the DNS records if you keep it registered with Squarespace.
- **Three blog posts contain full third-party poems** ("The Guest House" by Rumi, "What Grief Is Like" by Jennifer Williamson, and "Walk Slowly" by Danna Faulds) — I left the surrounding post structure in place but placeholder text instead of the copyrighted poem text, so you'll want to paste those back in yourself from your current live site (a quick copy-paste) before publishing. See `src/posts/the-guest-house-a-poem.md`, `src/posts/grief-poem.md`, and `src/posts/a-poem-for-the-change-of-spring.md`.
- **Booking/gift cards**: still point at your existing Square links, so nothing changes there.
- **Old blog post URL**: your live site's "Healing Through Consistent Yoga Practice" post has a random-character URL; I gave it a clean one (`/notes/healing-through-consistent-yoga-practice/`) instead. If that old URL is linked anywhere (social media, Google's index), consider adding a redirect from the old URL to the new one so you don't lose any traffic or search ranking to it.
