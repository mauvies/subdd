---
name: accessibility
description: WCAG 2.2 AA accessibility rules and audit checklist. Use when building or reviewing UI, forms, navigation, modals, colors or any interactive component.
---

# Accessibility (WCAG 2.2 AA)

- **Semantics:** native elements first (`button`, `a`, `label`, `nav`, `main`). ARIA only to fill gaps, and correctly.
- **Keyboard:** everything reachable and operable with Tab/Shift+Tab/Enter/Space/Escape/arrows. Visible focus ring. No keyboard traps; modals trap and restore focus.
- **Forms:** every input has a programmatic label; errors announced (`aria-describedby`, `aria-invalid`) and described in text, not only color.
- **Images and icons:** meaningful `alt`; decorative ones `alt=""` or `aria-hidden`. Icon-only buttons need an accessible name.
- **Color:** text contrast 4.5:1 (3:1 large text and UI components). Never color alone to convey meaning.
- **Motion:** respect `prefers-reduced-motion`; no flashing content.
- **Structure:** one `h1`, logical heading order, landmarks, skip link, `lang` attribute.
- **Targets:** at least 24x24 CSS px.
- **Dynamic content:** live regions for async updates and toasts.

Audit with axe (Playwright `@axe-core/playwright` or browser extension), keyboard-only pass, and a screen reader smoke test (VoiceOver/NVDA).
