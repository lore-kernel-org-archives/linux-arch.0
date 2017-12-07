Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34553 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750947AbdLGIjv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Dec 2017 03:39:51 -0500
Received: by mail-wr0-f193.google.com with SMTP id y21so6576298wrc.1
        for <linux-arch@vger.kernel.org>; Thu, 07 Dec 2017 00:39:50 -0800 (PST)
Subject: Re: [PATCH v2 34/35] clocksource/drivers/Kconfig: Support andestech
 atcpit100 timer
References: <cover.1511785528.git.green.hu@gmail.com>
 <1a22db002413ff60851737736a86b40c38877220.1511785528.git.green.hu@gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <091aa6eb-32f3-2a59-167f-c4eafa77de06@linaro.org>
Date: Thu, 7 Dec 2017 09:39:47 +0100
MIME-Version: 1.0
In-Reply-To: <1a22db002413ff60851737736a86b40c38877220.1511785528.git.green.hu@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>, greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, linux-serial@vger.kernel.org
Cc: Rick Chen <rickchen36@gmail.com>
Message-ID: <20171207083947.DKiG-7zMuricDeRXMsxpKLp8HXx7--fQ6FQp4cW-wHs@z>

On 27/11/2017 13:28, Greentime Hu wrote:
> From: Rick Chen <rickchen36@gmail.com>
> 
> Add CLKSRC_ATCPIT100 for Andestech atcpit100 timer selection.
> It often be used in Andestech AE3XX platform.
> 
> Signed-off-by: Rick Chen <rickchen36@gmail.com>
> Signed-off-by: Greentime Hu <green.hu@gmail.com>
> ---
>  drivers/clocksource/Kconfig  |    6 ++++++
>  drivers/clocksource/Makefile |    1 +
>  2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index cc60620..591362a 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -615,4 +615,10 @@ config CLKSRC_ST_LPC
>  	  Enable this option to use the Low Power controller timer
>  	  as clocksource.
>  
> +config CLKSRC_ATCPIT100
> +	bool "Clocksource for AE3XX platform" if COMPILE_TEST
> +	depends on GENERIC_CLOCKEVENTS && HAS_IOMEM

You can remove the GENERIC_CLOCKEVENTS as now it is factored out in the
higher menuconfig option.



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
