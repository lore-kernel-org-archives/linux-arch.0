Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp07.uk.ibm.com ([195.75.94.103]:56645 "EHLO
	e06smtp07.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965759AbcAZSTO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 26 Jan 2016 13:19:14 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
	Tue, 26 Jan 2016 18:19:13 -0000
Date: Tue, 26 Jan 2016 19:19:03 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH/RFC 3/3] s390: query dynamic DEBUG_PAGEALLOC setting
Message-ID: <20160126181903.GB4671@osiris>
References: <1453799905-10941-1-git-send-email-borntraeger@de.ibm.com>
 <1453799905-10941-4-git-send-email-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1453799905-10941-4-git-send-email-borntraeger@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org
Message-ID: <20160126181903.POvrUjkdBX-zMLh6Hf35wac1qzQACwbf15s2SXURnf8@z>

On Tue, Jan 26, 2016 at 10:18:25AM +0100, Christian Borntraeger wrote:
> We can use debug_pagealloc_enabled() to check if we can map
> the identity mapping with 1MB/2GB pages as well as to print
> the current setting in dump_stack.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kernel/dumpstack.c |  4 +++-
>  arch/s390/mm/vmem.c          | 10 ++++------
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/s390/kernel/dumpstack.c b/arch/s390/kernel/dumpstack.c
> index dc8e204..a1c0530 100644
> --- a/arch/s390/kernel/dumpstack.c
> +++ b/arch/s390/kernel/dumpstack.c
> @@ -11,6 +11,7 @@
>  #include <linux/export.h>
>  #include <linux/kdebug.h>
>  #include <linux/ptrace.h>
> +#include <linux/mm.h>
>  #include <linux/module.h>
>  #include <linux/sched.h>
>  #include <asm/processor.h>
> @@ -186,7 +187,8 @@ void die(struct pt_regs *regs, const char *str)
>  	printk("SMP ");
>  #endif
>  #ifdef CONFIG_DEBUG_PAGEALLOC
> -	printk("DEBUG_PAGEALLOC");
> +	printk("DEBUG_PAGEALLOC(%s)",
> +		debug_pagealloc_enabled() ? "enabled" : "disabled");
>  #endif

I'd prefer if you change this to

	if (debug_pagealloc_enabled())
		printk("DEBUG_PAGEALLOC");

That way we can get rid of yet another ifdef. Having
"DEBUG_PAGEALLOC(disabled)" doesn't seem to be very helpful.

