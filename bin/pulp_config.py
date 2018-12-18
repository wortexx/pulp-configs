#
# Copyright (C) 2018 ETH Zurich, University of Bologna and
# GreenWaves Technologies
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#


import json_tools as js
import imp


def get_config(file, **kwargs):

    config = js.import_config_from_file(file, find=True)

    type_config = config.get_child_str("config_type")

    if type_config is None:

        return config

    else:

        if type_config == 'generator':
            
            generator = config.get_child_str("generator")

            file, path, descr = imp.find_module(generator, None)
            module = imp.load_module(generator, file, path, descr)

            return module.get_config(config, **kwargs)

        else:

            raise Exception('Unknown config type: ' + type_config)
