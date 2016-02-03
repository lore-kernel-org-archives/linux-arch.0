From: Alexandre Courbot <gnurou@gmail.com>
Subject: Re: [PATCH 1/2] gpio: Include linux/gpio.h instead of asm/gpio.h
Date: Wed, 3 Feb 2016 09:02:24 +0900
Message-ID: <CAAVeFu+O9GTPsyDP=dhi2Sg3uZTZOKUH7PK2vOfKTDGvKN8Ppg@mail.gmail.com>
References: <20160202194831.10827.63244.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20160202195323.10827.26654.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:33856 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011AbcBCACo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 2 Feb 2016 19:02:44 -0500
In-Reply-To: <20160202195323.10827.26654.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-arch <linux-arch@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, Feb 3, 2016 at 4:53 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Most arches have an asm/gpio.h that merely includes linux/gpio.h.  The
> others select ARCH_HAVE_CUSTOM_GPIO_H, and when that's selected,
> linux/gpio.h includes asm/gpio.h.

Looks correct if that's really what happens, GPIO includes can be tricky...

>  arch/avr32/boards/merisc/setup.c                |    1 -
>  arch/avr32/mach-at32ap/pio.c                    |    2 +-
>  arch/blackfin/kernel/debug-mmrs.c               |    2 +-
>  arch/blackfin/mach-bf538/boards/ezkit.c         |    2 +-
>  arch/blackfin/mach-bf538/ext-gpio.c             |    2 +-
>  arch/blackfin/mach-bf548/boards/cm_bf548.c      |    2 +-
>  arch/blackfin/mach-bf548/boards/ezkit.c         |    2 +-
>  arch/blackfin/mach-bf609/boards/ezkit.c         |    2 +-
>  arch/blackfin/mach-common/ints-priority.c       |    2 +-
>  arch/blackfin/mach-common/pm.c                  |    2 +-
>  arch/sh/include/mach-common/mach/magicpanelr2.h |    2 +-
>  drivers/ata/pata_at91.c                         |    3 +--
>  drivers/ata/pata_bf54x.c                        |    2 +-
>  drivers/gpio/gpio-mpc5200.c                     |    1 -
>  drivers/mfd/menelaus.c                          |    2 +-
>  drivers/mtd/onenand/omap2.c                     |    2 +-
>  drivers/pcmcia/bfin_cf_pcmcia.c                 |    2 +-
>  drivers/pcmcia/pxa2xx_vpac270.c                 |    1 -
>  drivers/usb/gadget/udc/atmel_usba_udc.c         |    2 --
>  drivers/usb/host/ohci-at91.c                    |    2 --
>  drivers/video/fbdev/atmel_lcdfb.c               |    2 --
>  drivers/video/fbdev/omap/lcd_h3.c               |    2 +-
>  drivers/video/fbdev/omap/lcd_osk.c              |    3 +--
>  drivers/video/fbdev/omap/lcd_palmtt.c           |    2 +-

Driver code should most definitely never include asm/gpio.h directly.

I may be overlooking some intricate detail, but the simplification is welcome.

Acked-by: Alexandre Courbot <acourbot@nvidia.com>
