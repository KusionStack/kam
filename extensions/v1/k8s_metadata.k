schema KubernetesMetadata:
    """ KubernetesMetadata extension enables you set Kubernetes metadata such as labels and annotations on all the
    Kubernetes resources of your Kusion Application.

    Attributes
    ----------
    labels: {str:str}, default is Undefined, optional.
        The Kubernetes labels to set on the application and its Kubernetes resources.
    annotations: {str:str}, default is Undefined, optional.
        The Kubernetes annotations to set on the application and its Kubernetes resources.

    Examples
    --------
    Instantiate a KubernetesMetadata extension with custom labels and annotations

    import kam.extensions.v1 as extv1

    kubeMetadataExt : extv1.KubernetesMetadata {
        labels: {
            "tier": "frontend"
        }
        annotations: {
            "team": "PE"
        }
    }
    """

    # The Kubernetes labels to set on the application and its Kubernetes resources.
    labels?:                    {str:str}

    # The Kubernetes annotations to set on the application and its Kubernetes resources.
    annotations?:               {str:str}