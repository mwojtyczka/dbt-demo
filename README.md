Welcome to my dbt demo project!

## Initiate dbt run from a local machine

Execute [resources/input_data.sql](resources/input_data.sql) script first in Databricks to setup input tables.

Update `http_path` in [profiles.yml](profiles.yml)` to specify http path to a Databricks SQL cluster that you want to use to run dbt sql models.

Just like SQL models, there are three ways to configure Python models (more [here](https://docs.getdbt.com/docs/build/python-models#configuring-python-models)):
* In [dbt_project.yml](dbt_project.yml), where you can configure many models at once or individual models
* In a dedicated .yml file, within the models/ directory (see [src/models/python_model1/config.yml](src/models/python_model1/config.yml)
* Within the model's .py file, using the dbt.config() method

You can use all-purpose or new job cluster (current config).

Then run the models as below:
```bash
# define workspace connection
export DBT_ACCESS_TOKEN=<pat_token>
export DBT_CLUSTER_ID=<cluster_id>
export DBT_HOST=<workspace_url>

# compile, run, test all models and generate documentation
# see: https://docs.getdbt.com/reference/dbt-commands

# Compiles (but does not run) the models in a project
dbt compile

# Loads CSV files into the database
dbt seed

# Runs the models in a project
dbt run

# Runs the tests defined in a project
dbt test

# Generates documentation for a project
dbt docs generate

# Serves the documentation for a project
dbt docs serve --host "" --port 8001

# run only unit tests
# https://docs.getdbt.com/docs/build/unit-tests
dbt test --select "test_type:unit"

# models from specific folders can be run individually
dbt run --target dev --model src/models/sql_demo1

# run individual models
dbt run --target dev --model --models game_details win_loss_records
```

## Ensure project best practices

Run the following commands to run [dbt project evaluator](https://github.com/dbt-labs/dbt-project-evaluator):
```bash
# install dbt packages defined in packages.yml
dbt deps

# run the evaluation
dbt build --select package:dbt_project_evaluator
```

## (Optional) Create separate tasks for each dbt model

By default, Databricks Workflows will run all dbt objects (seeds/snapshots/models/tests) in a single task.

To run each dbt object in a separate task, you can use the `databricks-dbt-factory` tool.

Install the library:
```shell
pip install databricks-dbt-factory
```

Update tasks in the job definition [resources/dbt_sql_job.yml](resources/dbt_sql_job.yml):
```shell
databricks_dbt_factory --dbt-manifest-path target/manifest.json --input-job-spec-path resources/dbt_sql_job.yml --target-job-spec-path resources/dbt_sql_job_explicit_tasks.yml --target '${bundle.target}' --project-directory ../ --profiles-directory . --environment-key Default --new-job-name dbt_sql_job_explicit_tasks
```

This will produce the following workflow:
![workflow](docs/workflow.png?)

## Deploy dbt project as Databricks Job using Databricks Assets Bundle (DAB)

You can run dbt project from a Databricks Job. 
In order to do that you can deploy the job using Databricks Assets Bundle (DAB).

To deploy the Databricks job using DAB run the following:
```bash
databricks auth login --host <workspace-url>  # optional step to configure pat token
databricks bundle deploy --target dev
```
You can optionally provide a profile (--profile) to specify the workspace and credentials 
(see [here](https://docs.databricks.com/en/dev-tools/cli/profiles.html)).

The job will get deployed to the workspace specified in the [databricks.yml](databricks.yml) file. 
The definition of the job can be found under [resources/dbt_sql_job.yml](resources/dbt_sql_job.yml).

The job will run dbt commands and will execute all models.

There are 2 types of clusters used in Databricks dbt jobs:
1. SQL Warehouse - cluster used to execute the dbt model
2. dbt CLI compute - cluster used to execute the dbt cli commands

## Resources

* Databricks Assets Bundle: https://docs.databricks.com/en/dev-tools/bundles/index.html
* DBT integration with Databricks: https://docs.databricks.com/en/partners/prep/dbt.html
* How to setup dbt job in Databricks: https://docs.databricks.com/en/jobs/how-to/use-dbt-in-workflows.html
* Example assets bundle project for dbt: https://github.com/databricks/bundle-examples/tree/main/dbt_sql
* Tutorial on executing dbt using Databricks job: https://docs.databricks.com/en/jobs/how-to/use-dbt-in-workflows.html
* Tests in dbt:
  * Model Contracts: https://docs.getdbt.com/docs/collaborate/govern/model-contracts
  * Data Tests: https://docs.getdbt.com/docs/build/data-tests
  * Unit Tests: https://docs.getdbt.com/docs/build/unit-tests