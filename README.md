# KAM (Kusion Application Model)

The Kusion Application Model represents KusionStack's opinionated abstraction of the core concepts during application delivery, and serves as a model source for the `kusion` tool when interpreting application developers' intent.

This `kam` repository holds the core KCL schema definitions (that are not meant for customizations at this point) for the following:

- The `AppConfiguration` schema which is the top layer abstraction representing an individual application to be shipped. The `AppConfiguration` contains several components such as `workload`, `accessories`, `labels` and `accessories`, which are expected to be well-known concepts to the application developers.

- The container-based `Workload` schemas (`Service` and `Job`) and their child schemas used to describe an application's compute workload, currently mapping to various implementations in the Kubernetes runtime.

## Extending KAM capabilities

As mentioned above, the core KCL schemas such as `AppConfiguration` and workloads are not meant for customizations at this point.

However, we have introduced the concept of [Kusion Modules](https://www.kusionstack.io/docs/kusion/concepts/kusion-module). Kusion Modules are the collection of modular building blocks that represent common and re-usable capabilities required during an application delivery.

The officially-maintained Kusion Modules are located in the [catalog](https://github.com/KusionStack/catalog) repository (source code) and [KusionStack container registry](https://github.com/orgs/KusionStack/packages) (published binaries). You can also build and publish your own modules. Here are some helpful starting points:
- [Kusion Module Concepts](https://www.kusionstack.io/docs/kusion/concepts/kusion-module)
- [Kusion Module Developer Guide](https://www.kusionstack.io/docs/kusion/concepts/kusion-module/develop-guide)
- [Kusion Module Scaffolding](https://github.com/KusionStack/kusion-module-scaffolding)