From: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH] asm-generic/io.h: remove asm/cacheflush.h include
Date: Fri, 26 Oct 2012 01:19:47 +0400
Message-ID: <CAMo8BfL3o=+JZiZJuR6kC+O=0Kf4quyXsxFTugdTs+Rfwn+zQQ@mail.gmail.com>
References: <1350984117-17369-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:44600 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038Ab2JYVTs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 25 Oct 2012 17:19:48 -0400
In-Reply-To: <1350984117-17369-1-git-send-email-james.hogan@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Jonas Bonn <jonas@southpole.se>, linux-arch@vger.kernel.org, linux@lists.openrisc.net, linux-kernel@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, linux-xtensa@linux-xtensa.org, Chris Zankel <chris@zankel.net>, Mike Frysinger <vapier@gentoo.org>, Chen Liqin <liqin.chen@sunplusct.com>, Lennox Wu <lennox.wu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>

On Tue, Oct 23, 2012 at 1:21 PM, James Hogan <james.hogan@imgtec.com> wrote:
> Including <asm/cacheflush.h> from <asm-generic/io.h> prevents
> cacheflush.h being able to use I/O functions like readl and writel due
> to circular include dependencies. It doesn't appear as if anything from
> cacheflush.h is actually used by the generic io.h, so remove the
> include.

Acked-by: Max Filippov <jcmvbkbc@gmail.com> for xtensa part.

> I've compile tested a defconfig compilation of blackfin, openrisc (which
> needed <asm/pgtable.h> including from it's <asm/io.h> to get the PAGE_*
> definitions), and xtensa.
>
> Other architectures which use asm-generic/io.h are score and unicore32,
> and looking at their io.h I don't see any obvious problems.
>
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: Mike Frysinger <vapier@gentoo.org>
> Cc: Chen Liqin <liqin.chen@sunplusct.com>
> Cc: Lennox Wu <lennox.wu@gmail.com>
> Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
> ---
> Any compile testing of score and unicore32 anybody could provide would
> be great.
>
>  arch/openrisc/include/asm/io.h |    1 +
>  include/asm-generic/io.h       |    1 -
>  2 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/openrisc/include/asm/io.h b/arch/openrisc/include/asm/io.h
> index 07f5299..7c69139 100644
> --- a/arch/openrisc/include/asm/io.h
> +++ b/arch/openrisc/include/asm/io.h
> @@ -30,6 +30,7 @@
>  #define PIO_MASK               0
>
>  #include <asm-generic/io.h>
> +#include <asm/pgtable.h>
>
>  extern void __iomem *__ioremap(phys_addr_t offset, unsigned long size,
>                                 pgprot_t prot);
> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> index 448303b..616eea5 100644
> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
> @@ -12,7 +12,6 @@
>  #define __ASM_GENERIC_IO_H
>
>  #include <asm/page.h> /* I/O is all done through memory accesses */
> -#include <asm/cacheflush.h>
>  #include <linux/types.h>
>
>  #ifdef CONFIG_GENERIC_IOMAP
> --
> 1.7.7.6
>
>



-- 
Thanks.
-- Max
