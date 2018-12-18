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

import generators.v1.system_gen as system_gen
from generators.v1.comp_gen import *



def get_config(tp, usecases=[]):

  chip              = tp.get_child_str('chip')

  includes = [
    "defaults.json",
    "chips/%s/defaults.json" % (chip)
  ]

  includes += usecases

  system = Config(
    config=system_gen.get_config(tp),
    includes=includes
  )



  return system.get_js_config()
