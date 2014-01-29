From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH 49/73] drivers/mtd: delete non-required instances of
 include <linux/init.h>
Date: Tue, 28 Jan 2014 16:02:16 -0800
Message-ID: <20140129000216.GB8919@ld-irv-0074>
References: <1390339396-3479-1-git-send-email-paul.gortmaker@windriver.com>
 <1390339396-3479-50-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1390339396-3479-50-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, linux-mtd@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Tue, Jan 21, 2014 at 04:22:52PM -0500, Paul Gortmaker wrote:
> None of these files are actually using any __init type directives
> and hence don't need to include <linux/init.h>.  Most are just a
> left over from __devinit and __cpuinit removal, or simply due to
> code getting copied from one driver to the next.
> 
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Brian Norris <computersforpeace@gmail.com>
> Cc: linux-mtd@lists.infradead.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

> diff --git a/drivers/mtd/maps/sa1100-flash.c b/drivers/mtd/maps/sa1100-flash.c
> index 8fc06bf..3428034e 100644
> --- a/drivers/mtd/maps/sa1100-flash.c
> +++ b/drivers/mtd/maps/sa1100-flash.c
> @@ -7,7 +7,6 @@
>  #include <linux/types.h>
>  #include <linux/ioport.h>
>  #include <linux/kernel.h>
> -#include <linux/init.h>
>  #include <linux/errno.h>
>  #include <linux/slab.h>
>  #include <linux/platform_device.h>

This file uses __exit_p(), from <linux/init.h>. So I dropped this hunk
and pushed the rest to l2-mtd.git/next.

Thanks,
Brian
