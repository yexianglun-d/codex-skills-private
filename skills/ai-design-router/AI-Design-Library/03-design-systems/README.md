# Design Systems

Use for Figma, component mapping, design tokens, generated libraries, shadcn, and project-specific design system rules.

## Installed Or Plugin Skills

- `figma`
- `figma-implement-design`
- `figma-create-design-system-rules`
- `figma-code-connect-components`
- `figma:figma-use`
- `figma:figma-generate-library`
- `figma:figma-code-connect`
- `build-web-apps:shadcn`

## Default Choice

- Use Figma skills when the user provides a Figma link, node, screenshot, or asks for design-to-code.
- Use Code Connect skills only when mapping Figma components to code components.
- Use shadcn skill when the project already uses shadcn or the user asks for shadcn components.

## Do Not

- Treat Figma as available if the user has not provided a Figma target or if authentication is missing.
- Invent a new design system when the project already has tokens/components.
