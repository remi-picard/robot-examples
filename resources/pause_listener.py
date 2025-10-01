"""Listener that stops execution if a test fails."""

from robot.api import logger

ROBOT_LISTENER_API_VERSION = 2


def end_test(name, attrs):
    if attrs["status"] == "FAIL":
        logger.warn(f"Test '{name}' failed: {attrs['message']}")
        input("Press enter to continue.")
