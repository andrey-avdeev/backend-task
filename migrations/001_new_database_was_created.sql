CREATE DATABASE checklens;

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

TRUNCATE TABLE public.exchange_rates;
INSERT INTO public.exchange_rates
VALUES ('2018-04-01 00:00:00', 'USD', 'GBP', '0.71'),
       ('2018-04-01 00:00:05', 'USD', 'GBP', '0.82'),
       ('2018-04-01 00:01:00', 'USD', 'GBP', '0.92'),
       ('2018-04-01 01:02:00', 'USD', 'GBP', '0.62'),

       ('2018-04-01 02:00:00', 'USD', 'GBP', '0.71'),
       ('2018-04-01 03:00:05', 'USD', 'GBP', '0.82'),
       ('2018-04-01 04:01:00', 'USD', 'GBP', '0.92'),
       ('2018-04-01 04:22:00', 'USD', 'GBP', '0.62'),

       ('2018-04-01 00:00:00', 'EUR', 'GBP', '1.71'),
       ('2018-04-01 01:00:05', 'EUR', 'GBP', '1.82'),
       ('2018-04-01 01:01:00', 'EUR', 'GBP', '1.92'),
       ('2018-04-01 01:02:00', 'EUR', 'GBP', '1.62'),

       ('2018-04-01 02:00:00', 'EUR', 'GBP', '1.71'),
       ('2018-04-01 03:00:05', 'EUR', 'GBP', '1.82'),
       ('2018-04-01 04:01:00', 'EUR', 'GBP', '1.92'),
       ('2018-04-01 05:22:00', 'EUR', 'GBP', '1.62'),

       ('2018-04-01 05:22:00', 'EUR', 'HUF', '0.062')
;


TRUNCATE TABLE public.transactions;
INSERT INTO public.transactions
VALUES ('2018-04-01 00:00:00', 1, 'EUR', 2.45),
       ('2018-04-01 01:00:00', 1, 'EUR', 8.45),
       ('2018-04-01 01:30:00', 1, 'USD', 3.5),
       ('2018-04-01 20:00:00', 1, 'EUR', 2.45),

       ('2018-04-01 00:30:00', 2, 'USD', 2.45),
       ('2018-04-01 01:20:00', 2, 'USD', 0.45),
       ('2018-04-01 01:40:00', 2, 'USD', 33.5),
       ('2018-04-01 18:00:00', 2, 'EUR', 12.45),

       ('2018-04-01 18:01:00', 3, 'GBP', 2),

       ('2018-04-01 00:01:00', 4, 'USD', 2),
       ('2018-04-01 00:01:00', 4, 'GBP', 2)
;

INSERT INTO public.exchange_rates (
    SELECT
        ts,
        from_currency,
        to_currency,
        rate
    FROM (
             SELECT date_trunc('second', dd + (random() * 60) * '1 second':: INTERVAL) AS ts
                  , CASE WHEN random() * 2 < 1 THEN 'EUR' ELSE 'USD' END               AS from_currency
                  ,
                 'GBP'                                                                 AS to_currency
                  , (200 * random():: INT) / 100                                       AS rate
             FROM generate_series
                      ('2018-04-01'::TIMESTAMP
                      , '2018-04-02'::TIMESTAMP
                      , '1 minute'::INTERVAL) dd
         ) a
    WHERE ts NOT IN (SELECT ts FROM exchange_rates)
    ORDER BY ts
)
;

INSERT INTO public.transactions (
    SELECT dd + (random() * 5) * '1 second'::INTERVAL        AS ts
         , (random() * 1000)::INT                            AS user_id
         ,
        CASE WHEN random() * 2 < 1 THEN 'EUR' ELSE 'USD' END AS currency
         ,
        (random() * 10000) :: INT / 100                      AS amount
    FROM generate_series
             ('2018-04-01'::TIMESTAMP
             , '2018-04-02'::TIMESTAMP
             , '1 second'::INTERVAL) dd
);