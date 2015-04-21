From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 00/23] gpio: sysfs: fixes and clean ups
Date: Tue, 21 Apr 2015 17:42:08 +0200
Message-ID: <1429630951-27082-1-git-send-email-johan@kernel.org>
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Harry Wei <harryxiyou@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org, linux-kernel@zh-kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

These patches fix a number of issues with the gpio sysfs interface,
including

 - fix memory leaks and crashes on device hotplug
 - straighten out the convoluted locking
 - reduce sysfs-interface latencies through more fine-grained locking
 - more clearly separate the sysfs-interface implementation from gpiolib
   core

The first patch is marked for stable and could go into 4.1. 

Unfortunately we can't just kill the gpio sysfs interface, but these
patches will make it more manageable and should allow us to implement a
new user-space interface while maintaining the old one (for a while at
least) without losing our sanity.

Note that there is still a race between chip remove and gpiod_request (and
therefore sysfs export), which needs to be fixed separately (for instance as
part of a generic solution to chip hotplugging).

Johan


Johan Hovold (23):
  gpio: sysfs: fix memory leaks and device hotplug
  gpio: clean up gpiochip_remove
  gpio: sysfs: drop redundant lock-as-irq
  gpio: sysfs: preparatory clean ups
  gpio: sysfs: reduce gpiochip-export locking scope
  gpio: sysfs: clean up chip class-device handling
  gpio: sysfs: rename gpiochip registration functions
  gpio: remove gpiod_sysfs_set_active_low
  gpio: sysfs: use DEVICE_ATTR macros
  gpio: sysfs: release irq after class-device deregistration
  gpio: sysfs: remove redundant export tests
  gpio: sysfs: add gpiod class-device data
  gpio: sysfs: remove redundant gpio-descriptor parameters
  gpio: sysfs: clean up interrupt-interface implementation
  gpio: sysfs: only call irq helper if needed
  gpio: sysfs: split irq allocation and deallocation
  gpio: sysfs: clean up edge_store
  gpio: sysfs: clean up gpiod_export_link locking
  gpio: sysfs: use per-gpio locking
  gpio: sysfs: fix race between gpiod export and unexport
  gpio: sysfs: rename active-low helper
  gpio: sysfs: remove FLAG_SYSFS_DIR
  gpio: sysfs: move irq trigger flags to class-device data

 Documentation/gpio/gpio-legacy.txt |   9 -
 Documentation/gpio/sysfs.txt       |   8 -
 Documentation/zh_CN/gpio.txt       |   8 -
 drivers/gpio/gpiolib-sysfs.c       | 561 +++++++++++++++++--------------------
 drivers/gpio/gpiolib.c             |  18 +-
 drivers/gpio/gpiolib.h             |  16 +-
 include/asm-generic/gpio.h         |   5 -
 include/linux/gpio.h               |   7 -
 include/linux/gpio/consumer.h      |   6 -
 include/linux/gpio/driver.h        |   4 +-
 10 files changed, 273 insertions(+), 369 deletions(-)

-- 
2.0.5

