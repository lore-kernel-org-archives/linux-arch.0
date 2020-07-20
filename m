From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/6] syscalls: use uaccess_kernel in addr_limit_user_check
Date: Mon, 20 Jul 2020 15:10:46 -0700
Message-ID: <20200720221046.GA86726@roeck-us.net>
References: <20200714105505.935079-1-hch@lst.de>
 <20200714105505.935079-2-hch@lst.de>
 <20200718013849.GA157764@roeck-us.net>
 <20200718094846.GA8593@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgGTWKt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jul 2020 18:10:49 -0400
Content-Disposition: inline
In-Reply-To: <20200718094846.GA8593@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Jul 18, 2020 at 11:48:46AM +0200, Christoph Hellwig wrote:
> On Fri, Jul 17, 2020 at 06:38:50PM -0700, Guenter Roeck wrote:
> > Hi,
> > 
> > On Tue, Jul 14, 2020 at 12:55:00PM +0200, Christoph Hellwig wrote:
> > > Use the uaccess_kernel helper instead of duplicating it.
> > > 
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > 
> > This patch causes a severe hiccup with my mps2-an385 boot test.
> 

I had another look into the code. Right after this patch, I see

#define uaccess_kernel() segment_eq(get_fs(), KERNEL_DS)

Yet, this patch is:

-       if (CHECK_DATA_CORRUPTION(!segment_eq(get_fs(), USER_DS),
+       if (CHECK_DATA_CORRUPTION(uaccess_kernel(),

So there is a negation in the condition. Indeed, the following change
on top of next-20200720 fixes the problem for mps2-an385.

-       if (CHECK_DATA_CORRUPTION(uaccess_kernel(),
+       if (CHECK_DATA_CORRUPTION(!uaccess_kernel(),

How does this work anywhere ?

Thanks,
Guenter

> I guess that is a nommu config?
> 
> Can you try this patch?
> 
> diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
> index b19c9bec1f7a63..cc7daf374a6eb6 100644
> --- a/arch/arm/include/asm/uaccess.h
> +++ b/arch/arm/include/asm/uaccess.h
> @@ -263,7 +263,7 @@ extern int __put_user_8(void *, unsigned long long);
>   */
>  #define USER_DS			KERNEL_DS
>  
> -#define uaccess_kernel()	(true)
> +#define uaccess_kernel()	(false)
>  #define __addr_ok(addr)		((void)(addr), 1)
>  #define __range_ok(addr, size)	((void)(addr), 0)
>  #define get_fs()		(KERNEL_DS)
