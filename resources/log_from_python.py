from robot.api import logger


def log_from_python():
    logger.info("Hello From Python Keyword")
    _private_method()


def _private_method():
    # _private_method n'est pas affichée dans le rapport HTML
    return 42
