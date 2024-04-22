schema Object:
    """ Object is the root of the schema hierarchy. All top level schema definitions must inherit the Object schema,
    which includes fields that all schema definitions must have.

    Attributes
    ----------
    kind: str, default is Undefined, required.
        Kind is a string value representing the resource this schema represents.
    name: str, default is Undefined, required.
        Name of the resource this schema represents.
    """

    # Kind is a string value representing the resource this schema represents.
    kind:                       str

    # Name of the resource this schema represents.
    name:                       str
