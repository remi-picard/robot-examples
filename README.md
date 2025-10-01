# Robot Framework Code Examples

## Installation

```
python -m venv venv
source env/bin/activate
pip install -r requirements.txt
robot --help
```

Configure le formattage automatique du code au moment du commit :

```bash
pre-commit install
# pre-commit installed at .git/hooks/pre-commit
```

Initialise le navigateur

```bash
rfbrowser init
```


## Lancement

```
source env/bin/activate
robot -t "Hello World" tests
robot -t "Mon Premier Test" tests
robot -P. tests/03-variable.robot
robot -P. tests/04-evaluate_python.robot
robot -P. tests/05-mes_premiers_keywords.robot
robot -P. tests/06-requests_library.robot
robot -P. tests/07-browser_library.robot
robot -P. tests/08-test_template.robot
robot -P. tests/09-bdd.robot
robot -P. tests/10-assertions.robot
robot -P. tests/11-jinja.robot
robot -P. tests/12-wait_until.robot
robot -P. tests/13-group.robot
robot -P. --variablefile conf/local.yaml tests/14-variablefile.robot
robot -P. -V conf/dev.yaml tests/14-variablefile.robot
robot -P. -v env:LOCAL tests/14-variable.robot
ENV=local;robot -P. tests/15-variable_env.robot
robot -P. tests/16-log_from_python.robot
robot -P. --removekeywords PASSED --removekeywords WUKS tests/17-remove_keywords.robot
robot -P. --flattenkeywords ITERATION tests/18-flatten_keywords.robot
robot -P. tests/19-tuple.robot
robot -P. tests/20-class_dataclass.robot
robot -P. tests/21-list_comprehension.robot
robot -P. tests/booker/booker.robot
robot -P. tests/todo_mvc/todo_mvc.robot
robot -P. --expandkeywords name:BuiltIn.Log -t "Deliver Flower To Princess" tests/robot_flower_princess/robot_flower_princess.robot
python resources/list_tests.py
robot --listener resources/pause_listener.py tests/22-failed-test.robot
robot -P. --dryrun tests
```
