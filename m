From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 08/27] score: create head files fb.h fcntl.h fixmap.h ftrace.h futex.h
Date: Tue, 9 Jun 2009 19:30:02 +0200
Message-ID: <200906091930.02985.arnd@arndb.de>
References: <OF7A6C7D8F.B4BC990D-ON482575D0.00236CE1-482575D0.0023DDA8@sunplusct.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:54235 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752AbZFIRaC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2009 13:30:02 -0400
In-Reply-To: <OF7A6C7D8F.B4BC990D-ON482575D0.00236CE1-482575D0.0023DDA8@sunplusct.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: liqin.chen@sunplusct.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, torvalds@linux-foundation.org

On Tuesday 09 June 2009, liqin.chen@sunplusct.com wrote:

> diff --git a/arch/score/include/asm/fb.h b/arch/score/include/asm/fb.h
> new file mode 100644
> index 0000000..6bb525e
> --- /dev/null
> +++ b/arch/score/include/asm/fb.h
> @@ -0,0 +1,15 @@
> +#ifndef _ASM_SCORE_FB_H
> +#define _ASM_SCORE_FB_H
> +
> +#include <linux/device.h>
> +
> +static inline void fb_pgprotect(struct file *file, struct vm_area_struct 
> *vma,
> +                               unsigned long off)
> +{}
> +
> +static inline int fb_is_primary_device(struct fb_info *info)
> +{
> +       return 0;
> +}
> +
> +#endif /* _ASM_SCORE_FB_H */

This is the same as the asm-generic version (better actually, because it
doesn't use macros). Just use the existing code here, and maybe add
a patch to fix that one to use an inline function as well ;-)

> index 0000000..ee16766
> --- /dev/null
> +++ b/arch/score/include/asm/fixmap.h
> @@ -0,0 +1,82 @@
> +#ifndef _ASM_SCORE_FIXMAP_H
> +#define _ASM_SCORE_FIXMAP_H

Hmm, I missed that file in my asm-generic series. Your code is 90% shared
with mips, parisc, sh, sparc and um, so it seems like I should put it
on my TODO list for generalization.

	Arnd <><
