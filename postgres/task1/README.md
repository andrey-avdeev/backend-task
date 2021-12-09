Уже не успел

Запрос на получение актуального курса начал копать в эту сторону
`select distinct max(ts) as mts, from_currency, to_currency, rate from exchange_rates group by from_currency, to_currency, rate;`

Финальный запрос начал как `SELECT user_id, sum(amount), currency FROM transactions LEFT JOIN exchange_rates...`