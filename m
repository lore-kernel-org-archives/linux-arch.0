From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 05/27] score: create head files cache.h cacheflush.h checksum.h cputime.h current.h
Date: Tue, 9 Jun 2009 19:07:16 +0200
Message-ID: <200906091907.17042.arnd@arndb.de>
References: <OF45377EDE.71658F7D-ON482575D0.0023440F-482575D0.0023B614@sunplusct.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:51823 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752AbZFIRHQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2009 13:07:16 -0400
In-Reply-To: <OF45377EDE.71658F7D-ON482575D0.0023440F-482575D0.0023B614@sunplusct.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: liqin.chen@sunplusct.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, torvalds@linux-foundation.org

On Tuesday 09 June 2009, liqin.chen@sunplusct.com wrote:
> diff --git a/arch/score/include/asm/cacheflush.h 
> b/arch/score/include/asm/cacheflush.h
> +extern void (*flush_cache_all)(void);
> +extern void (*flush_cache_mm)(struct mm_struct *mm);
> +extern void (*flush_cache_range)(struct vm_area_struct *vma,
> +                               unsigned long start, unsigned long end);
> +extern void (*flush_cache_page)(struct vm_area_struct *vma,
> +                               unsigned long page, unsigned long pfn);
> +extern void (*flush_cache_sigtramp)(unsigned long addr);
> +extern void (*flush_icache_all)(void);
> +extern void (*flush_icache_range)(unsigned long start, unsigned long 
> end);
> +extern void (*flush_data_cache_page)(unsigned long addr);

This is a somewhat unusual way to express these functions. It seems
that you only have one implementation for each of them, so I wonder
why you keep them as function pointers. Do you plan to add more CPUs
in the future that do these differently?

> --- /dev/null
> +++ b/arch/score/include/asm/current.h
> @@ -0,0 +1,15 @@
> +#ifndef _ASM_SCORE_CURRENT_H
> +#define _ASM_SCORE_CURRENT_H
> +
> +#include <linux/thread_info.h>
> +
> +struct task_struct;
> +
> +static inline struct task_struct *get_current(void)
> +{
> +       return current_thread_info()->task;
> +}
> +
> +#define current        get_current()
> +
> +#endif /* _ASM_SCORE_CURRENT_H */

This is basically the asm-generic version, so you could just use that
instead.

	Arnd <><
