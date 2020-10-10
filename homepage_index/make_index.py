# Standard library imports.

# Related third party imports.
import yaml
from jinja2 import Environment, FileSystemLoader, select_autoescape

# Local application/library specific imports.


with open('cv.yaml', 'r') as stream:
    cv_config = yaml.load(stream, Loader=yaml.Loader)
    
env = Environment(
    loader=FileSystemLoader('homepage_index/templates/'),
    autoescape=select_autoescape(['html', 'xml'])
)

template = env.get_template('index_template.html')

render = template.render(config=cv_config)
with open('index.html', 'w') as fh:
    fh.write(render)
