From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 18/27] score: create head files uaccess.h unaligned.h unistd.h user.h
Date: Tue, 9 Jun 2009 19:46:10 +0200
Message-ID: <200906091946.10195.arnd@arndb.de>
References: <OF596C037E.9CF83913-ON482575D0.0024055D-482575D0.002476E7@sunplusct.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.188]:58775 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878AbZFIRqX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2009 13:46:23 -0400
In-Reply-To: <OF596C037E.9CF83913-ON482575D0.0024055D-482575D0.002476E7@sunplusct.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: liqin.chen@sunplusct.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, torvalds@linux-foundation.org

On Tuesday 09 June 2009, liqin.chen@sunplusct.com wrote:

> diff --git a/arch/score/include/asm/unaligned.h 
> b/arch/score/include/asm/unaligned.h
> new file mode 100644
> index 0000000..4b8fec0
> --- /dev/null
> +++ b/arch/score/include/asm/unaligned.h
> @@ -0,0 +1,11 @@
> +#ifndef _ASM_SCORE_UNALIGNED_H
> +#define _ASM_SCORE_UNALIGNED_H
> +
> +#include <linux/unaligned/le_struct.h>
> +#include <linux/unaligned/be_byteshift.h>
> +#include <linux/unaligned/generic.h>
> +
> +#define get_unaligned  __get_unaligned_le
> +#define put_unaligned  __put_unaligned_le
> +
> +#endif /* _ASM_SCORE_UNALIGNED_H */

Any reason not to use the asm-generic version of this file?
If it didn't work, that is probably a bug in my code, not
yours, but they really look compatible.

> diff --git a/arch/score/include/asm/unistd.h 
> b/arch/score/include/asm/unistd.h
> new file mode 100644
> index 0000000..0cbfef8
> --- /dev/null
> +++ b/arch/score/include/asm/unistd.h
> @@ -0,0 +1,12 @@
> +#ifndef _ASM_SCORE_UNISTD_H
> +#define _ASM_SCORE_UNISTD_H
> +
> +#define __ARCH_HAVE_MMU
> +#define __ARCH_WANT_SYSCALL_NO_AT
> +#define __ARCH_WANT_SYSCALL_NO_FLAGS
> +#define __ARCH_WANT_SYSCALL_OFF_T
> +#define __ARCH_WANT_SYSCALL_DEPRECATED
> +
> +#include <asm-generic/unistd.h>

I realize that this is the code I added to microblaze in my tree.
However, the four __ARCH_WANT_SYSCALL_* definitions are really
only meant as a transitional helper to get your code ported
from the older ABI. They should be removed from your file in 
order to get the short system call list. Have you tried this?

In order to get there, you probably need to add a lot of wrappers
to libc along the lines of

int unlink(const char *pathname)
{
	return unlinkat(AT_FDCWD, pathname, 0);
}

	Arnd <><
