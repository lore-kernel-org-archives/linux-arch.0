From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH 1/2] asm-generic/io.h: provide default ioremap/iounmap for !HAS_IOMEM
Date: Wed, 30 Mar 2016 13:19:55 +0900
Message-ID: <CAJKOXPe-yTTZ02L4mFX=_5x63TNjvzJitZU530Lgm8DprvK=Cg@mail.gmail.com>
References: <1459275781-3863-1-git-send-email-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34230 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750751AbcC3ET5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 30 Mar 2016 00:19:57 -0400
In-Reply-To: <1459275781-3863-1-git-send-email-robh@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Wed, Mar 30, 2016 at 3:23 AM, Rob Herring <robh@kernel.org> wrote:
> Drivers shouldn't have to care about HAS_IOMEM to compile and having to
> causes a Kconfig mess:
>
> warning: (MEDIA_SUBDRV_AUTOSELECT && VIDEO_CX231XX && INV_MPU6050_I2C) selects I2C_MUX which has unmet direct dependencies (I2C && HAS_IOMEM)
> warning: (ST_IRQCHIP && STMMAC_PLATFORM && DWMAC_IPQ806X && DWMAC_LPC18XX && DWMAC_ROCKCHIP && DWMAC_SOCFPGA && DWMAC_STI && TI_CPSW && PINCTRL_ROCKCHIP && PINCTRL_DOVE && POWER_RESET_KEYSTONE && S3C2410_WATCHDOG && VIDEO_OMAP3 && VIDEO_S5P_FIMC && USB_XHCI_MTK && RTC_DRV_AT91SAM9 && LPC18XX_DMAMUX && VIDEO_OMAP4 && HWSPINLOCK_QCOM && ATMEL_ST && QCOM_GSBI && PHY_HI6220_USB) selects MFD_SYSCON which has unmet direct dependencies (HAS_IOMEM)
>
> Reuse the !MMU variants for !HAS_IOMEM as they are sufficient for our
> needs. This fixes build errors for UM allyesconfig:
>
> drivers/mfd/syscon.c:89:2: error: implicit declaration of function 'iounmap' [-Werror=implicit-function-declaration]
>      iounmap(base);
>
> Reported-by: Fengguang Wu <fengguang.wu@intel.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-arch@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  include/asm-generic/io.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Some time ago I posted patches adding the dependency, but that path
looks like a better approach:

Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
