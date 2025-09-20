from robot.running import TestSuiteBuilder
from robot.model import SuiteVisitor


class TagsOnTestCasesFinder(SuiteVisitor):
    def __init__(self):
        self.tests = list()

    def visit_test(self, test):
        self.tests.append(test.name)


def list_tests():
    builder = TestSuiteBuilder()
    testsuite = builder.build("tests/")
    finder = TagsOnTestCasesFinder()
    testsuite.visit(finder)
    for test in sorted(finder.tests):
        print(test)


if __name__ == "__main__":
    list_tests()
