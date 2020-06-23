From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH 1/2] media: omap3isp: Remove cacheflush.h
Date: Tue, 23 Jun 2020 08:20:26 +0200
Message-ID: <20200623082026.055d361a@coco.lan>
References: <20200622234740.72825-1-natechancellor@gmail.com>
        <20200622234740.72825-2-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730510AbgFWGUc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 23 Jun 2020 02:20:32 -0400
In-Reply-To: <20200622234740.72825-2-natechancellor@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, clang-built-linux@googlegroups.com

Em Mon, 22 Jun 2020 16:47:39 -0700
Nathan Chancellor <natechancellor@gmail.com> escreveu:

> After mm.h was removed from the asm-generic version of cacheflush.h,
> s390 allyesconfig shows several warnings of the following nature:
> 
> In file included from ./arch/s390/include/generated/asm/cacheflush.h:1,
>                  from drivers/media/platform/omap3isp/isp.c:42:
> ./include/asm-generic/cacheflush.h:16:42: warning: 'struct mm_struct'
> declared inside parameter list will not be visible outside of this
> definition or declaration
> 
> As Geert and Laurent point out, this driver does not need this header in
> the two files that include it. Remove it so there are no warnings.
> 
> Fixes: e0cf615d725c ("asm-generic: don't include <linux/mm.h> in cacheflush.h")
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> ---
>  drivers/media/platform/omap3isp/isp.c      | 2 --
>  drivers/media/platform/omap3isp/ispvideo.c | 1 -
>  2 files changed, 3 deletions(-)
> 
> diff --git a/drivers/media/platform/omap3isp/isp.c b/drivers/media/platform/omap3isp/isp.c
> index a4ee6b86663e..b91e472ee764 100644
> --- a/drivers/media/platform/omap3isp/isp.c
> +++ b/drivers/media/platform/omap3isp/isp.c
> @@ -39,8 +39,6 @@
>   *	Troy Laramy <t-laramy@ti.com>
>   */
>  
> -#include <asm/cacheflush.h>
> -
>  #include <linux/clk.h>
>  #include <linux/clkdev.h>
>  #include <linux/delay.h>
> diff --git a/drivers/media/platform/omap3isp/ispvideo.c b/drivers/media/platform/omap3isp/ispvideo.c
> index 10c214bd0903..1ac9aef70dff 100644
> --- a/drivers/media/platform/omap3isp/ispvideo.c
> +++ b/drivers/media/platform/omap3isp/ispvideo.c
> @@ -18,7 +18,6 @@
>  #include <linux/sched.h>
>  #include <linux/slab.h>
>  #include <linux/vmalloc.h>
> -#include <asm/cacheflush.h>
>  
>  #include <media/v4l2-dev.h>
>  #include <media/v4l2-ioctl.h>
> 
> base-commit: 27f11fea33608cbd321a97cbecfa2ef97dcc1821



Thanks,
Mauro
