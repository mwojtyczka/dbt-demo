# https://docs.getdbt.com/docs/build/python-models
def model(dbt, session):

    diamonds_df = dbt.ref("diamonds_four_cs")  # you can reference models from different folders
    final_df = diamonds_df.select("carat", "cut").filter("carat is not NULL")
    # diamonds_df = session.sql("select carat, cut from diamonds_four_cs where carat is not NULL")

    return final_df
