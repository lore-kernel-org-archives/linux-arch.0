From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 16/27] score: create head files scatterlist.h scoreregs.h sections.h segment.h sembuf.h setup.h shmbuf.h shmparam.h sigcontext.h siginfo.h signal.h socket.h sockios.h statfs.h stat.h string.h swab.h syscalls.h system.h
Date: Tue, 9 Jun 2009 19:39:01 +0200
Message-ID: <200906091939.01217.arnd@arndb.de>
References: <OF6E98041E.B5C6A199-ON482575D0.0023E412-482575D0.00245A53@sunplusct.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.177]:49699 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752AbZFIRjg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2009 13:39:36 -0400
In-Reply-To: <OF6E98041E.B5C6A199-ON482575D0.0023E412-482575D0.00245A53@sunplusct.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: liqin.chen@sunplusct.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, torvalds@linux-foundation.org

On Tuesday 09 June 2009, liqin.chen@sunplusct.com wrote:

> --- /dev/null
> +++ b/arch/score/include/asm/segment.h
> @@ -0,0 +1,21 @@
> +#ifndef _ASM_SCORE_SEGMENT_H
> +#define _ASM_SCORE_SEGMENT_H
> +
> +#ifndef __ASSEMBLY__
> +
> +typedef struct {
> +       unsigned long seg;
> +} mm_segment_t;
> +
> +#define KERNEL_DS      ((mm_segment_t){0})
> +#define USER_DS        KERNEL_DS
> +
> +# define get_ds()      (KERNEL_DS)
> +# define get_fs()      (current_thread_info()->addr_limit)
> +# define set_fs(x)     \
> +       do { current_thread_info()->addr_limit = (x); } while (0)
> +
> +# define segment_eq(a, b)      ((a).seg == (b).seg)
> +
> +# endif /* __ASSEMBLY__ */
> +#endif /* _ASM_SCORE_SEGMENT_H */

When I discussed these definitions with Michal Simek, we concluded
that they do not actually belong into segment.h. I added them to
asm-generic/uaccess.h, so if you can use that, you get them for free
and can have an empty segment.h file.

	Arnd <><
