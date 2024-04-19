schema Job(Workload):
    """ Job is a kind of workload profile that describes how to run your application code. This
    is typically used for tasks that take from a few seconds to a few days to complete.

    Attributes
    ----------
    schedule: str, default is Undefined, required.
        The scheduling strategy in Cron format. More info: https://en.wikipedia.org/wiki/Cron.

    Examples
    --------
    Instantiate a job with busybox image and runs every hour

    import kam.core.v1 as v1

    echoJob : v1.Job {
        containers: {
            "busybox": v1.Container{
                image:   "busybox:1.28"
                command: ["/bin/sh", "-c", "echo hello"]
            }
        }
        schedule: "0 * * * *"
    }
    """

    # The kind
    kind:                       "job" = "job"

    # The scheduling strategy in Cron format.
    # More info: https://en.wikipedia.org/wiki/Cron.
    schedule:                   str
