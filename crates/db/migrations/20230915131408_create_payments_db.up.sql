CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS payments (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  account_id UUID NOT NULL REFERENCES accounts(id),

  address VARCHAR(255) NOT NULL,
  amount BIGINT NOT NULL,
  received BIGINT NOT NULL,

  confirmations INT NOT NULL,
  initiated BOOLEAN NOT NULL,

  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS payments_account_id_idx ON payments (account_id);
CREATE INDEX IF NOT EXISTS payments_address_idx ON payments (address);
CREATE INDEX IF NOT EXISTS payments_confirmations_idx ON payments (confirmations);
CREATE INDEX IF NOT EXISTS payments_initiated_idx ON payments (initiated);

CREATE TABLE IF NOT EXISTS payment_inscription_contents (
  payment_id UUID NOT NULL REFERENCES payments(id),
  content TEXT NOT NULL,

  PRIMARY KEY (payment_id, content)
);
