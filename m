Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:55530 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756996Ab3DPJdE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 16 Apr 2013 05:33:04 -0400
Received: by mail-wi0-f175.google.com with SMTP id c10so2400257wiw.8
        for <linux-arch@vger.kernel.org>; Tue, 16 Apr 2013 02:33:03 -0700 (PDT)
From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 0/4] remove GENERIC_GPIO
In-Reply-To: <1365445950-5736-1-git-send-email-gnurou@gmail.com>
References: <1365445950-5736-1-git-send-email-gnurou@gmail.com>
Date: Tue, 16 Apr 2013 10:32:59 +0100
Message-ID: <20130416093259.BEB0E3E14C0@localhost>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexandre Courbot <gnurou@gmail.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
Message-ID: <20130416093259.LpB9WqyMcO-9xXdBkcjy_desyP7WvwORi8ykLOg5_HA@z>

On Mon,  8 Apr 2013 11:32:26 -0700, Alexandre Courbot <gnurou@gmail.com> wrote:
> From: Alexandre Courbot <acourbot@nvidia.com>
> 
> Second version, based on -next this time, of the GENERIC_GPIO removal patches.
> Considering there is only a short amount of time before 3.10 merge window opens,
> I hope this version will be considered for inclusion, otherwise we'd end up
> with an half-baked removal or I will have to rebase everything for 3.11. :(
> 
> Grant, if this is ok with you, how shall we have this integrated into your
> branch? Half of this has been tested in my -next branch, and the present patches
> make the next half, should I resend you the whole series based on -next and
> withdraw my branch? This is a fast moving target, so we should try and shoot
> that duck as soon as we can! :)

Most of your patches are already in linux-next in a separate branch, so
the first thing to do is get these remaining patches into that same
branch. As we discussed on IRC, you need to move yor current
"remove_generic_gpio" branch into your for_next branch so that it is
picked up by Stephen. There isn't any functional change there, but it
means that your series will be based on a defined point of Linus' tree
(v3.9-rc6) instead of an arbitrary commit point between -rc3 and -rc4.

As for these four new patches, I'll reply to each of them with an
ack/nak. For the ones I ack, add them to your for_next branch right
away so they get into linux-next. You'll also want to send an email to
Stephen with the fixups that you already know about so that he can deal
with the breakage in linux-next caused by the remove GENERIC_GPIO
commit.

g.

