Always-on rules for this repository.

## Core Rules
1. After each completed task, update memory_bank (`activeContext.md`, `decisions.md`, `progress.md`, `errors.md`, `glossary.md` when terms change).
2. Keep implementation, `contracts/swagger.json`, `contracts/db_schema.sql`, and `architecture.md` in sync.
3. Use test-first for new logic: define or update tests before implementation, then run relevant tests after changes.
4. Record new product or logic requirements in `memory_bank/requirements`.
5. If requirements are ambiguous or conflicting, ask the user instead of guessing.
6. Use stable, maintainable libraries and standard architecture practices.

## Execution Workflow
1. Read `memory_bank/requirements`.
2. Validate compatibility with contracts, schema, and architecture.
3. Add or update tests.
4. Implement changes.
5. Run tests.
6. Update `memory_bank`, including new errors/lessons and glossary terms when applicable.

## Quality Gates
- No hidden behavior outside declared contracts.
- No schema or contract drift without explicit file updates.
- No new logic without corresponding tests.
- No unresolved ambiguity in delivered changes.