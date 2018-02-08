Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34443 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750815AbeBHH54 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Feb 2018 02:57:56 -0500
Received: by mail-wm0-f67.google.com with SMTP id j21-v6so26082894wmh.1
        for <linux-arch@vger.kernel.org>; Wed, 07 Feb 2018 23:57:55 -0800 (PST)
Subject: Re: [PATCH] ACPI/IORT: Remove linker section for IORT entries again
References: <1517976694-2004-1-git-send-email-hejianet@gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <39b1c62f-8784-e55a-3db0-5e7909031b65@linaro.org>
Date: Thu, 8 Feb 2018 08:57:51 +0100
MIME-Version: 1.0
In-Reply-To: <1517976694-2004-1-git-send-email-hejianet@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jia He <hejianet@gmail.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Message-ID: <20180208075751.6mgcfqSloSFPg76rqgU1j5ngAwbpGOIYaz9bX0vxKMg@z>

On 07/02/2018 05:11, Jia He wrote:
> In commit 316ca8804ea8 ("ACPI/IORT: Remove linker section for IORT entries
> probing"), iort entries was removed in vmlinux.lds.h. But in
> commit 2fcc112af37f ("clocksource/drivers: Rename clksrc table to timer"),
> this line was back incorrectly.
> 
> It does no harm except for adding some useless symbols, so fix it.
> 
> Signed-off-by: Jia He <hejianet@gmail.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>  include/asm-generic/vmlinux.lds.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 1ab0e52..58b1dab 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -589,7 +589,6 @@
>  	IRQCHIP_OF_MATCH_TABLE()					\
>  	ACPI_PROBE_TABLE(irqchip)					\
>  	ACPI_PROBE_TABLE(timer)						\
> -	ACPI_PROBE_TABLE(iort)						\
>  	EARLYCON_TABLE()
>  
>  #define INIT_TEXT							\

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
