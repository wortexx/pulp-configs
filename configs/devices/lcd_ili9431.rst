LCD model
---------

This model supports the following parameters

=================== ==================================================== ================= ==================
Name                Description                                          Default value     Optional/Mandatory
=================== ==================================================== ================= ==================
interface           Interface where the device is connected.             
ctrl_interface      Control Interface where the device is connected.             spim0             Optional
cs                  Chip select where the device is connected.           0                 Optional
=================== ==================================================== ================= ==================

Here is an example: ::

  [board.devices.lcd_ili9431]
  include = devices/lcd_ili9431.json
  interface = spim0
  ctrl_interface = gpio0
  cs = 0