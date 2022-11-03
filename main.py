import pandas as pd
from sqlalchemy import create_engine



def clean_json(path_to_json):
    """removes th '\n' from the key"""
    with open(path_to_json) as f:
        data = f.read().replace(r'\n', '')
    return data

def insert_raw_data(table_name, path_to_json):

    connection_string = "postgresql://postgres@localhost:5432/deel"
    conn = create_engine(connection_string)
    json_str = clean_json(path_to_json=path_to_json)
    data = pd.read_json(json_str)    
    data = data.applymap(str)
    data = data.replace(r'^\s*$', None, regex=True)
    data.to_sql(name=table_name, con=conn, index=False, if_exists='replace')
    return data


if __name__ == '__main':
    insert_raw_data("contracts", "./data/contracts.json")
    insert_raw_data("invoices", "./data/invoices.json")
