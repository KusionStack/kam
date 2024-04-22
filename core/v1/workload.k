schema Workload(Object):
    """ Workload defines set of attributes shared by different workload profile, e.g Service
    and Job. You can inherit this Schema to reuse these common attributes.

    Attributes
    ----------
    containers: {str:Container}, default is Undefined, required.
        Containers defines the templates of containers to be ran.
        More info: https://kubernetes.io/docs/concepts/containers
    secrets: {str:Secret}, default is Undefined, optional.
        Secrets can be used to store small amount of sensitive data e.g. password, token.
    replicas: int, optional.
        Number of container replicas based on this configuration that should be ran.
    labels: {str:str}, default is Undefined, optional.
        The labels to set on target Kubernetes Workload resource.
    annotations: {str:str}, default is Undefined, optional.
        The annotations to set on target Kubernetes Workload resource.
    """

    # The templates of containers to be ran.
    containers:                 {str:Container}

    # Secrets store small amount of sensitive data e.g. a password, a token, or a key.
    secrets?:                   {str:Secret}

    # The number of containers that should be ran.
    replicas?:                  int

    # The labels to set on target Kubernetes Workload resource.
    labels?:                    {str:str}

    # The annotations to set on target Kubernetes Workload resource.
    annotations?:               {str:str}
