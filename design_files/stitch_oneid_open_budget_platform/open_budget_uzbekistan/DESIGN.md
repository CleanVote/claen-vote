---
name: Open Budget Uzbekistan
colors:
  surface: '#fcf9f8'
  surface-dim: '#dcd9d9'
  surface-bright: '#fcf9f8'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f6f3f2'
  surface-container: '#f0eded'
  surface-container-high: '#eae7e7'
  surface-container-highest: '#e5e2e1'
  on-surface: '#1b1b1b'
  on-surface-variant: '#43474f'
  inverse-surface: '#313030'
  inverse-on-surface: '#f3f0ef'
  outline: '#737780'
  outline-variant: '#c3c6d0'
  surface-tint: '#396093'
  primary: '#002041'
  on-primary: '#ffffff'
  primary-container: '#003566'
  on-primary-container: '#7a9fd6'
  inverse-primary: '#a5c8ff'
  secondary: '#006d37'
  on-secondary: '#ffffff'
  secondary-container: '#7bf8a1'
  on-secondary-container: '#007239'
  tertiary: '#1d2021'
  on-tertiary: '#ffffff'
  tertiary-container: '#323536'
  on-tertiary-container: '#9b9d9e'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#d4e3ff'
  primary-fixed-dim: '#a5c8ff'
  on-primary-fixed: '#001c3a'
  on-primary-fixed-variant: '#1e4879'
  secondary-fixed: '#7efba4'
  secondary-fixed-dim: '#61de8a'
  on-secondary-fixed: '#00210c'
  on-secondary-fixed-variant: '#005228'
  tertiary-fixed: '#e1e3e4'
  tertiary-fixed-dim: '#c5c7c8'
  on-tertiary-fixed: '#191c1d'
  on-tertiary-fixed-variant: '#454748'
  background: '#fcf9f8'
  on-background: '#1b1b1b'
  surface-variant: '#e5e2e1'
typography:
  headline-lg:
    fontFamily: Public Sans
    fontSize: 30px
    fontWeight: '700'
    lineHeight: 38px
    letterSpacing: -0.02em
  headline-md:
    fontFamily: Public Sans
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
    letterSpacing: -0.01em
  headline-sm:
    fontFamily: Public Sans
    fontSize: 20px
    fontWeight: '600'
    lineHeight: 28px
  body-lg:
    fontFamily: Public Sans
    fontSize: 18px
    fontWeight: '400'
    lineHeight: 28px
  body-md:
    fontFamily: Public Sans
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  body-sm:
    fontFamily: Public Sans
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
  label-bold:
    fontFamily: Public Sans
    fontSize: 12px
    fontWeight: '700'
    lineHeight: 16px
    letterSpacing: 0.05em
  button:
    fontFamily: Public Sans
    fontSize: 16px
    fontWeight: '600'
    lineHeight: 20px
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  base: 8px
  xs: 4px
  sm: 8px
  md: 16px
  lg: 24px
  xl: 32px
  container-padding: 20px
  gutter: 16px
---

## Brand & Style

The brand personality of this design system is rooted in civic duty, institutional stability, and radical transparency. It is designed to bridge the gap between formal government communications and modern, user-centric digital products. The UI should evoke a sense of "Reliable Innovation"—where the citizen feels the weight of authority but the ease of a modern FinTech application.

The design style follows a **Corporate / Modern** aesthetic. It prioritizes clarity and structured information over decorative elements. By utilizing significant whitespace (representing transparency) and a rigorous grid, the system ensures that complex budgetary data remains accessible and trustworthy for all citizens of Uzbekistan.

## Colors

The palette is anchored by a **Deep Blue**, symbolizing the official nature of the government and establishing immediate trust. **Success Green** is used as a functional accent to highlight growth, approved projects, and successful voting actions. 

White serves as the foundational background to maintain a sense of "Openness" and clarity. Gray scales are strictly neutral to ensure that the primary blue and green accents carry the most semantic weight. For semantic states, use a standardized red for "Rejected" or "Critical" alerts, ensuring it does not overpower the primary brand blue.

## Typography

The choice of **Public Sans** reinforces the institutional and official nature of the application. It is a typeface designed for government interfaces, offering exceptional readability across various screen sizes.

The typographic hierarchy is structured to lead with bold headlines for project titles and budgetary figures, while body text remains neutral and highly legible. Letter spacing is slightly tightened for headlines to maintain a modern, "compact" feel, while body copy utilizes standard spacing for maximum accessibility. All labels and secondary data points should use uppercase or bold weights to distinguish them from interactive content.

## Layout & Spacing

This design system utilizes a **Fluid Grid** model optimized for mobile devices. The layout is built on an 8px base unit to ensure consistent vertical rhythm and alignment. 

For mobile views, a 4-column grid is standard, with 20px side margins to provide breathing room on the edges of the display. Gutters between cards and interactive elements are set at 16px. Content should be grouped into logical sections using varied spacing (e.g., 24px between different project categories and 8px between elements within a single card) to create a clear visual hierarchy of information.

## Elevation & Depth

To achieve a modern UX while remaining official, this design system uses **Ambient Shadows** to create depth. Surfaces are not flat, but layered to indicate interactability. 

- **Level 0 (Background):** Pure white or ultra-light gray (#F8F9FA).
- **Level 1 (Cards/Search bars):** White surface with a soft, diffused shadow (0px 4px 20px rgba(0, 0, 0, 0.05)). This makes the card appear to "float" slightly above the background without looking heavy.
- **Level 2 (Active States/Modals):** A more pronounced shadow (0px 8px 30px rgba(0, 0, 0, 0.08)) to draw focus.

Avoid heavy borders; use tonal changes and subtle shadows to define boundaries. This creates a "clean" interface that suggests transparency and modernity.

## Shapes

The shape language uses **Rounded** (Level 2) corners to soften the formal nature of the application, making it feel approachable and modern. 

- **Standard Buttons & Inputs:** 8px (0.5rem) corner radius.
- **Project Cards:** 16px (1rem) corner radius to create a containerized, friendly look for complex information.
- **Status Chips:** Full pill-shape (100px) to distinguish them from interactive buttons.

This balance of 8px and 16px radii ensures the UI feels cohesive and systematic, avoiding the "sharpness" of old-school government software while maintaining enough structure to feel professional.

## Components

### Buttons
Primary buttons use the Deep Blue background with White text, using 8px rounding. Success actions (like "Vote" or "Submit") utilize the Accent Green. Ghost buttons (outline only) should be used for secondary actions like "View Details."

### Cards
Cards are the primary vehicle for "Open Budget" projects. They must feature a white background, Level 1 shadow, and 16px rounded corners. Use a 4px Green vertical accent bar on the left side of a card to indicate "Approved" or "Funded" status.

### Progress Bars
Use Accent Green for the filled state and a light gray (#E9ECEF) for the track. These should be used to show funding progress or voting quotas.

### Input Fields
Inputs should have a light gray border (#DEE2E6) that turns Deep Blue on focus. Labels should always be visible above the input field, never just as placeholder text, to ensure accessibility.

### Iconography
Icons must be "Line-style" with a 2px stroke width, using the Deep Blue for active states. They should be clear and literal (e.g., a "Bank" icon for finance, a "Map Pin" for regional projects). Avoid overly abstract metaphors.

### Voting Chips
Small, pill-shaped indicators that show the current vote count. These use a light tint of the Primary Blue with dark blue text to remain legible but secondary to the main project title.