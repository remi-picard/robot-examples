def ma_fonction(arg1: int, arg2: str, default_arg="default", *args, **kwargs) -> int:
    # ...
    return 42


ma_fonction(42, "Quarente-deux")
ma_fonction(42, "Quarente-deux", "override default value")
ma_fonction(42, "Quarente-deux", "default", 1, 2, 3)
ma_fonction(42, "Quarente-deux", "default", robot="Nono", john="Doe")
ma_fonction(42, "Quarente-deux", "default", 1, 2, 3, robot="Nono", john="Doe")
