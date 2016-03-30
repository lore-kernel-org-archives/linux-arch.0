From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/2] asm-generic/io.h: provide default ioremap/iounmap for !HAS_IOMEM
Date: Wed, 30 Mar 2016 22:08:59 +0200
Message-ID: <CAMuHMdWc_97Yk7XJ6e4n6tibs99pPHSnJU2qqC7CGcoo4kWuNA@mail.gmail.com>
References: <1459275781-3863-1-git-send-email-robh@kernel.org>
	<3074778.3TElYrXjM1@wuerfel>
	<CAL_JsqKsXirYNa-mUTKqeP4ra8w+MW55we8pFmN=S0a7osLy4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:36826 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753142AbcC3UJA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 30 Mar 2016 16:09:00 -0400
In-Reply-To: <CAL_JsqKsXirYNa-mUTKqeP4ra8w+MW55we8pFmN=S0a7osLy4w@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee.jones@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Richard Weinberger <richard@nod.at>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Hi Rob,

On Tue, Mar 29, 2016 at 10:13 PM, Rob Herring <robh@kernel.org> wrote:
> On Tue, Mar 29, 2016 at 2:37 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Tuesday 29 March 2016 13:23:00 Rob Herring wrote:
>>> Drivers shouldn't have to care about HAS_IOMEM to compile and having to
>>> causes a Kconfig mess:
>>>
>>> warning: (MEDIA_SUBDRV_AUTOSELECT && VIDEO_CX231XX && INV_MPU6050_I2C) selects I2C_MUX which has unmet direct dependencies (I2C && HAS_IOMEM)
>>> warning: (ST_IRQCHIP && STMMAC_PLATFORM && DWMAC_IPQ806X && DWMAC_LPC18XX && DWMAC_ROCKCHIP && DWMAC_SOCFPGA && DWMAC_STI && TI_CPSW && PINCTRL_ROCKCHIP && PINCTRL_DOVE && POWER_RESET_KEYSTONE && S3C2410_WATCHDOG && VIDEO_OMAP3 && VIDEO_S5P_FIMC && USB_XHCI_MTK && RTC_DRV_AT91SAM9 && LPC18XX_DMAMUX && VIDEO_OMAP4 && HWSPINLOCK_QCOM && ATMEL_ST && QCOM_GSBI && PHY_HI6220_USB) selects MFD_SYSCON which has unmet direct dependencies (HAS_IOMEM)
>>>
>>> Reuse the !MMU variants for !HAS_IOMEM as they are sufficient for our
>>> needs. This fixes build errors for UM allyesconfig:
>>>
>>> drivers/mfd/syscon.c:89:2: error: implicit declaration of function 'iounmap' [-Werror=implicit-function-declaration]
>>>      iounmap(base);
>>>
>>> Reported-by: Fengguang Wu <fengguang.wu@intel.com>
>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>> Cc: linux-arch@vger.kernel.org
>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>
>> (adding Richard and the UML list to cc)
>>
>> I actually prototyped a patch that did the opposite: remove the readl/writel/...
>> definitions when HAS_IOMEM is unset. I didn't get far enough to submit it,
>> but see below for what I did.
>
> Ewww. Why do the opposite of what we do for every other Kconfig symbol
> which is provide empty functions? It really only functions as a
> disable on UML flag which runs counter to enabling drivers to build
> for all arches.

Usually the empty function fall into one of two classes:
  1. They return an error, so drivers will abort their initialization,
  2. They are a plain no-op, for functions with harmless side-effects.

The !MMU versions are not dummies, but assume a transparent translation.
This may lead to drivers continuing their initialization and crashing the
system.

> I actually started a patch to remove the HAS_IOMEM dependency
> everywhere (or just the per driver cases). It didn't break as bad as I
> expected, but became more than I wanted to fix. Mainly, all the devm_
> variants also need empty versions or to be always enabled.

Should these dependencies on HAS_IOMEM be changed to "HAS_IOMEM ||
COMPILE_TEST"?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
