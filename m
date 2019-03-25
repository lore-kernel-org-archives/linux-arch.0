Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726166AbfCYOjf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 25 Mar 2019 10:39:35 -0400
Date: Mon, 25 Mar 2019 22:39:26 +0800
From: Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH] csky: Update syscall_trace_enter/exit implementation
Message-ID: <20190325143926.GA25867@guoren-Inspiron-7460>
References: <1553515419-1797-1-git-send-email-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553515419-1797-1-git-send-email-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de, ldv@altlinux.org
Cc: linux-arch@vger.kernel.org, strace-devel@lists.strace.io, linux-kernel@vger.kernel.org, ren_guo@c-sky.com
Message-ID: <20190325143926.G325R9MQ5D0eWe9mPPCVgHP5Pcu6I20SMB3c_7ooTY0@z>

On Mon, Mar 25, 2019 at 08:03:39PM +0800, guoren@kernel.org wrote:
> From: Guo Ren <ren_guo@c-sky.com>
> 
> Previous syscall_trace implementation couldn't support AUDITSYSCALL and
> SYSCALL_TRACEPOINTS. Now we redesign it to support audit_syscall
> and syscall_tracepoints just like other archs'.
> 
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Cc: Dmitry V. Levin <ldv@altlinux.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/csky/Kconfig                   |  2 ++
>  arch/csky/include/asm/syscall.h     |  2 ++
>  arch/csky/include/asm/thread_info.h | 25 ++++++++-----------
>  arch/csky/include/asm/unistd.h      |  2 ++
>  arch/csky/include/uapi/asm/ptrace.h |  5 ++++
>  arch/csky/kernel/entry.S            | 21 +++++++---------
...
> diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
> index 5137ed9..ebd1957 100644
> --- a/arch/csky/kernel/entry.S
> +++ b/arch/csky/kernel/entry.S
> @@ -136,8 +136,8 @@ ENTRY(csky_systemcall)
>  	bmaski  r10, THREAD_SHIFT
>  	andn    r9, r10
>  	ldw     r8, (r9, TINFO_FLAGS)
> -	btsti   r8, TIF_SYSCALL_TRACE
> -	bt      1f
> +	andi	r8, (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_TRACEPOINT | _TIF_SYSCALL_AUDIT)
> +	bt      csky_syscall_trace
>  #if defined(__CSKYABIV2__)
>  	subi    sp, 8
>  	stw  	r5, (sp, 0x4)
> @@ -150,10 +150,9 @@ ENTRY(csky_systemcall)
>  	stw     a0, (sp, LSAVE_A0)      /* Save return value */
>  	jmpi    ret_from_exception
>  
> -1:
> -	movi	a0, 0                   /* enter system call */
> -	mov	a1, sp                  /* sp = pt_regs pointer */
> -	jbsr	syscall_trace
> +csky_syscall_trace:
> +	mov	a0, sp                  /* sp = pt_regs pointer */
> +	jbsr	syscall_trace_enter
>  	/* Prepare args before do system call */
>  	ldw	a0, (sp, LSAVE_A0)
>  	ldw	a1, (sp, LSAVE_A1)
> @@ -173,9 +172,8 @@ ENTRY(csky_systemcall)
>  #endif
>  	stw	a0, (sp, LSAVE_A0)	/* Save return value */
>  
> -	movi    a0, 1                   /* leave system call */
> -	mov     a1, sp                  /* right now, sp --> pt_regs */
> -	jbsr    syscall_trace
> +	mov     a0, sp                  /* right now, sp --> pt_regs */
> +	jbsr    syscall_trace_exit
>  	br	ret_from_exception
>  
>  ENTRY(ret_from_kernel_thread)
> @@ -193,9 +191,8 @@ ENTRY(ret_from_fork)
>  	movi	r11_sig, 1
>  	btsti	r8, TIF_SYSCALL_TRACE
It's wrong, I should use: 
+	andi	r8, (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_TRACEPOINT | _TIF_SYSCALL_AUDIT)

Best Regards
 Guo Ren
