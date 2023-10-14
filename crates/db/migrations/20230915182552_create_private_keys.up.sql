CREATE TABLE IF NOT EXISTS private_keys (
  account_id UUID NOT NULL REFERENCES accounts(id) ON DELETE CASCADE,
  payment_inscription_content_id UUID REFERENCES payment_inscription_contents(id),
  domain VARCHAR(255) NOT NULL,
  encryption_method SMALLSERIAL NOT NULL,
  private_key TEXT NOT NULL,

  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
