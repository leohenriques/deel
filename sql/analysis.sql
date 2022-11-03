/*
a)How many active and deleted contracts are there per day?
*/

select date_trunc('day', start_date) as day,
	   count(1) FILTER (WHERE is_deleted) as deleted_contracts,
	   count(1) FILTER (WHERE not is_deleted) as active_contracts
from dim_contracts
where end_date is null
group by 1;

/*
b)	For each contract, how many active and deleted invoices are there per day?
*/

select date_trunc('day', start_date) as day,
	   contract_id,
   	   count(1) FILTER (WHERE is_deleted) as deleted_invoices,
	   count(1) FILTER (WHERE not is_deleted) as active_invoices
from dim_invoices
group by 1,2;

/*
c) What is the daily total “amount” for each contract, while active, with their corresponding currency?
*/

select date_trunc('day', start_date) as day,
	   contract_id,
	   currency,
	   sum(amount)
from dim_invoices
where not is_deleted
group by 1,2,3;


/*
d) Show the last version of each active invoice with their first received_at and their corresponding client_id
*/

with latest_version
as (
select invoice_key, invoice_id, contract_id, amount,currency, is_early_paid, is_deleted, start_date as received_at
from dim_invoices as inv
where end_date is null
), 
first_received_at
as (
select inv.invoice_id, c.client_id, min(inv.start_date) as first_received_at
	from dim_invoices as inv
		left join dim_contracts as c on c.contract_id = c.contract_id	
	group by 1,2
)
select fr.client_id, lv.*, fr.first_received_at
from latest_version as lv 
	inner join first_received_at as fr on fr.invoice_id = lv.invoice_id
