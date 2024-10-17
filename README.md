Welcome to my dbt demo project!

## Run the dbt project from local machine

Execute all sql models/scripts in Databricks. 
One can group models into folders and deploy them separately.
```bash
export DBT_ACCESS_TOKEN=<pat_token>
export DBT_CLUSTER_ID=<cluster_id>
export DBT_HOST=<workspace_url>
dbt compile
dbt run
dbt test

# run for specific target and models
dbt run --target dev --model src/models/demo
dbt run --target dev --model --models zzz_game_details zzz_win_loss_records
```

## Deploy dbt project as Databricks Job

Run Databricks Assets Bundle (DAB) to deploy the project to Databricks job:
```bash
databricks auth login --host <workspace-url>  # optional step to configure pat token
databricks bundle deploy --target dev
```

This will run all project sql scripts. One can also create separate jobs to run group of sql scripts/models.

The job will get deployed to the workspace specified in the `databricks.yml` file. 
The definition of the job can be found under `resources/dbt_sql_job.yml`.

There are 2 types of clusters used in the job:
1. SQL Warehouse - cluster used to execute the dbt model
2. dbt CLI compute - cluster used to execute the dbt cli commands

## Resources

* Databricks Assets Bundle: https://docs.databricks.com/en/dev-tools/bundles/index.html
* DBT integration with Databricks: https://docs.databricks.com/en/partners/prep/dbt.html
* How to setup dbt job in Databricks: https://docs.databricks.com/en/jobs/how-to/use-dbt-in-workflows.html
* Example assets bundle project for dbt: https://github.com/databricks/bundle-examples/tree/main/dbt_sql