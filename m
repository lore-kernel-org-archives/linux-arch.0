From: Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 1/2] asm-generic/io.h: provide default ioremap/iounmap for
 !HAS_IOMEM
Date: Tue, 29 Mar 2016 21:50:15 +0200
Message-ID: <56FADC77.1060703@nod.at>
References: <1459275781-3863-1-git-send-email-robh@kernel.org>
 <3074778.3TElYrXjM1@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from a.ns.miles-group.at ([95.130.255.143]:11949 "EHLO radon.swed.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754056AbcC2TuU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 29 Mar 2016 15:50:20 -0400
In-Reply-To: <3074778.3TElYrXjM1@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>
Cc: Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Am 29.03.2016 um 21:37 schrieb Arnd Bergmann:
> On Tuesday 29 March 2016 13:23:00 Rob Herring wrote:
>> Drivers shouldn't have to care about HAS_IOMEM to compile and having to
>> causes a Kconfig mess:
>>
>> warning: (MEDIA_SUBDRV_AUTOSELECT && VIDEO_CX231XX && INV_MPU6050_I2C) selects I2C_MUX which has unmet direct dependencies (I2C && HAS_IOMEM)
>> warning: (ST_IRQCHIP && STMMAC_PLATFORM && DWMAC_IPQ806X && DWMAC_LPC18XX && DWMAC_ROCKCHIP && DWMAC_SOCFPGA && DWMAC_STI && TI_CPSW && PINCTRL_ROCKCHIP && PINCTRL_DOVE && POWER_RESET_KEYSTONE && S3C2410_WATCHDOG && VIDEO_OMAP3 && VIDEO_S5P_FIMC && USB_XHCI_MTK && RTC_DRV_AT91SAM9 && LPC18XX_DMAMUX && VIDEO_OMAP4 && HWSPINLOCK_QCOM && ATMEL_ST && QCOM_GSBI && PHY_HI6220_USB) selects MFD_SYSCON which has unmet direct dependencies (HAS_IOMEM)
>>
>> Reuse the !MMU variants for !HAS_IOMEM as they are sufficient for our
>> needs. This fixes build errors for UM allyesconfig:
>>
>> drivers/mfd/syscon.c:89:2: error: implicit declaration of function 'iounmap' [-Werror=implicit-function-declaration]
>>      iounmap(base);
>>
>> Reported-by: Fengguang Wu <fengguang.wu@intel.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: linux-arch@vger.kernel.org
>> Signed-off-by: Rob Herring <robh@kernel.org>
> 
> (adding Richard and the UML list to cc)

For the above error I've sent already a fix:
https://lkml.org/lkml/2016/3/25/321

> I actually prototyped a patch that did the opposite: remove the readl/writel/...
> definitions when HAS_IOMEM is unset. I didn't get far enough to submit it,
> but see below for what I did.
> 
> I think it makes sense to do either one or the other.
> 
> 	Arnd
> 
> diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
> index a043107..f6dc17a 100644
> --- a/drivers/char/Kconfig
> +++ b/drivers/char/Kconfig
> @@ -8,6 +8,7 @@ source "drivers/tty/Kconfig"
>  
>  config DEVMEM
>  	bool "/dev/mem virtual device support"
> +	depends on HAS_IOMEM

Hmm, this means no /dev/mem device for UML? (And some s390 variants).
Not sure if this a good idea.
But I like it more than having ioremap/iounmap stubs for !HAS_IOMEM. :)

Thanks,
//richard
