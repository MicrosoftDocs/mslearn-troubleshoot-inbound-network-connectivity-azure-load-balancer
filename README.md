---
page_type: sample
languages:
- csharp
products:
- dotnet core
description: "Scripts and stress test application for the module"
urlFragment: "update-this-to-unique-url-stub"
---

# Official Microsoft Sample

<!-- 
Guidelines on README format: https://review.docs.microsoft.com/help/onboard/admin/samples/concepts/readme-template?branch=master

Guidance on onboarding samples to docs.microsoft.com/samples: https://review.docs.microsoft.com/help/onboard/admin/samples/process/onboarding?branch=master

Taxonomies for products and languages: https://review.docs.microsoft.com/new-hope/information-architecture/metadata/taxonomies?branch=master
-->

The repository contains the scripts that set up the lab environment for the module **Troubleshoot inbound network connectivity for Azure Load Balancer**. This repository also holds the code for the stress-testing application used by the lab.

## Contents

| File/folder       | Description                                |
|-------------------|--------------------------------------------|
| `src/scripts`     | Scripts that configure the lab environment |
| `src/stresstest`  | Source code for the stress test application|
| `.gitignore`      | Define what to ignore at commit time.      |
| `CHANGELOG.md`    | List of changes to the sample.             |
| `CONTRIBUTING.md` | Guidelines for contributing to the sample. |
| `README.md`       | This README file.                          |
| `LICENSE`         | The license for the sample.                |

## Prerequisites

The stress test application requires the .NET Core SDK.
The scripts are intended to be run from a BASH prompt in the Sandbox (Cloud Shell).

## Setup

At the start of the lab, run `bash src/setup.sh` to build the load balancer, virtual machines, and virtual network.

## Running the sample

To run the `stresstest` application:

    1. Move to the /src/stresstest folder.
    2. Run `dotnet stresstest $LOADBALANCERIP`
    3. Allow the application to run for 5 minutes, and then press Enter to close it.

After running the `stresstest` application, run `bash src/reconfigure.sh` to reconfigure the load balancer, virtual machines, and virtual network.

Run the `stresstest` application again and observe the results.

Follow the lab instructions to diagnose and correct the issues.

Run the `stresstest` application to verify that the system is functioning correctly again.

## Contributing

This project welcomes contributions and suggestions.  Most contributions require you to agree to a
Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us
the rights to use your contribution. For details, visit https://cla.opensource.microsoft.com.

When you submit a pull request, a CLA bot will automatically determine whether you need to provide
a CLA and decorate the PR appropriately (e.g., status check, comment). Simply follow the instructions
provided by the bot. You will only need to do this once across all repos using our CLA.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or
contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.
