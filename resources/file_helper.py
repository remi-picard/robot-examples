from jinja2 import Environment, FileSystemLoader

# Initialiser l'environnement avec un dossier de templates
env = Environment(loader=FileSystemLoader("templates"))
template = env.get_template("mon_template.csv.j2")


def charger_template(data):
    contenu = template.render(data=data)
    return contenu
