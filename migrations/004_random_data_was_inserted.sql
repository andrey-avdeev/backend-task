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
