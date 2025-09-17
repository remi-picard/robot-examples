from resources.robot_flower_princess.cell import Cell
from resources.robot_flower_princess.position import Position


def build_cell(x, y, piece):
    return Cell(Position(x, y), piece)


def build_position(x, y):
    return Position(x, y)
