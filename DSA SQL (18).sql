WITH trans_record AS (SELECT 
account_id,
sum(CASE WHEN transaction_type = 'Deposit'
THEN amount END ) as total_deposit,
sum(CASE WHEN transaction_type = 'Withdrawal'
THEN amount END) as total_withdrawal
FROM transactions
GROUP BY account_id)

SELECT account_id,
total_deposit - total_withdrawal AS final_balance
FROM trans_record;

WITH song_records AS (SELECT 
user_id,
song_id,
song_plays
FROM songs_history 

UNION ALL

SELECT
user_id,
song_id,
count(*) as song_plays
FROM songs_weekly 
WHERE listen_time <= '2022-08-04 23:59:59'
GROUP BY user_id,song_id)

SELECT user_id,
song_id,
sum(song_plays) as song_plays
FROM
song_records
GROUP BY user_id, song_id
ORDER BY song_plays DESC;