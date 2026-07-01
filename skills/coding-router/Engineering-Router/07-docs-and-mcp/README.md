# Docs And MCP

Use when code work depends on current behavior of a third-party library, framework, SDK, API, CLI, cloud service, or tool.

## Default Choice

- Use Context7 for current library/framework/SDK/API/CLI documentation.
- Use official docs or primary sources when Context7 is unavailable or insufficient.
- Use sequential-thinking for high-risk decisions, complex architecture, migrations, or multi-module technical choices.

## Examples

- React, Next.js, Vue, Nuxt, Vite, Prisma, Spring, MyBatis, Tailwind, shadcn, Supabase, Stripe, GSAP, Figma APIs.
- Cloud service configuration, SDK changes, version migration, plugin setup, CLI behavior.

## Do Not

- Answer from memory when version-specific details matter.
- Add a dependency before checking the existing project stack and package manager.
- Use broad web summaries when official docs are available.
