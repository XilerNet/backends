CREATE TABLE IF NOT EXISTS discounts (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  type SMALLSERIAL NOT NULL,
  amount NUMERIC(10, 2) NOT NULL,
  currency VARCHAR(3) NOT NULL,
  code VARCHAR(255) NOT NULL,
  description TEXT NOT NULL,
  expiration_date TIMESTAMP NOT NULL,
  max_uses INTEGER,
  uses INTEGER NOT NULL DEFAULT 0,
  stackable BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE INDEX IF NOT EXISTS discounts_code_idx ON discounts (code);
CREATE INDEX IF NOT EXISTS discounts_expiration_date_idx ON discounts (expiration_date);
CREATE INDEX IF NOT EXISTS discounts_max_uses_idx ON discounts (max_uses);
CREATE INDEX IF NOT EXISTS discounts_uses_idx ON discounts (uses);

CREATE TABLE IF NOT EXISTS loyalty_discounts (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  collection_type SMALLSERIAL NOT NULL,
  collection_id VARCHAR(255) NOT NULL,
  collection_minimum_owned FLOAT8,
  amount NUMERIC(10, 2) NOT NULL,
  currency VARCHAR(3) NOT NULL,
  message TEXT NOT NULL,
  stackable BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE INDEX IF NOT EXISTS loyalty_discounts_collection_idx ON loyalty_discounts (collection_type, collection_id);
CREATE INDEX IF NOT EXISTS loyalty_discounts_collection_minimum_owned_idx ON loyalty_discounts (collection_type, collection_id, collection_minimum_owned);

INSERT INTO loyalty_discounts (collection_type, collection_id, collection_minimum_owned, amount, currency, message, stackable)
VALUES (0, '$BIT', NULL, 5, '%', '<a href="https://www.bitcheck.me" target="_blanc">$BIT</a> holder loyalty', TRUE),
  (0, '$BIT', 25000, 5, '%', '25k+ <a href="https://www.bitcheck.me" target="_blanc">$BIT</a> holder loyalty', TRUE);
