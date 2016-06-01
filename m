From: Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org>
Subject: Re: [PATCH v4 04/16] rtc: sh: provide rtc_class_ops directly
Date: Wed, 1 Jun 2016 17:58:14 -0400
Message-ID: <20160601215814.GE10893@brightrain.aerifal.cx>
References: <1464634684-1248135-1-git-send-email-arnd@arndb.de>
 <1464634684-1248135-5-git-send-email-arnd@arndb.de>
Reply-To: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <rtc-linux+bncBCI4NDXKXQHBBIFVXW5AKGQEA3JEEAA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1464634684-1248135-5-git-send-email-arnd-r2nGTMty4D4@public.gmane.org>
Sender: Rich Felker <dalias-/miJ2pyFWUyWIDz0JBNUog@public.gmane.org>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/rtc-linux/subscribe>
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, deller-Mmb7MZpHnFY@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org, dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-alpha-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-m68k-cunTk1MwBs8S/qaLPR03pWD2FQJk+8+b@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

On Mon, May 30, 2016 at 08:57:52PM +0200, Arnd Bergmann wrote:
> The rtc-generic driver provides an architecture specific
> wrapper on top of the generic rtc_class_ops abstraction,
> and on sh, that goes through another indirection using
> the rtc_sh_get_time/rtc_sh_set_time functions.
> 
> This changes the sh rtc-generic device to provide its
> rtc_class_ops directly, skipping one of the abstraction
> levels.
> 
> Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>

I haven't tested any of this, but based on our discussion of the
previous version, I'm satisfied that it makes sense.

Acked-by: Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org>

> ---
>  arch/sh/include/asm/rtc.h | 11 -----------
>  arch/sh/kernel/time.c     | 33 ++++++++++++++++++++-------------
>  drivers/rtc/rtc-generic.c |  2 +-
>  3 files changed, 21 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/sh/include/asm/rtc.h b/arch/sh/include/asm/rtc.h
> index 52b0c2dba979..f7b010d48af7 100644
> --- a/arch/sh/include/asm/rtc.h
> +++ b/arch/sh/include/asm/rtc.h
> @@ -6,17 +6,6 @@ extern void (*board_time_init)(void);
>  extern void (*rtc_sh_get_time)(struct timespec *);
>  extern int (*rtc_sh_set_time)(const time_t);
>  
> -/* some dummy definitions */
> -#define RTC_BATT_BAD 0x100	/* battery bad */
> -#define RTC_SQWE 0x08		/* enable square-wave output */
> -#define RTC_DM_BINARY 0x04	/* all time/date values are BCD if clear */
> -#define RTC_24H 0x02		/* 24 hour mode - else hours bit 7 means pm */
> -#define RTC_DST_EN 0x01	        /* auto switch DST - works f. USA only */
> -
> -struct rtc_time;
> -unsigned int get_rtc_time(struct rtc_time *);
> -int set_rtc_time(struct rtc_time *);
> -
>  #define RTC_CAP_4_DIGIT_YEAR	(1 << 0)
>  
>  struct sh_rtc_platform_info {
> diff --git a/arch/sh/kernel/time.c b/arch/sh/kernel/time.c
> index d6d0a986c6e9..a4a7862b489a 100644
> --- a/arch/sh/kernel/time.c
> +++ b/arch/sh/kernel/time.c
> @@ -50,27 +50,31 @@ int update_persistent_clock(struct timespec now)
>  }
>  #endif
>  
> -unsigned int get_rtc_time(struct rtc_time *tm)
> +static int rtc_generic_get_time(struct device *dev, struct rtc_time *tm)
>  {
> -	if (rtc_sh_get_time != null_rtc_get_time) {
> -		struct timespec tv;
> +	struct timespec tv;
>  
> -		rtc_sh_get_time(&tv);
> -		rtc_time_to_tm(tv.tv_sec, tm);
> -	}
> -
> -	return RTC_24H;
> +	rtc_sh_get_time(&tv);
> +	rtc_time_to_tm(tv.tv_sec, tm);
> +	return 0;
>  }
> -EXPORT_SYMBOL(get_rtc_time);
>  
> -int set_rtc_time(struct rtc_time *tm)
> +static int rtc_generic_set_time(struct device *dev, struct rtc_time *tm)
>  {
>  	unsigned long secs;
>  
>  	rtc_tm_to_time(tm, &secs);
> -	return rtc_sh_set_time(secs);
> +	if ((rtc_sh_set_time == null_rtc_set_time) ||
> +	    (rtc_sh_set_time(secs) < 0))
> +		return -EOPNOTSUPP;
> +
> +	return 0;
>  }
> -EXPORT_SYMBOL(set_rtc_time);
> +
> +static const struct rtc_class_ops rtc_generic_ops = {
> +	.read_time = rtc_generic_get_time,
> +	.set_time = rtc_generic_set_time,
> +};
>  
>  static int __init rtc_generic_init(void)
>  {
> @@ -79,7 +83,10 @@ static int __init rtc_generic_init(void)
>  	if (rtc_sh_get_time == null_rtc_get_time)
>  		return -ENODEV;
>  
> -	pdev = platform_device_register_simple("rtc-generic", -1, NULL, 0);
> +	pdev = platform_device_register_data(NULL, "rtc-generic", -1,
> +					     &rtc_generic_ops,
> +					     sizeof(rtc_generic_ops));
> +
>  
>  	return PTR_ERR_OR_ZERO(pdev);
>  }
> diff --git a/drivers/rtc/rtc-generic.c b/drivers/rtc/rtc-generic.c
> index d726c6aa96a8..3958e87a05fa 100644
> --- a/drivers/rtc/rtc-generic.c
> +++ b/drivers/rtc/rtc-generic.c
> @@ -10,7 +10,7 @@
>  #include <linux/rtc.h>
>  
>  #if defined(CONFIG_M68K) || defined(CONFIG_PARISC) || \
> -    defined(CONFIG_PPC) || defined(CONFIG_SUPERH32)
> +    defined(CONFIG_PPC)
>  #include <asm/rtc.h>
>  
>  static int generic_get_time(struct device *dev, struct rtc_time *tm)
> -- 
> 2.7.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
