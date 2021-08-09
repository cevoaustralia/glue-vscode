from pyspark.context import SparkContext
from awsglue.context import GlueContext
import pytest


@pytest.fixture(scope="session")
def glueContext():
    sparkContext = SparkContext()
    glueContext = GlueContext(sparkContext)
    yield glueContext
    sparkContext.stop()
