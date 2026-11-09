---
name: security-checklist
description: Application security checklist based on OWASP Top 10, ASVS and common cloud pitfalls. Use when auditing code, reviewing auth, payments, uploads or infra.
---

# Security checklist

## Access control
- Authorization on every endpoint and object (IDOR). Deny by default. Tenant isolation.
- Admin and internal routes not exposed publicly.

## Authentication and sessions
- Password hashing with argon2id/bcrypt; MFA available for sensitive accounts.
- Sessions: HttpOnly, Secure, SameSite cookies; rotation on login; short-lived JWTs with revocation strategy.
- Rate limiting and lockout on login, OTP and password reset.

## Injection and input
- Parameterized queries/ORM; no string-built SQL, shell, or `eval`.
- Output encoding; CSP; no `dangerouslySetInnerHTML` with user data.
- Validate type, length, format, range. File uploads: type sniffing, size limits, stored outside web root, scanned.
- SSRF: allowlist outbound hosts for user-supplied URLs; block metadata IPs.

## Data
- Secrets in a secret manager. `.env` gitignored. Rotate leaked keys.
- TLS everywhere; encryption at rest for sensitive data. Minimal PII; retention policy.
- Logs scrubbed of tokens and PII.

## Configuration and supply chain
- Security headers (CSP, HSTS, X-Content-Type-Options, frame-ancestors).
- CORS restricted to known origins.
- Dependencies pinned and audited; lockfile committed; Dependabot/Renovate.
- CI with OIDC and least-privilege tokens.
