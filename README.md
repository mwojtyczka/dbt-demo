Welcome to my dbt demo project!

## Run the dbt project from local machine

Execute `resources/input_data.sql` script first in Databricks.

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

## Ensure project best practices

Run the following commands to run [dbt project evaluator](https://github.com/dbt-labs/dbt-project-evaluator):
```
dbt deps # install dbt packages defined in packages.yml
dbt build --select package:dbt_project_evaluator
```

## Standardize SQL

Run [SQL linter and formatter](https://sqlfluff.com/):
```
sqlfluff lint src/models/*/*.sql
sqlfluff fix src/models/*/*.sql
```

More on dbt project best practices on Databricks here: https://www.databricks.com/blog/2022/12/15/best-practices-super-powering-your-dbt-project-databricks.html

## Deploy dbt project as Databricks Job

Run Databricks Assets Bundle (DAB) to deploy the project to Databricks job:
```bash
databricks auth login --host <workspace-url>  # optional step to configure pat token
databricks bundle deploy --target dev
```

This will run all project sql scripts. One can also create separate jobs to run group of sql scripts/models.

The job will get deployed to the workspace specified in the `databricks.yml` file. 
The definition of the job can be found under `resources/dbt_sql_job.yml`.

There are 2 types of clusters used in Databricks dbt jobs:
1. SQL Warehouse - cluster used to execute the dbt model
2. dbt CLI compute - cluster used to execute the dbt cli commands

## Resources

* Databricks Assets Bundle: https://docs.databricks.com/en/dev-tools/bundles/index.html
* DBT integration with Databricks: https://docs.databricks.com/en/partners/prep/dbt.html
* How to setup dbt job in Databricks: https://docs.databricks.com/en/jobs/how-to/use-dbt-in-workflows.html
* Example assets bundle project for dbt: https://github.com/databricks/bundle-examples/tree/main/dbt_sql