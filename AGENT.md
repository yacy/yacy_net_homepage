# AGENT.md

## YaCy Homepage Privacy Policy (Repository Rule)

This repository contains the YaCy homepage and documentation site.

- It is a web page built with the `mkdocs` builder framework.
- It uses the `cinder-superhero` template.
- User requests should be handled by the same YaCy server to preserve user privacy.
- The site is intended to grow as a documentation framework.

## Privacy Requirement: No External Automatic Loads

To protect user privacy, this project must not automatically load resources from external servers.

- No CDN usage anywhere (`No CDNs`).
- No externally hosted JavaScript, CSS, fonts, images, or other assets loaded automatically.
- No third-party trackers, analytics scripts, tag managers, or remote embeds.
- No automatic requests to external URLs during page load or normal site navigation.

## Implementation Rule

All required assets must be stored in this repository and served locally by the YaCy-hosted site.

- If a library or asset is needed, vendor it locally instead of linking to an external URL.
- Do not add `<script>`, `<link>`, `<img>`, `@import`, font, or fetch/XHR calls to external domains for automatic loading.
- Changes must preserve the principle that browsing the site does not leak user activity to third-party servers.

## Build Output and Validation Rule

The real generated web page is created in `site/` after running `mkdocs build`.

- Treat `site/` as the actual rendered output to inspect after changes.
- Automatic code generation with coding agents shall run `mkdocs build` to identify and verify the page(s) actually generated in the `site` path.
- After automated builds, every generated HTML file in `site/` shall be checked to be well-formed.
- If an automated change causes malformed HTML in generated output, it must be fixed before the change is considered complete.

## Mobile Usability Rule

The YaCy homepage and documentation must work well for mobile users.

- Design and content changes must be checked on narrow mobile-sized viewports as well as desktop viewports.
- Pages should not require horizontal scrolling on phones.
- Text, navigation, buttons, images, tables, and code blocks must remain readable and usable on mobile devices.
- Do not rely on fixed desktop widths, inline positioning, or desktop-only spacing when responsive CSS can be used.

## Review Guideline

When modifying the site, review changes for privacy regressions:

- Check HTML templates, MkDocs theme overrides, Markdown content, CSS, and JavaScript for external URLs.
- Reject or replace any automatic remote dependency with a local copy.
- Prefer relative paths and same-origin URLs for all runtime resources.
- Review generated files in `site/` after `mkdocs build`, not only source templates/content.
- Include a mobile viewport review for pages affected by layout, navigation, media, tables, code blocks, or call-to-action changes.
