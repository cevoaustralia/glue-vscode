from typing import List
from awsglue.dynamicframe import DynamicFrame
import pandas as pd
from src.utils import filter_dynamic_frame


def _get_sorted_data_frame(pdf: pd.DataFrame, columns_list: List[str] = None):
    if columns_list is None:
        columns_list = list(pdf.columns.values)
    return pdf.sort_values(columns_list).reset_index(drop=True)


def test_filter_dynamic_frame_by_value(glueContext):
    spark = glueContext.spark_session

    input = spark.createDataFrame(
        [("charly", 15), ("fabien", 18), ("sam", 21), ("sam", 25), ("nick", 19), ("nick", 40)],
        ["name", "age"],
    )

    expected_output = spark.createDataFrame(
        [("sam", 25), ("sam", 21), ("nick", 40)],
        ["name", "age"],
    )

    real_output = filter_dynamic_frame(DynamicFrame.fromDF(input, glueContext, "ouput"), "age", 20)

    pd.testing.assert_frame_equal(
        _get_sorted_data_frame(real_output.toDF().toPandas(), ["name", "age"]),
        _get_sorted_data_frame(expected_output.toPandas(), ["name", "age"]),
        check_like=True,
    )
