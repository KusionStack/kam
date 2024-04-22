schema Service(Workload):
    """ Service is a kind of workload profile that describes how to run your application code. This
    is typically used for long-running web applications that should "never" go down, and handle
    short-lived latency-sensitive web requests, or events.

    Attributes
    ----------

    Examples
    --------
    # Instantiate a long-running service and its image is "nginx:v1"

    import kam.core.v1 as v1

    nginxSvc : v1.Service {
        containers: {
            "nginx": v1.Container {
                image: "nginx:v1"
            }
        }
    }
    """

    # The kind
    kind:                       "service" = "service"