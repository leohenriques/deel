drop table if exists dim_contracts;
create table dim_contracts
as
with dim_contracts 
as (
select row_number() over(order by "RECEIVED_AT") as contract_key,
	   "CONTRACT_ID" as contract_id,
		"CLIENT_ID" as client_id,
		"CONTRACT_CREATED_AT"::timestamp as contract_created_at,
		"STATUS" as status,
		"COMPLETION_DATE"::timestamp as completion_date,
		"IS_DELETED"::boolean as is_deleted,
		"RECEIVED_AT"::timestamp as start_date,
		lead("RECEIVED_AT") over (partition by "CONTRACT_ID" order by "RECEIVED_AT") as end_date
from contracts
order by "RECEIVED_AT"
)

select *
from dim_contracts;

drop table if exists dim_invoices;
create table dim_invoices
as 
with dim_invoices 
as (
select  row_number() over(order by "RECEIVED_AT") as invoice_key,
		"INVOICE_ID" as invoice_id,
		"CONTRACT_ID" as contract_id,
		"AMOUNT"::money as amount,
		"CURRENCY"::text,
		"IS_EARLY_PAID"::boolean,
		"IS_DELETED"::boolean,
		"RECEIVED_AT"::timestamp as start_date,
		lead("RECEIVED_AT") over (partition by "INVOICE_ID" order by "RECEIVED_AT") as end_date
from invoices as inv 
)
select *
from dim_invoices 