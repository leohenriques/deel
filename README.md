# deel task instructions

### Pre-requisites
1) Python (I used 3.9.11 but any Python 3 version should work)
2) run `pip install -r requirements.txt` to install the required python libs
2) you have PostgresSQL installed in your system

### Load data 
Simply execute the `main.py` file 


### Analysis 
1) in you preferred SQL client (e.g. DBeaver), execute the `./sql/dim_contracts.sql` and `./sql/dim_invoices.sql` files
2) run the queries in the `./sql/analysis.sql` file

## Challenges encountered

This was a really an interesting and nicely structured task! 
These were the main challenges that I faced:

1) Time constraint 3 hrs were too short for me to reach all the requirements

2) I've Spent too much time on the ingestion part as I needed to install Postgres in my machine, and get my head around reading from json and inserting into postgres. I started with the psycopg2 lib, but then I found it easier to do it with pandas and sqlalchemy.

3) The SQL questions were not difficult, I just wish to have had more time to really check the data for correctness and think of a better data model.
From the top of my head I could see 2 dims (contracts, invoices (to keep the version)) and a fact for the invoices (amounts). So we would have a nice star schema instead of a snowflake as it currently stands.

4) didn't have enough time to get to the docker part. Maybe next time :)


it took me around 3:20 mins to write the code. The readme is being written after that.

Thank you for having me it was an interesting challenge.