> 
> Changes from v1:
> * Rebased on -next
> * Added Chinese documentation update from Chen Baozi
> 
> Alexandre Courbot (3):
>   gpio: convert selectors of GENERIC_GPIO to GPIOLIB
>   gpio: remove GENERIC_GPIO config option
>   gpio: rename CONFIG_GPIOLIB to CONFIG_GPIO
> 
> Chen Baozi (1):
>   gpio: update gpio Chinese documentation
> 
>  Documentation/gpio.txt                            | 51 ++++++++-----------
>  Documentation/zh_CN/gpio.txt                      | 14 ++---
>  arch/alpha/Kconfig                                |  5 +-
>  arch/arm/Kconfig                                  | 62 +++++++++++------------
>  arch/arm/configs/ape6evm_defconfig                |  2 +-
>  arch/arm/configs/kzm9d_defconfig                  |  2 +-
>  arch/arm/configs/mvebu_defconfig                  |  2 +-
>  arch/arm/configs/realview-smp_defconfig           |  2 +-
>  arch/arm/configs/realview_defconfig               |  2 +-
>  arch/arm/mach-bcm/Kconfig                         |  2 +-
>  arch/arm/mach-bcm2835/Kconfig                     |  2 +-
>  arch/arm/mach-highbank/Kconfig                    |  2 +-
>  arch/arm/mach-imx/Kconfig                         |  2 +-
>  arch/arm/mach-mxs/Kconfig                         |  2 +-
>  arch/arm/mach-nomadik/Kconfig                     |  2 +-
>  arch/arm/mach-omap2/Kconfig                       |  2 +-
>  arch/arm/mach-picoxcell/Kconfig                   |  2 +-
>  arch/arm/mach-prima2/Kconfig                      |  2 +-
>  arch/arm/mach-s3c24xx/Kconfig                     |  2 +-
>  arch/arm/mach-shmobile/Kconfig                    | 37 +++++++-------
>  arch/arm/mach-socfpga/Kconfig                     |  4 +-
>  arch/arm/mach-spear/Kconfig                       |  2 +-
>  arch/arm/mach-tegra/Kconfig                       |  2 +-
>  arch/arm/mach-vexpress/Kconfig                    |  2 +-
>  arch/arm/mach-virt/Kconfig                        |  2 +-
>  arch/arm/mach-vt8500/Kconfig                      |  2 +-
>  arch/arm/plat-orion/Makefile                      |  2 +-
>  arch/arm/plat-orion/gpio.c                        |  2 +-
>  arch/arm/plat-samsung/Kconfig                     |  2 +-
>  arch/arm64/Kconfig                                |  5 +-
>  arch/avr32/Kconfig                                |  5 +-
>  arch/blackfin/Kconfig                             |  5 +-
>  arch/blackfin/configs/BF518F-EZBRD_defconfig      |  2 +-
>  arch/blackfin/configs/BF526-EZBRD_defconfig       |  2 +-
>  arch/blackfin/configs/BF527-AD7160-EVAL_defconfig |  2 +-
>  arch/blackfin/configs/BF527-EZKIT-V2_defconfig    |  2 +-
>  arch/blackfin/configs/BF527-EZKIT_defconfig       |  2 +-
>  arch/blackfin/configs/BF527-TLL6527M_defconfig    |  2 +-
>  arch/blackfin/configs/BF533-EZKIT_defconfig       |  2 +-
>  arch/blackfin/configs/BF533-STAMP_defconfig       |  2 +-
>  arch/blackfin/configs/BF537-STAMP_defconfig       |  2 +-
>  arch/blackfin/configs/BF538-EZKIT_defconfig       |  2 +-
>  arch/blackfin/configs/BF548-EZKIT_defconfig       |  2 +-
>  arch/blackfin/configs/BF561-ACVILON_defconfig     |  2 +-
>  arch/blackfin/configs/BF561-EZKIT-SMP_defconfig   |  2 +-
>  arch/blackfin/configs/BF561-EZKIT_defconfig       |  2 +-
>  arch/blackfin/configs/BF609-EZKIT_defconfig       |  2 +-
>  arch/blackfin/configs/CM-BF527_defconfig          |  2 +-
>  arch/blackfin/configs/CM-BF537E_defconfig         |  2 +-
>  arch/blackfin/configs/CM-BF537U_defconfig         |  2 +-
>  arch/blackfin/configs/CM-BF561_defconfig          |  2 +-
>  arch/blackfin/configs/DNP5370_defconfig           |  2 +-
>  arch/blackfin/configs/TCM-BF518_defconfig         |  2 +-
>  arch/blackfin/include/asm/gpio.h                  |  6 +--
>  arch/blackfin/kernel/bfin_gpio.c                  |  2 +-
>  arch/blackfin/mach-bf538/Makefile                 |  2 +-
>  arch/blackfin/mach-bf538/include/mach/gpio.h      |  2 +-
>  arch/hexagon/Kconfig                              |  7 +--
>  arch/ia64/Kconfig                                 |  5 +-
>  arch/m68k/Kconfig                                 |  3 --
>  arch/m68k/Kconfig.cpu                             |  2 +-
>  arch/m68k/include/asm/mcfgpio.h                   |  4 +-
>  arch/m68k/platform/coldfire/gpio.c                |  2 +-
>  arch/metag/Kconfig                                |  3 --
>  arch/microblaze/Kconfig                           |  5 +-
>  arch/microblaze/configs/mmu_defconfig             |  2 +-
>  arch/microblaze/configs/nommu_defconfig           |  2 +-
>  arch/microblaze/kernel/reset.c                    |  2 +-
>  arch/mips/Kconfig                                 | 25 ++++-----
>  arch/mips/alchemy/Kconfig                         |  2 +-
>  arch/mips/alchemy/common/Makefile                 |  2 +-
>  arch/mips/alchemy/common/gpiolib.c                |  2 +-
>  arch/mips/bcm47xx/Kconfig                         |  4 +-
>  arch/mips/configs/db1000_defconfig                |  2 +-
>  arch/mips/configs/gpr_defconfig                   |  2 +-
>  arch/mips/configs/mtx1_defconfig                  |  2 +-
>  arch/mips/include/asm/mach-au1x00/gpio-au1000.h   |  4 +-
>  arch/mips/include/asm/mach-au1x00/gpio-au1300.h   |  4 +-
>  arch/mips/include/asm/mach-au1x00/gpio.h          |  8 +--
>  arch/mips/include/asm/mach-generic/gpio.h         |  2 +-
>  arch/mips/loongson/common/Makefile                |  2 +-
>  arch/mips/txx9/generic/setup.c                    |  2 +-
>  arch/openrisc/Kconfig                             |  5 +-
>  arch/powerpc/Kconfig                              |  7 +--
>  arch/powerpc/configs/40x/virtex_defconfig         |  2 +-
>  arch/powerpc/configs/44x/virtex5_defconfig        |  2 +-
>  arch/powerpc/configs/mpc512x_defconfig            |  2 +-
>  arch/powerpc/configs/wii_defconfig                |  2 +-
>  arch/powerpc/platforms/40x/Kconfig                |  2 +-
>  arch/powerpc/platforms/44x/Kconfig                |  2 +-
>  arch/powerpc/platforms/512x/Kconfig               |  2 +-
>  arch/powerpc/platforms/52xx/mpc52xx_gpt.c         |  8 +--
>  arch/powerpc/platforms/83xx/Kconfig               |  6 +--
>  arch/powerpc/platforms/85xx/Kconfig               | 16 +++---
>  arch/powerpc/platforms/86xx/Kconfig               |  8 +--
>  arch/powerpc/platforms/8xx/Kconfig                |  2 +-
>  arch/powerpc/platforms/Kconfig                    |  8 +--
>  arch/sh/Kconfig                                   | 23 ++++-----
>  arch/sh/boards/Kconfig                            | 18 +++----
>  arch/sh/boards/mach-highlander/Kconfig            |  2 +-
>  arch/sh/boards/mach-rsk/Kconfig                   |  6 +--
>  arch/sh/boards/mach-sdk7786/Makefile              |  2 +-
>  arch/sh/boards/mach-x3proto/Makefile              |  2 +-
>  arch/sh/include/asm/gpio.h                        |  4 +-
>  arch/sh/kernel/cpu/sh2a/Makefile                  |  3 +-
>  arch/sh/kernel/cpu/sh3/Makefile                   |  2 +-
>  arch/sh/kernel/cpu/sh4a/Makefile                  |  2 +-
>  arch/sparc/Kconfig                                |  7 +--
>  arch/unicore32/Kconfig                            |  7 +--
>  arch/x86/Kconfig                                  | 15 +++---
>  arch/xtensa/Kconfig                               |  7 +--
>  arch/xtensa/configs/s6105_defconfig               |  4 +-
>  drivers/bcma/Kconfig                              |  2 +-
>  drivers/block/Kconfig                             |  2 +-
>  drivers/char/tpm/Kconfig                          |  2 +-
>  drivers/extcon/Kconfig                            |  2 +-
>  drivers/gpio/Kconfig                              | 19 ++++---
>  drivers/gpio/Makefile                             |  2 +-
>  drivers/gpio/gpio-lpc32xx.c                       |  2 +-
>  drivers/hwmon/Kconfig                             |  4 +-
>  drivers/i2c/busses/Kconfig                        |  4 +-
>  drivers/i2c/muxes/Kconfig                         |  2 +-
>  drivers/iio/magnetometer/Kconfig                  |  2 +-
>  drivers/input/keyboard/Kconfig                    |  6 +--
>  drivers/input/keyboard/adp5588-keys.c             |  4 +-
>  drivers/input/keyboard/adp5589-keys.c             |  4 +-
>  drivers/input/misc/Kconfig                        |  8 +--
>  drivers/input/mouse/Kconfig                       |  2 +-
>  drivers/input/touchscreen/Kconfig                 |  4 +-
>  drivers/input/touchscreen/ad7879.c                |  4 +-
>  drivers/leds/Kconfig                              |  8 +--
>  drivers/leds/leds-tca6507.c                       |  8 +--
>  drivers/leds/trigger/Kconfig                      |  2 +-
>  drivers/media/dvb-frontends/cxd2820r_core.c       |  6 +--
>  drivers/media/dvb-frontends/cxd2820r_priv.h       |  2 +-
>  drivers/media/radio/wl128x/Kconfig                |  2 +-
>  drivers/media/usb/em28xx/em28xx-dvb.c             |  4 +-
>  drivers/mfd/Kconfig                               | 26 +++++-----
>  drivers/misc/ti-st/Kconfig                        |  2 +-
>  drivers/mtd/maps/Kconfig                          |  2 +-
>  drivers/mtd/nand/Kconfig                          |  2 +-
>  drivers/net/phy/Kconfig                           |  2 +-
>  drivers/pinctrl/Kconfig                           |  4 +-
>  drivers/pinctrl/core.c                            |  4 +-
>  drivers/pinctrl/sh-pfc/Kconfig                    | 30 +++++------
>  drivers/pinctrl/spear/Kconfig                     |  2 +-
>  drivers/platform/x86/Kconfig                      |  2 +-
>  drivers/power/Kconfig                             |  2 +-
>  drivers/regulator/Kconfig                         |  2 +-
>  drivers/reset/Kconfig                             |  2 +-
>  drivers/spi/Kconfig                               |  8 +--
>  drivers/ssb/Kconfig                               |  2 +-
>  drivers/staging/android/Kconfig                   |  2 +-
>  drivers/staging/cptm1217/Kconfig                  |  2 +-
>  drivers/staging/iio/accel/Kconfig                 |  2 +-
>  drivers/staging/iio/adc/Kconfig                   |  6 +--
>  drivers/staging/iio/addac/Kconfig                 |  2 +-
>  drivers/staging/iio/resolver/Kconfig              |  4 +-
>  drivers/staging/iio/trigger/Kconfig               |  2 +-
>  drivers/staging/nvec/Kconfig                      |  2 +-
>  drivers/staging/vme/devices/Kconfig               |  2 +-
>  drivers/tty/serial/Kconfig                        |  2 +-
>  drivers/tty/serial/max310x.c                      |  8 +--
>  drivers/usb/phy/Kconfig                           |  2 +-
>  drivers/video/Kconfig                             |  4 +-
>  drivers/video/backlight/Kconfig                   |  4 +-
>  drivers/w1/masters/Kconfig                        |  2 +-
>  include/asm-generic/gpio.h                        |  6 +--
>  include/linux/gpio.h                              |  6 +--
>  include/linux/leds-tca6507.h                      |  2 +-
>  include/linux/spi/ad7879.h                        |  2 +-
>  include/sound/soc.h                               |  6 +--
>  net/rfkill/Kconfig                                |  2 +-
>  sound/soc/codecs/wm5100.c                         |  4 +-
>  sound/soc/codecs/wm8903.c                         |  4 +-
>  sound/soc/codecs/wm8962.c                         |  4 +-
>  sound/soc/codecs/wm8996.c                         |  4 +-
>  sound/soc/soc-jack.c                              |  4 +-
>  178 files changed, 393 insertions(+), 462 deletions(-)
> 
> -- 
> 1.8.2
> 

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
