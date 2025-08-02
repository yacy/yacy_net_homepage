# YaCy Packs

YaCy Packs are **ready-made index bundles** that let you plug knowledge into any YaCy instance in minutes.  
Think of them as collectible “data cartridges” you can mix, stack, or remove at will—no crawling hours,
no external dependencies.

These are the advantages of YaCy Packs:
- Instant knowledge – skip multi-day crawls.
- Mix-and-match – combine core + scroll for a dev-knowledge box.
- Privacy – all data ships offline; nothing phones home.
- Reproducible – same pack → same search experience on any node.
- Shareable – send a friend the pack; they drop it into PACKS/hold.


## File naming (one glance tells the story)

YaCy Packs are files that should follow the following naming structure:

```
YaCy-Pack_<category>-<tier>-<origin>_<slug>_<YYYYMMDD>.jsonl
```

The name of a pack provides metadata about the content of the pack, that is not only a name
but also a qualification about the size, type of content, amount of work done to create the pack and more.
Here are the details:

| Part       | Values & rules |
|------------|----------------|
| `category` | one of: `core`, `scroll`, `codex`, `gem`, `fiction`, `map`, `echo`, `spirit`, `vault` |
| `tier`     | `common`, `uncommon`, `rare`, `epic`, `legendary` |
| `origin`   | `web`, `synth`, `archive`, `sim`, `mirror`, `corpus`, `partial` |
| `slug`     | description of the content, should be collection of the index |
| `YYYYMMDD` | four-digit year + month + day (production date) |

Example: `YaCy-Pack_scroll-common-web_top-1000_20250801.jsonl`

The group `<category>-<tier>-<origin>` has the metadata about the content while `<slug>` is a free-text
field that the creator can use to describe the content of the pack. We encourage every creator to fill
into `<slug>` simply the name of the collection that can be assigned during a web crawl. We want to encourage
every user of YaCy to use that field with the possible creation of a pack in mind.


## Categories at a glance

The `<category>` part of the pack name makes it easy to understand what the content is about. We define
the following category names that are availabe during pack generation:

| Category | What’s inside |
|----------|---------------|
| **core** | technical documentation, operation systems, computer hardware, open source and free software, manuals, protocol standards |
| **scroll** | non-technical documents: knowledge, encyclopedia, linguistic corpora, dictionaries, translation memories, texts, non-fiction books, historical books |
| **codex** | non-technical standards: industry standards, laws, rules, compliance |
| **gem** | research, papers, university publications, science |
| **fiction** | fictional documents: movies, stories, series, books (fiction, science-fiction) |
| **map** | geological data, geolocation-data, earth/world information |
| **echo** | micro-content (tweets, toots, short headlines, SMS corpora), podcasts, radio archives, audio lectures, spoken-word datasets, logs, incidents, telemetry |
| **spirit** | related to non-textual data (possibly only metadata): art, music, game assets, creative-commons media (non-text culture loot) |
| **vault** | sensitive data: secrets, leaks, non-public documents, security advisories |

## Tiers – how hard was this loot to get?

Packs can be seen like 'loot' in games - they enable the user to have a better tool. We want to have a
classification that shows how much work has been done to create the pack. YaCy packs may be created outside
of YaCy with other tools (like a wikipedia parser) which may be more appropriate to create multi-million size
index files. The tier shows therefore some kind of value that a pack has.

| Tier      | Rule of thumb |
|-----------|---------------|
| **common** | harvestable on a 10-year-old PC within a day |
| **uncommon** | needs fast CPU / big pipe, or > 1 day |
| **rare** | custom parsers or manual curation required |
| **epic** | multi-week crawl or special infrastructure |
| **legendary** | one-off craft or enterprise-level effort |

## Life-cycle (where the pack sits)

YaCy Packs are simply json-list files that can be imported. The import process is done by writing
the pack into an arrival location, that is the path `DATA/PACK/hold`. From this location the pack
can be used to be loaded into the index by moving it to `DATA/PACK/load`. A monitoring process in
YaCy then detects the file and writes it into the YaCy index. After that wrinting is finished,
the pack file is moved to `DATA/PACK/loaded`.

The full directory tree for YaCy packs is:

```
DATA/PACKS/
├── hold/
├── load/
├── loaded/
└── unload/
```

