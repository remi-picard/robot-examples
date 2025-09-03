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
```
