#!/usr/bin/python3.6

import sys
import collections
from os import path

import yaml
    

def main(args):
    force_pyyaml_to_preserve_dict_order()

    if args:
        print("Expected no arguments")
        return 1

    for fpath in ['./edx-compose.yml', './edx-compose.yaml']:
        if path.exists(fpath):
            break
    else:
        print("No edx-compose YAML file")
        return 2

    try:
        with open(fpath, 'r') as f:
            edx_compose_contents = yaml.safe_load(f)
    except IOError as e:
        print("Couldn't read edx-compose YAML file: {}".format(e))
        return 3
    except yaml.YAMLError as e:
        print("edx-compose YAML is not valid YAML: {}".format(e))
        return 4

    docker_compose_contents, env_variables = process_edx_compose(
        edx_compose_contents, get_default_edx_compose()
    )
    try:
        with open('docker-compose.yml', 'w') as f:
            yaml.dump(docker_compose_contents, f, default_flow_style=False)
    except (IOError, yaml.YAMLError) as e:
        print("Couldn't write docker-compose.yml file: {}".format(e))
        return 5
    with open('.env', 'w') as f:
        for key, value in env_variables.items():
            f.write("{}={}\n".format(key, value))


def process_edx_compose(edx_compose, default_edx_compose):

    docker_compose = collections.OrderedDict({})
    docker_compose["version"] = "3"
    docker_compose["services"] = []

    ports = default_edx_compose['ports'].copy()
    ports.update(edx_compose.get('ports', {}))
    env_variables = {
        "OPENEDX_{}_PORT".format(service.upper().replace("-", "_")): port_number
        for service, port_number in ports.items()
    }

    image_version = edx_compose.get(
        'image_version', default_edx_compose['image_version']
    )
    env_variables.update(OPENEDX_IMAGE_VERSION=image_version)

    project_name = edx_compose.get(
        'project_name', default_edx_compose['project_name']
    )
    env_variables.update(COMPOSE_PROJECT_NAME=project_name)

    return docker_compose, env_variables


def get_default_edx_compose():
    with open('defaults.edx-compose.yml', 'r') as f:
        return yaml.safe_load(f)


def force_pyyaml_to_preserve_dict_order():
    _mapping_tag = yaml.resolver.BaseResolver.DEFAULT_MAPPING_TAG

    def dict_representer(dumper, data):
        return dumper.represent_dict(data.items())

    def dict_constructor(loader, node):
        return collections.OrderedDict(loader.construct_pairs(node))

    yaml.add_representer(collections.OrderedDict, dict_representer)
    yaml.add_constructor(_mapping_tag, dict_constructor)


exit(main(sys.argv[1:]))

