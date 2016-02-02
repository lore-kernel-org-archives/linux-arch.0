From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/2] GPIO: Clean up asm/gpio.h
Date: Tue, 02 Feb 2016 13:53:15 -0600
Message-ID: <20160202194831.10827.63244.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58031 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756968AbcBBTxT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 2 Feb 2016 14:53:19 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexandre Courbot <gnurou@gmail.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arch@vger.kernel.org, linux-gpio@vger.kernel.org, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org

Many arches supply an asm/gpio.h that contains only this:

  #warning Include linux/gpio.h instead of asm/gpio.h
  #include <linux/gpio.h>

These two patches change all the places that include asm/gpio.h
so they include linux/gpio.h instead, and then remove the asm/gpio.h
files.

There are several arches that supply asm/gpio.h with useful
arch-specific content; I didn't touch those.

I assume Mark was heading this direction with 7563bbf89d06
("gpiolib/arches: Centralise bolierplate asm/gpio.h").

---

Bjorn Helgaas (2):
      gpio: Include linux/gpio.h instead of asm/gpio.h
      gpio: Remove unused asm/gpio.h files


 arch/alpha/include/asm/gpio.h                   |    4 ----
 arch/avr32/boards/merisc/setup.c                |    1 -
 arch/avr32/mach-at32ap/pio.c                    |    2 +-
 arch/blackfin/kernel/debug-mmrs.c               |    2 +-
 arch/blackfin/mach-bf538/boards/ezkit.c         |    2 +-
 arch/blackfin/mach-bf538/ext-gpio.c             |    2 +-
 arch/blackfin/mach-bf548/boards/cm_bf548.c      |    2 +-
 arch/blackfin/mach-bf548/boards/ezkit.c         |    2 +-
 arch/blackfin/mach-bf609/boards/ezkit.c         |    2 +-
 arch/blackfin/mach-common/ints-priority.c       |    2 +-
 arch/blackfin/mach-common/pm.c                  |    2 +-
 arch/ia64/include/asm/gpio.h                    |    4 ----
 arch/metag/include/asm/gpio.h                   |    4 ----
 arch/microblaze/include/asm/gpio.h              |    4 ----
 arch/openrisc/include/asm/gpio.h                |    4 ----
 arch/powerpc/include/asm/gpio.h                 |    4 ----
 arch/sh/include/mach-common/mach/magicpanelr2.h |    2 +-
 arch/sparc/include/asm/gpio.h                   |    4 ----
 arch/x86/include/asm/gpio.h                     |    4 ----
 arch/xtensa/include/asm/gpio.h                  |    4 ----
 drivers/ata/pata_at91.c                         |    3 +--
 drivers/ata/pata_bf54x.c                        |    2 +-
 drivers/gpio/gpio-mpc5200.c                     |    1 -
 drivers/mfd/menelaus.c                          |    2 +-
 drivers/mtd/onenand/omap2.c                     |    2 +-
 drivers/pcmcia/bfin_cf_pcmcia.c                 |    2 +-
 drivers/pcmcia/pxa2xx_vpac270.c                 |    1 -
 drivers/usb/gadget/udc/atmel_usba_udc.c         |    2 --
 drivers/usb/host/ohci-at91.c                    |    2 --
 drivers/video/fbdev/atmel_lcdfb.c               |    2 --
 drivers/video/fbdev/omap/lcd_h3.c               |    2 +-
 drivers/video/fbdev/omap/lcd_osk.c              |    3 +--
 drivers/video/fbdev/omap/lcd_palmtt.c           |    2 +-
 33 files changed, 18 insertions(+), 65 deletions(-)
 delete mode 100644 arch/alpha/include/asm/gpio.h
 delete mode 100644 arch/ia64/include/asm/gpio.h
 delete mode 100644 arch/metag/include/asm/gpio.h
 delete mode 100644 arch/microblaze/include/asm/gpio.h
 delete mode 100644 arch/openrisc/include/asm/gpio.h
 delete mode 100644 arch/powerpc/include/asm/gpio.h
 delete mode 100644 arch/sparc/include/asm/gpio.h
 delete mode 100644 arch/x86/include/asm/gpio.h
 delete mode 100644 arch/xtensa/include/asm/gpio.h
