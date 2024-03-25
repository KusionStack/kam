schema Service(WorkloadBase):
    """ Service is a kind of workload profile that describes how to run your application code. This
    is typically used for long-running web applications that should "never" go down, and handle
    short-lived latency-sensitive web requests, or events.

    Attributes
    ----------

    Examples
    --------
    # Instantiate a long-running service and its image is "nginx:v1"

    import kam.workload as wl
    import kam.workload.container as c

    nginxSvc : wl.Service {
        containers: {
            "nginx": c.Container {
                image: "nginx:v1"
            }
        }
    }
    """