From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] ACPI/IORT: Remove linker section for IORT entries again
Date: Thu, 8 Feb 2018 08:57:51 +0100
Message-ID: <39b1c62f-8784-e55a-3db0-5e7909031b65@linaro.org>
References: <1517976694-2004-1-git-send-email-hejianet@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1517976694-2004-1-git-send-email-hejianet@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jia He <hejianet@gmail.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-Id: linux-arch.vger.kernel.org

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
