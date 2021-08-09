from awsglue.dynamicframe import DynamicFrame
from awsglue.transforms import Join
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext

glueContext = GlueContext(SparkContext.getOrCreate())

DATABASE = "legislators"
OUTPUT_PATH = "s3://glue-python-samples-fbe445ee/output_dir"

## create dynamic frames from data catalog
persons: DynamicFrame = glueContext.create_dynamic_frame.from_catalog(
    database=DATABASE, table_name="persons_json"
)

memberships: DynamicFrame = glueContext.create_dynamic_frame.from_catalog(
    database=DATABASE, table_name="memberships_json"
)

orgs: DynamicFrame = glueContext.create_dynamic_frame.from_catalog(
    database=DATABASE, table_name="organizations_json"
)

## manipulate data
orgs = (
    orgs.drop_fields(["other_names", "identifiers"])
    .rename_field("id", "org_id")
    .rename_field("name", "org_name")
)

l_history: DynamicFrame = Join.apply(
    orgs, Join.apply(persons, memberships, "id", "person_id"), "org_id", "organization_id"
)
l_history = l_history.drop_fields(["person_id", "org_id"])

l_history.printSchema()

## write to s3
glueContext.write_dynamic_frame.from_options(
    frame=l_history,
    connection_type="s3",
    connection_options={"path": f"{OUTPUT_PATH}/legislator_history"},
    format="parquet",
)