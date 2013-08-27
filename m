From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH 3/4] asm-generic: Add missing include guards
Date: Tue, 27 Aug 2013 14:08:44 +0100
Message-ID: <521CA4DC.6010506@imgtec.com>
References: <1375996022-8298-1-git-send-email-linux@rasmusvillemoes.dk> <1375996022-8298-4-git-send-email-linux@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:14700 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753028Ab3H0NI5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 27 Aug 2013 09:08:57 -0400
In-Reply-To: <1375996022-8298-4-git-send-email-linux@rasmusvillemoes.dk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Arnd Bergmann <arnd@arndb.de>, Roland McGrath <roland@redhat.com>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On 08/08/13 22:07, Rasmus Villemoes wrote:
> Add include guards to include/asm-generic/{ide_iops,unistd,xor}.h.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  include/asm-generic/ide_iops.h |    4 ++++
>  include/asm-generic/unistd.h   |    5 +++++
>  include/asm-generic/xor.h      |    4 ++++
>  3 files changed, 13 insertions(+)
> 
> diff --git a/include/asm-generic/unistd.h b/include/asm-generic/unistd.h
> index cccc86e..0cff2e9 100644
> --- a/include/asm-generic/unistd.h
> +++ b/include/asm-generic/unistd.h
> @@ -1,3 +1,6 @@
> +#ifndef _ASM_GENERIC_UNISTD_H
> +#define _ASM_GENERIC_UNISTD_H
> +
>  #include <uapi/asm-generic/unistd.h>
>  #include <linux/export.h>
>  
> @@ -10,3 +13,5 @@
>  #define __ARCH_WANT_STAT64
>  #define __ARCH_WANT_SYS_LLSEEK
>  #endif
> +
> +#endif /* _ASM_GENERIC_UNISTD_H */

I think the lack of include guards in unistd.h is intentional. See for
example the very end of arch/metag/kernel/sys_metag.c.

Cheers
James
