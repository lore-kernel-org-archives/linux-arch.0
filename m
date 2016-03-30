From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH 2/2] mfd: remove dependency on HAS_IOMEM
Date: Wed, 30 Mar 2016 13:23:36 +0900
Message-ID: <CAJKOXPfj8xQJaiZe73Y4RtKzGp7F7Lv02f8G-A4rcMAy0JOcWg@mail.gmail.com>
References: <1459275781-3863-1-git-send-email-robh@kernel.org>
	<1459275781-3863-2-git-send-email-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f194.google.com ([209.85.217.194]:36035 "EHLO
	mail-lb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954AbcC3EXi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 30 Mar 2016 00:23:38 -0400
In-Reply-To: <1459275781-3863-2-git-send-email-robh@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Wed, Mar 30, 2016 at 3:23 AM, Rob Herring <robh@kernel.org> wrote:
> Lots of drivers select MFD_SYSCON which depends on HAS_IOMEM and causes
> this kbuild warning if HAS_IOMEM is not enabled:
>
> warning: (ST_IRQCHIP && STMMAC_PLATFORM && DWMAC_IPQ806X && DWMAC_LPC18XX && DWMAC_ROCKCHIP && DWMAC_SOCFPGA && DWMAC_STI && TI_CPSW && PINCTRL_ROCKCHIP && PINCTRL_DOVE && POWER_RESET_KEYSTONE && S3C2410_WATCHDOG && VIDEO_OMAP3 && VIDEO_S5P_FIMC && USB_XHCI_MTK && RTC_DRV_AT91SAM9 && LPC18XX_DMAMUX && VIDEO_OMAP4 && HWSPINLOCK_QCOM && ATMEL_ST && QCOM_GSBI && PHY_HI6220_USB) selects MFD_SYSCON which has unmet direct dependencies (HAS_IOMEM)
>
> Now that we have ioremap/iounmap variants for !HAS_IOMEM, remove this
> dependency from MFD to fix this warning.
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/mfd/Kconfig | 2 --
>  1 file changed, 2 deletions(-)

Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
