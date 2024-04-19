import extensions.v1 as extv1

schema AppConfiguration(Object):
    """ AppConfiguration is a developer-centric definition that describes how to run an Application.
    This application model builds upon a decade of experience at AntGroup running super large scale
    internal developer platform, combined with best-of-breed ideas and practices from the community.

    Attributes
    ----------
    workload: Service | Job, default is Undefined, required.
        Workload defines how to run your application code. Currently supported workload profile
        includes Service and Job.
    accessories: {str:any}, default is Undefined, optional.
        Accessories defines a collection of accessories that will be attached to the workload.
    extensions: [extv1.KubernetesMetadata], default is Undefined, optional.
        Labels can be used to attach arbitrary metadata as key-value pairs to resources.

    Examples
    --------
    # Instantiate an App with a long-running service and its image is "nginx:v1"

    import kam.core.v1 as v1

    helloworld : v1.AppConfiguration {
        workload: v1.Service {
            containers: {
                "nginx": v1.Container {
                    image: "nginx:v1"
                }
            }
        }
    }
    """

    # Workload defines how to run your application code.
    workload:                   Workload

    # Accessories defines a collection of accessories that will be attached to the workload.
    accessories?:               {str:Accessory}

    # Labels and annotations can be used to attach arbitrary metadata as key-value pairs to resources.
    extensions?:                [extv1.KubernetesMetadata]