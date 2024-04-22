import regex

schema Container:
    """ Container describes how the Application's tasks are expected to be run. Depending on
    the replicas parameter 1 or more containers can be created from each template.

    Attributes
    ----------
    image: str, default is Undefined, required.
        Image refers to the Docker image name to run for this container.
        More info: https://kubernetes.io/docs/concepts/containers/images
    command: [str], default is Undefined, optional.
        Entrypoint array. Not executed within a shell.
        Command will overwrite the ENTRYPOINT value set in the Dockfile, otherwise the Docker
        image's ENTRYPOINT is used if this is not provided.
    args: [str], default is Undefined, optional.
        Arguments to the entrypoint.
        Args will overwrite the CMD value set in the Dockfile, otherwise the Docker
        image's CMD is used if this is not provided.
    env: {str:str}, default is Undefined, optional.
        List of environment variables to set in the container.
        The value of the environment variable may be static text or a value from a secret.
    workingDir: str, default is Undefined, optional.
        The working directory of the running process defined in entrypoint.
        Default container runtime will be used if this is not specified.
    resources: {str:str}, default is Undefined, optional.
        Map of resource requirements the container should run with.
        The resources parameter is a dict with the key being the resource name and the value being
        the resource value.
    files: {str:FileSpec}, default is Undefined, optional.
        List of files to create in the container.
        The files parameter is a dict with the key being the file name in the container and the value
        being the target file specification.
    dirs: {str:str}, default is Undefined, optional.
        Collection of volumes mount into the container's filesystem.
        The dirs parameter is a dict with the key being the folder name in the container and the value
        being the referenced volume.
    livenessProbe: Probe, default is Undefined, optional.
        LivenessProbe indicates if a running process is healthy.
        Container will be restarted if the probe fails.
    readinessProbe: Probe, default is Undefined, optional.
        ReadinessProbe indicates whether an application is available to handle requests.
    startupProbe: Probe, default is Undefined, optional.
        StartupProbe indicates that the container has started for the first time.
        Container will be restarted if the probe fails.
    lifecycle: Lifecycle, default is Undefined, optional.
        Lifecycle refers to actions that the management system should take in response to container lifecycle events.

    Examples
    --------
    import kam.core.v1 as v1

    web = v1.Container {
        image:   "nginx:latest"
        command: ["/bin/sh", "-c", "echo hi"]
        env: {
            "name": "value"
        }
        resources: {
            "cpu": "2"
            "memory": "4Gi"
        }
    }
    """

    # Image to run for this container.
    image:                      str

    # Entrypoint array.
    # The image's ENTRYPOINT is used if this is not provided.
    command?:                   [str]
    # Arguments to the entrypoint.
    # The image's CMD is used if this is not provided.
    args?:                      [str]
    # Collection of environment variables to set in the container.
    # The value of environment variable may be static text or a value from a secret.
    env?:                       {str:str}
    # The current working directory of the running process defined in entrypoint.
    workingDir?:                str

    # Resource requirements for this container.
    resources?:                 {str:str}

    # Files configures one or more files to be created in the container.
    files?:                     {str:FileSpec}
    # Dirs configures one or more volumes to be mounted to the specified folder.
    dirs?:                      {str:str}

    # Liveness probe for this container.
    # Liveness probe indicates if a running process is healthy.
    livenessProbe?:             Probe
    # Readiness probe for this container.
    # Readiness probe indicates whether an application is available to handle requests.
    readinessProbe?:            Probe
    # Startup probe for this container.
    # Startup probe indicates that the container has started for the first time.
    startupProbe?:              Probe

    # Lifecycle configures actions which should be taken response to container lifecycle
    # events.
    lifecycle?:                 Lifecycle

    check:
        all e in env {
            regex.match(e, r"^[-._a-zA-Z][-._a-zA-Z0-9]*$")
        } if env, "a valid environment variable name must consist of alphabetic characters, digits, '_', '-', or '.', and must not start with a digit"

schema FileSpec:
    """ FileSpec defines the target file in a Container.

    Attributes
    ----------
    content: str, default is Undefined, optional.
        File content in plain text.
    contentFrom: str, default is Undefined, optional.
        Source for the file content, reference to a secret of configmap value.
    mode: str, default is Undefined, optional.
        Mode bits used to set permissions on this file, must be an octal value
        between 0000 and 0777 or a decimal value between 0 and 511

    Examples
    --------
    import kam.core.v1 as v1

    tmpFile = v1.FileSpec {
        content: "some file contents"
        mode: "0777"
    }
    """

    # The content of target file in plain text.
    content?:                   str

    # Source for the file content, might be a reference to a secret value.
    contentFrom?:               str

    # Mode bits used to set permissions on this file.
    # Defaults to 0644.
    mode:                       str = "0644"

    check:
        not content or not contentFrom, "content and contentFrom are mutually exclusive"
        regex.match(mode, r"^[0-7]{3,4}$"), "valid mode must between 0000 and 0777, both inclusive"

