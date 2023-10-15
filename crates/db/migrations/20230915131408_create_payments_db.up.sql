CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS payments (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  account_id UUID NOT NULL REFERENCES accounts(id) ON DELETE SET DEFAULT,

  address VARCHAR(255) NOT NULL,
  amount FLOAT8 NOT NULL,
  received FLOAT8 NOT NULL DEFAULT 0,

  initiated BOOLEAN NOT NULL DEFAULT FALSE,
  completed BOOLEAN NOT NULL DEFAULT FALSE,

  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS payments_account_id_idx ON payments (account_id);
CREATE INDEX IF NOT EXISTS payments_address_idx ON payments (address);
CREATE INDEX IF NOT EXISTS payments_initiated_idx ON payments (initiated);

CREATE TABLE IF NOT EXISTS payment_transactions (
  payment_id UUID REFERENCES payments(id),
  transaction_id VARCHAR(255) NOT NULL,

  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

  PRIMARY KEY (payment_id, transaction_id)
);

CREATE INDEX IF NOT EXISTS payment_transactions_payment_id_idx ON payment_transactions (payment_id);
CREATE INDEX IF NOT EXISTS payment_transactions_transaction_id_idx ON payment_transactions (transaction_id);

CREATE TABLE IF NOT EXISTS payment_inscription_contents (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  payment_id UUID REFERENCES payments(id) ON DELETE CASCADE,
  target VARCHAR(255) NOT NULL,
  content TEXT NOT NULL,
  inscribed BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE IF NOT EXISTS payment_inscriptions (
  content UUID REFERENCES payment_inscription_contents(id),
  commit_tx VARCHAR(255) NOT NULL,
  reveal_tx VARCHAR(255) NOT NULL,
  total_fees FLOAT8 NOT NULL
);
