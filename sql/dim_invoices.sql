drop table if exists dim_invoices;
create table dim_invoices
as 
with dim_invoices 
as (
select  row_number() over(order by "RECEIVED_AT") as invoice_key,
		"INVOICE_ID" as invoice_id,
		"CONTRACT_ID" as contract_id,
		"AMOUNT"::decimal(18,2) as amount,
		"CURRENCY"::text as currency,
		"IS_EARLY_PAID"::boolean as is_early_paid,
		"IS_DELETED"::boolean as is_deleted,
		"RECEIVED_AT"::timestamp as start_date,
		lead("RECEIVED_AT") over (partition by "INVOICE_ID" order by "RECEIVED_AT") as end_date
from invoices as inv 
)
select *
from dim_invoices;