schema Probe:
    """ Probe describes a health check to be performed against a container to determine whether it is
    alive or ready to receive traffic. There are three probe types: readiness, liveness, and startup.

    Attributes
    ----------
    probeHandler: Exec | Http | Tcp, default is Undefined, required.
        The action taken to determine the alive or health of a container
    initialDelaySeconds: int, default is Undefined, optional.
        The number of seconds before health checking is activated.
        More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
    timeoutSeconds: int, default is Undefined, optional.
        The number of seconds after which the probe times out.
        More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
    periodSeconds: int, default is Undefined, optional.
        How often (in seconds) to perform the probe.
    successThreshold: int, default is Undefined, optional.
        Minimum consecutive successes for the probe to be considered successful after having failed.
    failureThreshold: int, default is Undefined, optional.
        Minimum consecutive failures for the probe to be considered failed after having succeeded.
    terminationGracePeriod: int, default is Undefined, optional.
        Duration in seconds before terminate gracefully upon probe failure.

    Examples
    --------
    import kam.core.v1 as v1

    probe = v1.Probe {
        probeHandler: v1.Http {
            path: "/healthz"
        }
        initialDelaySeconds: 10
    }
    """

    # The action taken to determine the health of a container
    probeHandler:               Exec | Http | Tcp

    # Number of seconds after the container has started before liveness probes are initiated.
    initialDelaySeconds?:       int

    # Number of seconds after which the probe times out.
    timeoutSeconds?:            int

    # How often (in seconds) to perform the probe.
    periodSeconds?:             int

    # Minimum consecutive successes for the probe to be considered successful after having failed.
    successThreshold?:          int

    # Minimum consecutive failures for the probe to be considered failed after having succeeded.
    failureThreshold?:          int

    # Duration in seconds before terminate gracefully upon probe failure.
    terminationGracePeriod?:    int

    check:
        initialDelaySeconds >= 0 if initialDelaySeconds, "initialDelaySeconds must be greater than or equal to 0"
        timeoutSeconds >= 0 if timeoutSeconds, "timeoutSeconds must be greater than or equal to 0"
        periodSeconds >= 0 if periodSeconds, "periodSeconds must be greater than or equal to 0"
        successThreshold >= 0 if successThreshold, "successThreshold must be greater than or equal to 0"
        failureThreshold >= 0 if failureThreshold, "failureThreshold must be greater than or equal to 0"
        terminationGracePeriod >= 0 if terminationGracePeriod, "terminationGracePeriod must be greater than or equal to 0"

schema Exec:
    """ Exec describes a "run in container" action.

    Attributes
    ----------
    command: [str], default is Undefined, required.
        The command line to execute inside the container.

    Examples
    --------
    import kam.core.v1 as v1

    execProbe = v1.Exec {
        command: ["probe.sh"]
    }
    """

    # The command line to execute inside the container.
    # Exit status of 0 is treated as live/healthy and non-zero is unhealthy.
    command:                    [str]

    check:
        len(command) > 0, "command must be specified"

schema Http:
    """ Http describes an action based on HTTP Get requests.

    Attributes
    ----------
    url: str, default is Undefined, required.
        The full qualified url to send HTTP requests.
    headers: {str:str}, default is Undefined, optional.
        Collection of custom headers to set in the request

    Examples
    --------
    import kam.core.v1 as v1

    httpProbe = v1.Http {
        url: "http://localhost:80"
        headers: {
            "X-HEADER": "VALUE"
        }
    }
    """

    # The full qualified url to send HTTP requests.
    url:                        str

    # Custom headers to set in the request.
    headers?:                   {str:str}

    check:
        all header in headers {
            regex.match(header, r"^[-A-Za-z0-9]+$")
        } if headers, "a valid HTTP header must consist of alphanumeric characters or '-' e.g X-Header-Name"

schema Tcp:
    """ Tcp describes an action based on opening a socket.

    Attributes
    ----------
    url: str, default is Undefined, required.
        The full qualified url to open a socket.

    Examples
    --------
    import kam.core.v1 as v1

    tcpProbe = v1.Tcp {
        url: "tcp://localhost:1234"
    }
    """

    # The full qualified url to open a socket.
    url:                        str

schema Lifecycle:
    """ Lifecycle describes actions that the management system should take in response
    to container lifecycle events.

    Attributes
    ----------
    preStop: p.Exec | p.Http, default is Undefined, optional.
        The action to be taken before a container is terminated due to an API request or
        management event such as liveness/startup probe failure, preemption, resource contention, etc.
        More info: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks
    postStart: p.Exec | p.Http, default is Undefined, optional.
        The action to be taken after a container is created.
        More info: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks

    Examples
    --------
    import kam.core.v1 as v1

    lifecycleHook = v1.Lifecycle {
        preStop: v1.Exec {
            command: ["preStop.sh"]
        }
        postStart: v1.Http {
            url: "http://localhost:80"
        }
    }
    """

    # The action to be taken before a container is terminated.
    preStop?:                   Exec | Http

    # The action to be taken after a container is created.
    postStart?:                 Exec | Http