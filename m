From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/6] syscalls: use uaccess_kernel in addr_limit_user_check
Date: Mon, 20 Jul 2020 22:15:37 -0700
Message-ID: <eb470677-b569-a6f0-e63b-60149b54863a@roeck-us.net>
References: <20200714105505.935079-1-hch@lst.de>
 <20200714105505.935079-2-hch@lst.de> <20200718013849.GA157764@roeck-us.net>
 <20200718094846.GA8593@lst.de> <20200720221046.GA86726@roeck-us.net>
 <20200721045834.GA9613@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgGUFPk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 01:15:40 -0400
In-Reply-To: <20200721045834.GA9613@lst.de>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On 7/20/20 9:58 PM, Christoph Hellwig wrote:
> On Mon, Jul 20, 2020 at 03:10:46PM -0700, Guenter Roeck wrote:
>> I had another look into the code. Right after this patch, I see
>>
>> #define uaccess_kernel() segment_eq(get_fs(), KERNEL_DS)
>>
>> Yet, this patch is:
>>
>> -       if (CHECK_DATA_CORRUPTION(!segment_eq(get_fs(), USER_DS),
>> +       if (CHECK_DATA_CORRUPTION(uaccess_kernel(),
>>
>> So there is a negation in the condition. Indeed, the following change
>> on top of next-20200720 fixes the problem for mps2-an385.
>>
>> -       if (CHECK_DATA_CORRUPTION(uaccess_kernel(),
>> +       if (CHECK_DATA_CORRUPTION(!uaccess_kernel(),
>>
>> How does this work anywhere ?
> 
> No, that is the wrong check - we want to make sure the address
> space override doesn't leak to userspace.  The problem is that
> armnommu (and m68knommu, but that doesn't call the offending
> function) pretends to not have a kernel address space, which doesn't
> really work.  Here is the fix I sent out yesterday, which I should
> have Cc'ed you on, sorry:
> 

The patch below makes sense, and it does work, but I still suspect
that something with your original patch is wrong, or at least suspicious.
Reason: My change above (Adding the "!") works for _all_ of my arm boot
tests. Or, in other words, it doesn't make a difference if true
or false is passed as first parameter of CHECK_DATA_CORRUPTION(), except
for nommu systems. Also, unless I am really missing something, your
original patch _does_ reverse the logic.

I didn't track this down further.

Thanks,
Guenter

> ---
>>From 2bb889b2d99a2d978e90640ade8fe02359287092 Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Mon, 20 Jul 2020 17:46:50 +0200
> Subject: arm: don't call addr_limit_user_check for nommu
> 
> On arm nommu kernel use the same constant for USER_DS and KERNEL_DS,
> and seqment_eq always returns false.  With the current check in
> addr_limit_user_check that works by accident, but when replacing
> seqment_eq with uaccess_kerne it will fail.  Just remove the not
> needed check entirely.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reported-by: Guenter Roeck <linux@roeck-us.net>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  arch/arm/kernel/signal.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
> index ab2568996ddb0c..c9dc912b83f012 100644
> --- a/arch/arm/kernel/signal.c
> +++ b/arch/arm/kernel/signal.c
> @@ -713,7 +713,9 @@ struct page *get_signal_page(void)
>  /* Defer to generic check */
>  asmlinkage void addr_limit_check_failed(void)
>  {
> +#ifdef CONFIG_MMU
>  	addr_limit_user_check();
> +#endif
>  }
>  
>  #ifdef CONFIG_DEBUG_RSEQ
> 
