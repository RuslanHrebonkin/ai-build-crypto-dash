-- PostgreSQL 18 initialization script

CREATE TABLE IF NOT EXISTS users (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    email TEXT NOT NULL UNIQUE,
    password_hash TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS user_symbols (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id BIGINT NOT NULL,
    symbol_name TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    CONSTRAINT fk_user_symbols_user
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE CASCADE,
    CONSTRAINT uq_user_symbol UNIQUE (user_id, symbol_name)
);

CREATE INDEX IF NOT EXISTS idx_user_symbols_user_id ON user_symbols(user_id);
CREATE INDEX IF NOT EXISTS idx_user_symbols_symbol_name ON user_symbols(symbol_name);
