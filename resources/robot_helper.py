from resources.ImmutableRobot import ImmutableRobot
from resources.Robot import Robot


def build_robot(name: str, color: str) -> Robot:
    return Robot(name, color)


def build_immutable_robot(name: str, color: str) -> ImmutableRobot:
    return ImmutableRobot(name, color)
