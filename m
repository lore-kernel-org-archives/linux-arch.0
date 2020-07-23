From: Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH 2/5] powerpc: Allow 4096 bytes of stack expansion for the signal frame
Date: Thu, 23 Jul 2020 23:35:36 +1000
Message-ID: <87blk6tkuv.fsf@dja-thinkpad.axtens.net>
References: <20200703141327.1732550-1-mpe@ellerman.id.au> <20200703141327.1732550-2-mpe@ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgGWNfk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jul 2020 09:35:40 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4080C0619DC
        for <linux-arch@vger.kernel.org>; Thu, 23 Jul 2020 06:35:40 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id t6so3128299pgq.1
        for <linux-arch@vger.kernel.org>; Thu, 23 Jul 2020 06:35:40 -0700 (PDT)
In-Reply-To: <20200703141327.1732550-2-mpe@ellerman.id.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, hughd@google.com

Hi Michael,

Unfortunately, this patch doesn't completely solve the problem.

Trying the original reproducer, I'm still able to trigger the crash even
with this patch, although not 100% of the time. (If I turn ASLR off
outside of tmux it reliably crashes, if I turn ASLR off _inside_ of tmux
it reliably succeeds; all of this is on a serial console.)

./foo 1241000 & sleep 1; killall -USR1 foo; echo ok

If I add some debugging information, I see that I'm getting
address + 4096 = 7fffffed0fa0
gpr1 =           7fffffed1020

So address + 4096 is 0x80 bytes below the 4k window. I haven't been able
to figure out why, gdb gives me a NIP in __kernel_sigtramp_rt64 but I
don't know what to make of that.

Kind regards,
Daniel

P.S. I don't know what your policy on linking to kernel bugzilla is, but
if you want:

Link: https://bugzilla.kernel.org/show_bug.cgi?id=205183


> Reported-by: Tom Lane <tgl@sss.pgh.pa.us>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/mm/fault.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index 641fc5f3d7dd..ed01329dd12b 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -274,7 +274,7 @@ static bool bad_stack_expansion(struct pt_regs *regs, unsigned long address,
>  	/*
>  	 * N.B. The POWER/Open ABI allows programs to access up to
>  	 * 288 bytes below the stack pointer.
> -	 * The kernel signal delivery code writes up to about 1.5kB
> +	 * The kernel signal delivery code writes up to 4KB
>  	 * below the stack pointer (r1) before decrementing it.
>  	 * The exec code can write slightly over 640kB to the stack
>  	 * before setting the user r1.  Thus we allow the stack to
> @@ -299,7 +299,7 @@ static bool bad_stack_expansion(struct pt_regs *regs, unsigned long address,
>  		 * between the last mapped region and the stack will
>  		 * expand the stack rather than segfaulting.
>  		 */
> -		if (address + 2048 >= uregs->gpr[1])
> +		if (address + 4096 >= uregs->gpr[1])
>  			return false;
>  
>  		if ((flags & FAULT_FLAG_WRITE) && (flags & FAULT_FLAG_USER) &&
> -- 
> 2.25.1
