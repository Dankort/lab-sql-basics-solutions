use bank;
-- Query 1. Get the id values of the first 5 clients from district_id with a value equals to 1.

select * from bank.client
where district_id = 1
order by client_id
limit 5;

-- Qhery 2. In the client table, get an id value of the last client where the district_id equals to 72.

select client_id from bank.client
where district_id = 72
order by client_id DESC
LIMIT 1;

-- Qhery 3. Get the 3 lowest amounts in the loan table.
select amount from bank.loan
ORDER BY amount
LIMIT 3;

-- Quedry 4. What are the possible values for status, ordered alphabetically in ascending order in the loan table?

select distinct status
from loan
order by status ASC;

-- Query 5. What is the loan_id of the highest payment received in the loan table?
select loan_id from loan
order by payments asc
limit 1;

-- Query 6. What is the loan amount of the lowest 5 account_ids in the loan table? Show the account_id and the corresponding amount

select amount,account_id from bank.loan
order by account_id 
limit 5;

-- Query 7. What are the account_ids with the lowest loan amount that have a loan duration of 60 in the loan table?

select account_id from bank.loan
where duration = 60
order by amount 
limit 5;

-- Query 8. What are the unique values of k_symbol in the order table?

select distinct k_symbol
FROM `order`
order by k_symbol;

-- Query 9. In the order table, what are the order_ids of the client with the account_id 34?
select order_id from bank.order
where account_id = 34;

-- Query 10. In the order table, which account_ids were responsible for orders between order_id 29540 and order_id 29560 (inclusive)?

select distinct account_id
from `order`
where order_id between 29540 and 29560;

 -- Query 11. In the order table, what are the individual amounts that were sent to (account_to) id 30067122?

select amount 
from `order`
where account_to = 30067122;

-- Query 12. In the trans table, show the trans_id, date, type and amount of the 10 first transactions from account_id 793 in chronological order, from newest to oldest.

select trans_id,date,type,amount
from trans 
where account_id = 793
order by date desc
limit 10;

-- Qhery 13. In the client table, of all districts with a district_id lower than 10, how many clients are from each district_id? Show the results sorted by the district_id in ascending order.

select district_id, COUNT(*) as num_clients
from client
where district_id < 10
group by district_id
order by district_id asc;

-- Query 14. In the card table, how many cards exist for each type? Rank the result starting with the most frequent type.

select type, COUNT(*) as num_cards
from card
group by type
order by num_cards desc;

-- Query 15. Using the loan table, print the top 10 account_ids based on the sum of all of their loan amounts.

select account_id, SUM(amount) as total_loan_amount
from loan
group by account_id
order by total_loan_amount desc
limit 10;

-- Query 16. In the loan table, retrieve the number of loans issued for each day, before (excl) 930907, ordered by date in descending order.
select date, COUNT(*) as num_loans
from loan
where date < '930907'
group by date
order by date desc;

-- Query 17. In the loan table, for each day in December 1997, count the number of loans issued for each unique loan duration, ordered by date and duration, both in ascending order. You can ignore days without any loans in your output.

select date, duration, COUNT(*) as num_loans
from loan
where date >= '971201' and date < '980101'
group by date, duration
order by date asc, duration asc;

-- Query 18. In the trans table, for account_id 396, sum the amount of transactions for each type (VYDAJ = Outgoing, PRIJEM = Incoming). Your output should have the account_id, the type and the sum of amount, named as total_amount. Sort alphabetically by type.

select account_id, type, SUM(amount) as total_amount
from trans
where account_id = 396 and type in ('VYDAJ', 'PRIJEM')
GROUP BY account_id, type
ORDER BY type asc;

-- Query 19. From the previous output, translate the values for type to English, rename the column to transaction_type, round total_amount down to an integer

select
    account_id,
    case
        when type = 'VYDAJ' then 'Outgoing'
        when type = 'PRIJEM' then 'Incoming'
    end as transaction_type,
    FLOOR(SUM(amount)) as total_amount
from trans
where account_id = 396 and type in ('VYDAJ', 'PRIJEM')
group by account_id, type
order by transaction_type asc;

-- Query 20. 

select
    account_id,
    FLOOR(SUM(case 
    when type = 'PRIJEM' then amount 
    else 0 
    end))
    as incoming_amount,
    FLOOR(SUM(case 
    when type = 'VYDAJ' then amount
    else 0 
    end))
    as outgoing_amount,
    FLOOR(SUM(case
    when type = 'PRIJEM' then amount
    else -amount 
    end)) 
    as difference
from trans
where account_id = 396 and type in ('VYDAJ', 'PRIJEM')
group by account_id;

-- Qhery 21. Continuing with the previous example, rank the top 10 account_ids based on their difference.

SELECT
    account_id,
    FLOOR(SUM(CASE 
    WHEN type = 'PRIJEM' 
    THEN amount 
    ELSE -amount 
    END))
    AS difference
    FROM trans
    WHERE type IN ('VYDAJ', 'PRIJEM')
    GROUP BY account_id
    ORDER BY difference DESC
    LIMIT 10;


