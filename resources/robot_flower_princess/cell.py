from dataclasses import dataclass
from resources.robot_flower_princess.position import Position


@dataclass
class Cell:
    pos: Position
    piece: str
