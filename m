From: Andrea Righi <righi.andrea@gmail.com>
Subject: Re: + page_align-correctly-handle-64-bit-values-on-32-bit-architectures-x86_64-fix.patch
 added to -mm tree
Date: Tue, 01 Jul 2008 20:22:38 +0200
Message-ID: <486A75EE.1060606@gmail.com>
References: <200806302233.m5UMXpAn029071@imap1.linux-foundation.org>
Reply-To: righi.andrea@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:21568 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976AbYGASWn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 1 Jul 2008 14:22:43 -0400
Received: by fg-out-1718.google.com with SMTP id 19so3519fgg.17
        for <linux-arch@vger.kernel.org>; Tue, 01 Jul 2008 11:22:41 -0700 (PDT)
In-Reply-To: <200806302233.m5UMXpAn029071@imap1.linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: mm-commits@vger.kernel.org, linux-arch@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Balbir Singh <balbir@linux.vnet.ibm.com>

akpm@linux-foundation.org wrote:
> ------------------------------------------------------
> Subject: page_align-correctly-handle-64-bit-values-on-32-bit-architectures x86_64 fix
> From: Andrea Righi <righi.andrea@gmail.com>
> 
> x86_64 allmodconfig build failed due to a missing #include <linux/mm.h>
> in arch/x86/kernel/module_64.c.

There are probably other missing includes like this for other
architectures, due to the move of PAGE_ALIGN() from asm-*/page.h to
linux/mm.h. I tested allmodconfig and some randconfig only with x86_64
and i386.

I've found other (probably) missing includes doing some simple greps,
see patch v2:

http://lkml.org/lkml/2008/6/15/85

Otherwise, a less intrusive approach could be to just fix the bug and
don't move PAGE_ALIGN() out of asm-*/page.h, see v3:

http://lkml.org/lkml/2008/6/19/217

Let me know if you need a patch (v2 or v3) on-top-of the previous one.

-Andrea

> 
> Following patch resolves (on top of the previous one).
> 
> Except this, no errors for x86_64.
> 
> Signed-off-by: Andrea Righi <righi.andrea@gmail.com>
> Cc: <linux-arch@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  arch/x86/kernel/module_64.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff -puN arch/x86/kernel/module_64.c~page_align-correctly-handle-64-bit-values-on-32-bit-architectures-x86_64-fix arch/x86/kernel/module_64.c
> --- a/arch/x86/kernel/module_64.c~page_align-correctly-handle-64-bit-values-on-32-bit-architectures-x86_64-fix
> +++ a/arch/x86/kernel/module_64.c
> @@ -22,6 +22,7 @@
>  #include <linux/fs.h>
>  #include <linux/string.h>
>  #include <linux/kernel.h>
> +#include <linux/mm.h>
>  #include <linux/slab.h>
>  #include <linux/bug.h>
>  
