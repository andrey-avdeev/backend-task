-- Exchange rates

DROP TABLE IF EXISTS public.exchange_rates;
CREATE TABLE public.exchange_rates (
    ts            TIMESTAMP WITHOUT TIME ZONE,
    from_currency VARCHAR(3),
    to_currency   VARCHAR(3),
    rate          NUMERIC
);


-- Transactions

DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions (
    ts       TIMESTAMP WITHOUT TIME ZONE,
    user_id  INT,
    currency VARCHAR(3),
    amount   NUMERIC
);
