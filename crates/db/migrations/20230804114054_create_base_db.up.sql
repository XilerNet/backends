CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS accounts (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  email VARCHAR(255) NOT NULL UNIQUE,
  contact_email VARCHAR(255) NOT NULL UNIQUE,
  encryption_method SMALLSERIAL NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS accounts_email_idx ON accounts (email);
CREATE INDEX IF NOT EXISTS accounts_contact_email_idx ON accounts (contact_email);

CREATE TABLE IF NOT EXISTS links (
  type SMALLSERIAL NOT NULL,
  id VARCHAR(255) NOT NULL,
  encryption_method SMALLSERIAL NOT NULL,
  account_id UUID NOT NULL REFERENCES accounts(id) ON DELETE CASCADE,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

  PRIMARY KEY (type, id)
);

CREATE INDEX IF NOT EXISTS links_account_id_idx ON links (account_id);
CREATE INDEX IF NOT EXISTS links_id_idx ON links (id);

CREATE TABLE IF NOT EXISTS account_creations (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  link_type SMALLSERIAL NOT NULL,
  link_id VARCHAR(255) NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

  UNIQUE (link_type, link_id)
);

CREATE TABLE IF NOT EXISTS sessions (
  id VARCHAR(255) PRIMARY KEY,
  account_id UUID NOT NULL REFERENCES accounts(id) ON DELETE CASCADE,

  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS sessions_account_id_idx ON sessions (account_id);

CREATE TABLE IF NOT EXISTS addresses (
  account_id UUID NOT NULL REFERENCES accounts(id) ON DELETE CASCADE,
  address VARCHAR(255) NOT NULL,
  encryption_method SMALLSERIAL NOT NULL,

  PRIMARY KEY (account_id, address)
);

CREATE INDEX IF NOT EXISTS addresses_account_id_idx ON addresses (account_id);
CREATE INDEX IF NOT EXISTS addresses_address_idx ON addresses (address);

CREATE TABLE IF NOT EXISTS logs (
  account_id UUID NOT NULL REFERENCES accounts(id) ON DELETE SET DEFAULT,
  action VARCHAR(255) NOT NULL,
  data TEXT,
  encryption_method SMALLSERIAL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
)
