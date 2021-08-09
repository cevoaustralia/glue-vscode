from awsglue.dynamicframe import DynamicFrame

def filter_dynamic_frame(dyf: DynamicFrame, column_name: str, value: int):
    return dyf.filter(f=lambda x: x[column_name] > value)
