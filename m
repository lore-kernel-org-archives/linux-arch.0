Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f195.google.com ([209.85.212.195]:50066 "EHLO
	mail-wi0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752165AbbBTSBa (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 20 Feb 2015 13:01:30 -0500
From: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Subject: [PATCH v2 00/18] Add support to STMicroelectronics STM32 family
Date: Fri, 20 Feb 2015 19:00:59 +0100
Message-ID: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: u.kleine-koenig@pengutronix.de, afaerber@suse.de, geert@linux-m68k.org, Rob Herring <robh+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Joe Perches <joe@perches.com>, Antti Palosaari <crope@iki.fi>, Tejun Heo <tj@kernel.org>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.cz>, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Message-ID: <20150220180059.ylb06Zu6Qx9Bb3QJicOeqlxGjSDPKgn7RPdJtddwyTo@z>

Thanks for the first round of reviews.
Most of the comments made have been taken into account (see below for details),
except that I failed to find an easy/clean way to move vector_table location in
order to limit the waste of memory.
If you have any idea/example to do that, I will be pleased to add it in next
version of the series.

STM32 MCUs are Cortex-M CPU, used in various applications (consumer
electronics, industrial applications, hobbyists...).
Datasheets, user and programming manuals are publicly available on
STMicroelectronics website.

With this series applied, the STM32F419 Discovery can boot succesfully.

Changes since v1:
-----------------
 - Move bindings documentation in their own patches (Andreas)
 - Rename ARM System timer to armv7m-systick (Rob)
 - Add clock-frequency property handling in armv7m-systick (Rob)
 - Re-factor the reset controllers into a single controller (Philipp)
 - Add kerneldoc to reset_controller_of_init (Philipp)
 - Add named constants in include/dt-bindings/reset/ (Philipp)
 - Make pinctrl driver to depend on ARCH_STM32 or COMPILE_TEST (Geert)
 - Introduce CPUV7M_NUM_IRQ config flag to indicate the number of interrupts
supported by the MCU, in order to limit memory waste in vectors' table (Uwe)


Maxime Coquelin (18):
  scripts: link-vmlinux: Don't pass page offset to kallsyms if XIP
    Kernel
  ARM: ARMv7M: Enlarge vector table to 256 entries
  dt-bindings: Document the ARM System timer bindings
  clocksource: Add ARM System timer driver
  reset: Add reset_controller_of_init() function
  dt-bindings: Document the STM32 reset bindings
  drivers: reset: Add STM32 reset driver
  dt-bindings: Document the STM32 timer bindings
  clockevent: Add STM32 Timer driver
  dt-bindings: Document the STM32 pin controller
  pinctrl: Add pinctrl driver for STM32 MCUs
  dt-bindings: Document the STM32 USART bindings
  serial: stm32-usart: Add STM32 USART Driver
  ARM: Add STM32 family machine
  ARM: dts: Add ARM System timer as clockevent in armv7m
  ARM: dts: Introduce STM32F429 MCU
  ARM: configs: Add STM32 defconfig
  MAINTAINERS: Add entry for STM32 MCUs

 Documentation/arm/stm32/overview.txt               |  32 +
 Documentation/arm/stm32/stm32f429-overview.txt     |  22 +
 .../devicetree/bindings/arm/armv7m_systick.txt     |  26 +
 .../devicetree/bindings/pinctrl/pinctrl-stm32.txt  |  99 +++
 .../devicetree/bindings/reset/st,stm32-reset.txt   |  36 +
 .../devicetree/bindings/serial/st,stm32-usart.txt  |  18 +
 .../devicetree/bindings/timer/st,stm32-timer.txt   |  19 +
 MAINTAINERS                                        |   7 +
 arch/arm/Kconfig                                   |  22 +
 arch/arm/Makefile                                  |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/armv7-m.dtsi                     |   7 +
 arch/arm/boot/dts/stm32f429-disco.dts              |  41 ++
 arch/arm/boot/dts/stm32f429.dtsi                   | 396 +++++++++++
 arch/arm/configs/stm32_defconfig                   |  72 ++
 arch/arm/kernel/entry-v7m.S                        |  13 +-
 arch/arm/mach-stm32/Makefile                       |   1 +
 arch/arm/mach-stm32/Makefile.boot                  |   0
 arch/arm/mach-stm32/board-dt.c                     |  31 +
 arch/arm/mm/Kconfig                                |  15 +
 drivers/clocksource/Kconfig                        |  16 +
 drivers/clocksource/Makefile                       |   2 +
 drivers/clocksource/armv7m_systick.c               |  78 +++
 drivers/clocksource/timer-stm32.c                  | 187 +++++
 drivers/pinctrl/Kconfig                            |  10 +
 drivers/pinctrl/Makefile                           |   1 +
 drivers/pinctrl/pinctrl-stm32.c                    | 779 +++++++++++++++++++++
 drivers/reset/Makefile                             |   1 +
 drivers/reset/core.c                               |  27 +
 drivers/reset/reset-stm32.c                        | 124 ++++
 drivers/tty/serial/Kconfig                         |  17 +
 drivers/tty/serial/Makefile                        |   1 +
 drivers/tty/serial/stm32-usart.c                   | 695 ++++++++++++++++++
 include/asm-generic/vmlinux.lds.h                  |   4 +-
 include/dt-bindings/pinctrl/pinctrl-stm32.h        |  43 ++
 include/dt-bindings/reset/st,stm32f429.h           |  85 +++
 include/linux/reset-controller.h                   |   6 +
 include/uapi/linux/serial_core.h                   |   3 +
 scripts/link-vmlinux.sh                            |   2 +-
 39 files changed, 2934 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/arm/stm32/overview.txt
 create mode 100644 Documentation/arm/stm32/stm32f429-overview.txt
 create mode 100644 Documentation/devicetree/bindings/arm/armv7m_systick.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-stm32.txt
 create mode 100644 Documentation/devicetree/bindings/reset/st,stm32-reset.txt
 create mode 100644 Documentation/devicetree/bindings/serial/st,stm32-usart.txt
 create mode 100644 Documentation/devicetree/bindings/timer/st,stm32-timer.txt
 create mode 100644 arch/arm/boot/dts/stm32f429-disco.dts
 create mode 100644 arch/arm/boot/dts/stm32f429.dtsi
 create mode 100644 arch/arm/configs/stm32_defconfig
 create mode 100644 arch/arm/mach-stm32/Makefile
 create mode 100644 arch/arm/mach-stm32/Makefile.boot
 create mode 100644 arch/arm/mach-stm32/board-dt.c
 create mode 100644 drivers/clocksource/armv7m_systick.c
 create mode 100644 drivers/clocksource/timer-stm32.c
 create mode 100644 drivers/pinctrl/pinctrl-stm32.c
 create mode 100644 drivers/reset/reset-stm32.c
 create mode 100644 drivers/tty/serial/stm32-usart.c
 create mode 100644 include/dt-bindings/pinctrl/pinctrl-stm32.h
 create mode 100644 include/dt-bindings/reset/st,stm32f429.h

-- 
1.9.1

