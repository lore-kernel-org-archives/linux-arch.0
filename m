From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v9 11/17] h8300: clock driver
Date: Mon, 27 Apr 2015 11:04:19 +0200
Message-ID: <2321574.fdIMjhZdv2@wuerfel>
References: <1430112924-1134-1-git-send-email-ysato@users.sourceforge.jp> <1430112924-1134-12-git-send-email-ysato@users.sourceforge.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:54615 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932169AbbD0JEZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 27 Apr 2015 05:04:25 -0400
In-Reply-To: <1430112924-1134-12-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Monday 27 April 2015 14:35:18 Yoshinori Sato wrote:
> +static struct platform_driver cpg_driver = {
> +	.driver = {
> +		.name = DEVNAME,
> +	},
> +	.probe = clk_probe,
> +};
> +
> +early_platform_init(DEVNAME, &cpg_driver);
> +
> +static struct platform_device clk_device = {
> +	.name		= DEVNAME,
> +	.id		= 0,
> +};
> +
> +static struct platform_device *devices[] __initdata = {
> +	&clk_device,
> +};
> +
> +int __init h8300_clk_init(int hz)
> +{
> +	static int master_hz;
> +
> +	master_hz = hz;
> +	clk_device.dev.platform_data = &master_hz;
> +	early_platform_add_devices(devices,
> +				   ARRAY_SIZE(devices));
> +	early_platform_driver_register_all(DEVNAME);
> +	early_platform_driver_probe(DEVNAME, 1, 0);
> +	return 0;
> +}

Clock drivers are generally not 'platform_drivers'. Please do one of two
things:

a) use CLK_OF_DECLARE() to register a probe function, and use a device
   tree for describing your hardware

b) rename clk_probe() to h8300_clk_init() and just call that function
   from the architecture code.


> +int __init h8300_clk_init(int hz)
> +{
> +	static int master_hz;
> +
> +	master_hz = hz;
> +	clk_device.dev.platform_data = &master_hz;
> +	early_platform_add_devices(devices,
> +				   ARRAY_SIZE(devices));
> +	early_platform_driver_register_all(DEVNAME);
> +	early_platform_driver_probe(DEVNAME, 1, 0);
> +	return 0;
> +}

Here you have the same code again, which means the two files are mutually
exclusive. This is generally not a good idea. Instead, it's better to
make it possible to build a kernel that supports all the hardware, even
if in practice you would not want to run that kernel.

If you use CLK_OF_DECLARE(), it becomes trivial to make the two files
coexist, otherwise use two different function names here and make the
architecture code decide which one to call.

> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index df69531..931860b 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -675,6 +675,18 @@ static inline void clk_writel(u32 val, u32 __iomem *reg)
>  	iowrite32be(val, reg);
>  }
>  
> +#elif IS_ENABLED(CONFIG_H8300)
> +
> +static inline u32 clk_readl(u32 __iomem *reg)
> +{
> +	return __raw_readb(reg);
> +}
> +
> +static inline void clk_writel(u32 val, u32 __iomem *reg)
> +{
> +	__raw_writeb(val, reg);
> +}
> +
>  #else	/* platform dependent I/O accessors */

Why not use the same code as powerpc here? Drivers should normally
not use __raw_* accessors, and the ioread32be on powerpc should work here
as well.

	Arnd
