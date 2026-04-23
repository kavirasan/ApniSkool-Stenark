---
name: Cosmic Pulse
colors:
  surface: '#faf8ff'
  surface-dim: '#d2d9f4'
  surface-bright: '#faf8ff'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f2f3ff'
  surface-container: '#eaedff'
  surface-container-high: '#e2e7ff'
  surface-container-highest: '#dae2fd'
  on-surface: '#131b2e'
  on-surface-variant: '#464554'
  inverse-surface: '#283044'
  inverse-on-surface: '#eef0ff'
  outline: '#767586'
  outline-variant: '#c7c4d7'
  surface-tint: '#494bd6'
  primary: '#4648d4'
  on-primary: '#ffffff'
  primary-container: '#6063ee'
  on-primary-container: '#fffbff'
  inverse-primary: '#c0c1ff'
  secondary: '#b90538'
  on-secondary: '#ffffff'
  secondary-container: '#dc2c4f'
  on-secondary-container: '#fffbff'
  tertiary: '#006c49'
  on-tertiary: '#ffffff'
  tertiary-container: '#00885d'
  on-tertiary-container: '#000703'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#e1e0ff'
  primary-fixed-dim: '#c0c1ff'
  on-primary-fixed: '#07006c'
  on-primary-fixed-variant: '#2f2ebe'
  secondary-fixed: '#ffdadb'
  secondary-fixed-dim: '#ffb2b7'
  on-secondary-fixed: '#40000d'
  on-secondary-fixed-variant: '#92002a'
  tertiary-fixed: '#6ffbbe'
  tertiary-fixed-dim: '#4edea3'
  on-tertiary-fixed: '#002113'
  on-tertiary-fixed-variant: '#005236'
  background: '#faf8ff'
  on-background: '#131b2e'
  surface-variant: '#dae2fd'
typography:
  headline-xl:
    fontFamily: Lato
    fontSize: 40px
    fontWeight: '900'
    lineHeight: '1.2'
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Lato
    fontSize: 32px
    fontWeight: '700'
    lineHeight: '1.25'
    letterSpacing: -0.01em
  headline-md:
    fontFamily: Lato
    fontSize: 24px
    fontWeight: '700'
    lineHeight: '1.3'
  body-lg:
    fontFamily: Lato
    fontSize: 18px
    fontWeight: '400'
    lineHeight: '1.6'
  body-md:
    fontFamily: Lato
    fontSize: 16px
    fontWeight: '400'
    lineHeight: '1.5'
  label-md:
    fontFamily: Lato
    fontSize: 14px
    fontWeight: '700'
    lineHeight: '1.2'
    letterSpacing: 0.05em
  label-sm:
    fontFamily: Lato
    fontSize: 12px
    fontWeight: '600'
    lineHeight: '1.2'
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  base: 4px
  xs: 4px
  sm: 8px
  md: 16px
  lg: 24px
  xl: 48px
  gutter: 24px
  margin: 32px
  max-width: 1280px
---

## Brand & Style

This design system is built for a high-performance student platform that balances academic rigor with creative energy. The brand personality is "The Modern Polymath"—intelligent, tech-forward, and relentlessly optimistic. It moves away from the sterile aesthetics of traditional EdTech toward a more vibrant, "Supernova-inspired" digital environment.

The design style combines **Minimalism** with **Glassmorphism** and **Tactile** influences. By utilizing a clean, white base (Minimalism) and layering it with translucent, blurred surfaces (Glassmorphism) and soft, pillowy depth (Tactile), the UI feels lightweight yet substantial. The goal is to evoke a sense of "organized momentum," where the interface feels fast and fluid, encouraging students to engage deeply with their work without feeling overwhelmed.

## Colors

The palette is anchored by "Electric Indigo," a primary color that bridges the gap between deep cosmic purple and high-tech blue. This color is used for primary actions and brand-heavy elements. To maintain high energy, "Radiant Rose" serves as the high-contrast secondary accent, used for highlights, notifications, and interactive feedback.

"Emerald Surge" is introduced as a tertiary color specifically for performance indicators and success states. The neutral palette shifts from a very light slate background to a deep navy for typography, ensuring maximum readability. Use subtle linear gradients (135° angle) mixing the primary color with a slightly lighter tint to add depth to large buttons and header containers.

## Typography

The design system utilizes **Lato** exclusively to achieve a clean, humanist feel that remains legible at high speeds. Headlines use the Black (900) and Bold (700) weights with tight letter-spacing to create a "tech-forward" and impactful hierarchy. 

Body text remains spacious with a 1.5x to 1.6x line height to prevent fatigue during long study sessions. Labels and micro-copy utilize the Bold weight and subtle tracking (letter-spacing) to distinguish them from body content, creating a clear architectural map of the interface.

## Layout & Spacing

The layout follows a **Fixed-Fluid hybrid grid**. On desktop, content is contained within a 12-column grid with a maximum width of 1280px to maintain focus. On smaller viewports, the grid becomes fluid with 16px gutters.

The spacing rhythm is built on a 4px baseline, but the primary increments used for layout are 16px (md) and 24px (lg). This "roomy" approach ensures that even complex data-heavy student dashboards feel organized and breathable. Large 48px (xl) padding is reserved for section breaks and hero areas to emphasize the "minimalist" aspect of the brand.

## Elevation & Depth

Hierarchy is established through **Ambient Shadows** and **Tonal Layers**. Instead of harsh black shadows, this design system uses "Electric Indigo" tinted shadows (e.g., `rgba(99, 102, 241, 0.08)`) to maintain the vibrant feel.

- **Level 0 (Base):** The main background (`#F8FAFC`).
- **Level 1 (Cards):** White surfaces with a 1px border (`#E2E8F0`) and a very soft, diffused shadow (Y: 4px, Blur: 20px).
- **Level 2 (Floating):** Navigation bars and modals use a backdrop-filter blur (20px) with 80% opacity to create a glassmorphic effect, suggesting they exist on a separate plane above the workspace.
- **Level 3 (Interactives):** Hover states on primary buttons use a more pronounced shadow (Y: 8px, Blur: 24px) to simulate physical lift.

## Shapes

The shape language is defined by a consistent **Rounded** aesthetic. Standard containers, cards, and input fields utilize a 16px (1rem) corner radius. This high level of roundedness removes the "corporate" edge, making the high-performance platform feel more approachable and playful.

Smaller elements like chips or badges may use a "Pill-shaped" (Full) radius to differentiate them from structural layout elements. Buttons follow the 16px standard to match the cards they reside within.

## Components

- **Buttons:** Primary buttons use a subtle 135-degree gradient of Electric Indigo. They have a 16px radius and "lift" on hover via an increased shadow. Secondary buttons are outlined with a 2px stroke of the primary color.
- **Cards:** Cards are the primary organizational unit. They feature white backgrounds, 16px rounded corners, and a 1px soft border. Headers within cards should use the `label-md` style for clear categorization.
- **Input Fields:** Inputs have a light gray background (`#F1F5F9`) that shifts to white with a primary-colored border on focus. Icons within inputs use a muted version of the primary color.
- **Chips & Badges:** Used for tags or status. These utilize the Radiant Rose or Emerald Surge colors at 10% opacity for the background and 100% opacity for the text.
- **Progress Orbs:** A custom component for a student platform; circular progress indicators that use a thick stroke and a glow effect (soft shadow) in the primary color to visualize goal completion.
- **Glass Nav-Bar:** A top-pinned navigation bar with a heavy backdrop-blur and a subtle bottom border.