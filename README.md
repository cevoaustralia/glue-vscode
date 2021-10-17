# Glue Local Development Environment

This repository provides source for developing Glue with Docker and Visual Studio Code. For Glue 1.0 and Glue 2.0, the [Docker image that was published by AWS Glue team](https://aws.amazon.com/blogs/big-data/developing-aws-glue-etl-jobs-locally-using-a-container/) is used while a custom image is published to [CEVO Australia's public image repository](https://gallery.ecr.aws/i0m5p1b5/glue-base) for Glue 3.0 (and possibly later versions). Both the images can be used as a base image where additional python packages and dependencies can be updated.

See [Local Development of AWS Glue with Docker and Visual Studio Code](https://cevo.com.au/post/aws-glue-local-development/) for details of Glue 1.0 and 2.0 development. The associating branch is [v1.0-and-v2.0](https://github.com/cevoaustralia/glue-vscode/tree/v1.0-and-v2.0).

The soruce for later versions of Glue will be kept in a dedicated branch. For example, Glue 3.0 can be found in the [v3.0](https://github.com/cevoaustralia/glue-vscode/tree/v3.0) branch. A separate introduction will be added shortly.