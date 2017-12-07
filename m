From: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 34/35] clocksource/drivers/Kconfig: Support andestech
 atcpit100 timer
Date: Thu, 7 Dec 2017 09:39:47 +0100
Message-ID: <091aa6eb-32f3-2a59-167f-c4eafa77de06@linaro.org>
References: <cover.1511785528.git.green.hu@gmail.com>
 <1a22db002413ff60851737736a86b40c38877220.1511785528.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1a22db002413ff60851737736a86b40c38877220.1511785528.git.green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org, dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Rick Chen <rickchen36-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

On 27/11/2017 13:28, Greentime Hu wrote:
> From: Rick Chen <rickchen36-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> Add CLKSRC_ATCPIT100 for Andestech atcpit100 timer selection.
> It often be used in Andestech AE3XX platform.
> 
> Signed-off-by: Rick Chen <rickchen36-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
