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
        edx_compose_contents
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


def process_edx_compose(edx_compose):

    docker_compose = collections.OrderedDict({})
    docker_compose["version"] = "3"
    docker_compose["services"] = []

    env_variables = {
        "OPENEDX_{}_PORT".format(service.upper().replace("-", "_")): port_number
        for service, port_number in edx_compose['ports'].items()
    }

    return docker_compose, env_variables


def force_pyyaml_to_preserve_dict_order():
    _mapping_tag = yaml.resolver.BaseResolver.DEFAULT_MAPPING_TAG

    def dict_representer(dumper, data):
        return dumper.represent_dict(data.items())

    def dict_constructor(loader, node):
        return collections.OrderedDict(loader.construct_pairs(node))

    yaml.add_representer(collections.OrderedDict, dict_representer)
    yaml.add_constructor(_mapping_tag, dict_constructor)


exit(main(sys.argv[1:]))

