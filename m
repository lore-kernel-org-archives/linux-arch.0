From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 16/16] h8300: misc functions
Date: Wed, 21 Jan 2015 10:01:59 +0100
Message-ID: <3896076.DdWKauEBRg@wuerfel>
References: <cover.1421813622.git.ysato@users.sourceforge.jp> <87d268vjm7.wl-ysato@users.sourceforge.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:51079 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918AbbAUJCN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 21 Jan 2015 04:02:13 -0500
In-Reply-To: <87d268vjm7.wl-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-arch@vger.kernel.org

On Wednesday 21 January 2015 13:32:48 Yoshinori Sato wrote:

> +unsigned long clk_get_rate(struct clk *clk)
> +{
> +	return clk->parent->rate;
> +}
> +EXPORT_SYMBOL(clk_get_rate)
> +
> +int clk_enable(struct clk *clk)
> +{
> +	return 0;
> +}
> +EXPORT_SYMBOL(clk_enable)
> +
> +void clk_disable(struct clk *clk)
> +{
> +}
> +EXPORT_SYMBOL(clk_disable)

If you are not too size constrained, you could consider using
the common clk implementation from drivers/clk/.

> +static struct clk master_clk;
> +
> +static struct clk peripheral_clk = {
> +	.parent = &master_clk,
> +};
> +
> +static struct clk_lookup lookups[] = {
> +	{
> +		.con_id = "master_clk",
> +		.clk = &master_clk,
> +	},
> +	{
> +		.con_id = "peripheral_clk",
> +		.clk = &peripheral_clk,
> +	},
> +};
> +
> +int __init h8300_clk_init(unsigned long hz)
> +{
> +	master_clk.rate = hz;
> +	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
> +	return 0;
> +}

Usually, we try to avoid global clock signal names to be requested by
drivers. Instead you should list the clock input name for each device
along with the device name, to allow drivers to be use the same string
for the clock signal independent of how a device is wired.

This would automatically work with dt.

> +EXPORT_SYMBOL(__gcc_bcmp);
> +EXPORT_SYMBOL(__ashldi3);
> +EXPORT_SYMBOL(__ashrdi3);
> +EXPORT_SYMBOL(__cmpdi2);
> +EXPORT_SYMBOL(__divdi3);
> +EXPORT_SYMBOL(__divsi3);
> +EXPORT_SYMBOL(__lshrdi3);
> +EXPORT_SYMBOL(__moddi3);
> +EXPORT_SYMBOL(__modsi3);
> +EXPORT_SYMBOL(__muldi3);
> +EXPORT_SYMBOL(__mulsi3);
> +EXPORT_SYMBOL(__negdi2);
> +EXPORT_SYMBOL(__ucmpdi2);
> +EXPORT_SYMBOL(__udivdi3);
> +EXPORT_SYMBOL(__udivmoddi4);

We don't normally use the __udivdi3/__udivmoddi4 functions from libgcc,
instead Linux drivers are required to use the do_div() or div64()
interfaces to do an expensive 64-bit division, to avoid accidentally
doing an expensive computation that can be reduced to a cheaper 32-bit
division. You can probably just drop these two symbols and still
use libgcc, though that would not catch the built-in (non-loadable module)
users.

An alternative would be to copy the implementation of the other functions
from libgcc source into the kernel and just export the symbols you actually
need. This also gives you better control over which implementation is
used, to avoid a toolchain dependency in the kernel. Most architectures
take this approach.

> diff --git a/arch/h8300/kernel/module.c b/arch/h8300/kernel/module.c
> new file mode 100644
> index 0000000..352aede
> --- /dev/null
> +++ b/arch/h8300/kernel/module.c
> @@ -0,0 +1,75 @@
> +#include <linux/moduleloader.h>
> +#include <linux/elf.h>
> +#include <linux/vmalloc.h>
> +#include <linux/fs.h>
> +#include <linux/string.h>
> +#include <linux/kernel.h>
> +
> +#if 0
> +#define DEBUGP printk
> +#else
> +#define DEBUGP(fmt...)
> +#endif

You can use the existing pr_debug() to the same effect.

> diff --git a/arch/h8300/kernel/sys_h8300.c b/arch/h8300/kernel/sys_h8300.c
> new file mode 100644
> index 0000000..aa2302c
> --- /dev/null
> +++ b/arch/h8300/kernel/sys_h8300.c
> @@ -0,0 +1,22 @@
> +/*
> + * linux/arch/h8300/kernel/sys_h8300.c
> + *
> + * This file contains various random system calls that
> + * have a non-standard calling sequence on the H8/300
> + * platform.
> + */
> +
> +#include <asm/setup.h>
> +#include <asm/uaccess.h>
> +
> +/* sys_cacheflush -- no support.  */
> +asmlinkage int
> +sys_cacheflush(unsigned long addr, int scope, int cache, unsigned long len)
> +{
> +	return -EINVAL;
> +}
> +
> +asmlinkage int sys_getpagesize(void)
> +{
> +	return PAGE_SIZE;
> +}

I think you can just drop these.

	Arnd
