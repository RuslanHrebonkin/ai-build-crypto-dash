# Crypto Watchlist MVP Architecture

## High-Level Overview
The system is designed as a decoupled full-stack application:
- `frontend` serves UI and authenticated user flows with Next.js 16.
- `backend` exposes REST endpoints via FastAPI.
- `db` stores user accounts and personal watchlists in PostgreSQL 18.

## System Context Diagram
```mermaid
flowchart LR
    U["User"] <--> FE["Next.js 16 Frontend\n(App Router + Server Components)"]
    FE <--> BE["FastAPI Backend\n(REST + OpenAPI)"]
    BE <--> DB["PostgreSQL 18\n(users, watchlists)"]
```

## Auth Flow (Registration With Auto-Login)
```mermaid
sequenceDiagram
    participant U as User
    participant FE as Next.js
    participant BE as FastAPI
    participant DB as PostgreSQL

    U->>FE: Submit email/password (register)
    FE->>BE: POST /auth/register
    BE->>DB: INSERT user
    DB-->>BE: created user
    BE-->>FE: 201 access_token (bearer)
    FE-->>U: Redirect to private dashboard
```

## Request Flow (Watchlist Read)
```mermaid
sequenceDiagram
    participant U as User
    participant FE as Next.js
    participant BE as FastAPI
    participant DB as PostgreSQL

    U->>FE: Open Dashboard
    FE->>BE: GET /watchlist (Bearer access token)
    BE->>DB: SELECT watchlists by user_id
    DB-->>BE: Rows (symbols, max 50)
    BE-->>FE: 200 JSON watchlist
    FE-->>U: Render personal watchlist
```

## Request Flow (Watchlist Create With Limit Rule)
```mermaid
sequenceDiagram
    participant U as User
    participant FE as Next.js
    participant BE as FastAPI
    participant DB as PostgreSQL

    U->>FE: Add symbol (e.g., BTC/USDT)
    FE->>BE: POST /watchlist (Bearer access token)
    BE->>DB: COUNT user symbols + INSERT if valid
    alt user symbols < 50 and symbol unique
        DB-->>BE: insert success
        BE-->>FE: 201 watchlist item
    else limit reached or duplicate
        DB-->>BE: validation/conflict
        BE-->>FE: 422 (limit) or 409 (duplicate)
    end
    FE-->>U: Update UI state
```

## Core Architectural Notes
- Authentication is access-token based in MVP (no refresh-token flow).
- `POST /auth/register` performs automatic login by returning an access token.
- Data isolation is enforced by `user_id` ownership checks on every watchlist operation.
- Business rule: each user can store at most 50 symbols.
- API-first approach is used through versioned OpenAPI contract in `contracts/swagger.json`.