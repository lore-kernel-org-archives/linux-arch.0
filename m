From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH 8/9] KEYS: Extend TIF_NOTIFY_RESUME to (almost) all
	architectures [try #6]
Date: Wed, 2 Sep 2009 09:19:40 +0100
Message-ID: <20090902081939.GB29221@flint.arm.linux.org.uk>
References: <20090902081340.4245.33186.stgit@warthog.procyon.org.uk> <20090902081416.4245.97801.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-security-module-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090902081416.4245.97801.stgit@warthog.procyon.org.uk>
Sender: linux-security-module-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: jmorris@namei.org, linux-security-module@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, Sep 02, 2009 at 09:14:16AM +0100, David Howells wrote:
> diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
> index 73394e5..d3a39b1 100644
> --- a/arch/arm/include/asm/thread_info.h
> +++ b/arch/arm/include/asm/thread_info.h
> @@ -130,11 +130,13 @@ extern void vfp_sync_state(struct thread_info *thread);
>   *  TIF_SYSCALL_TRACE	- syscall trace active
>   *  TIF_SIGPENDING	- signal pending
>   *  TIF_NEED_RESCHED	- rescheduling necessary
> + *  TIF_NOTIFY_RESUME	- callback before returning to user
>   *  TIF_USEDFPU		- FPU was used by this task this quantum (SMP)
>   *  TIF_POLLING_NRFLAG	- true if poll_idle() is polling TIF_NEED_RESCHED
>   */
>  #define TIF_SIGPENDING		0
>  #define TIF_NEED_RESCHED	1
> +#define TIF_NOTIFY_RESUME	2	/* callback before returning to user */
>  #define TIF_SYSCALL_TRACE	8
>  #define TIF_POLLING_NRFLAG	16
>  #define TIF_USING_IWMMXT	17
> @@ -143,6 +145,7 @@ extern void vfp_sync_state(struct thread_info *thread);
>  
>  #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
>  #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
> +#define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
>  #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
>  #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
>  #define _TIF_USING_IWMMXT	(1 << TIF_USING_IWMMXT)
> diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
> index 8c3de1a..7813ab7 100644
> --- a/arch/arm/kernel/entry-common.S
> +++ b/arch/arm/kernel/entry-common.S
> @@ -51,7 +51,7 @@ fast_work_pending:
>  work_pending:
>  	tst	r1, #_TIF_NEED_RESCHED
>  	bne	work_resched
> -	tst	r1, #_TIF_SIGPENDING
> +	tst	r1, #_TIF_SIGPENDING|_TIF_NOTIFY_RESUME
>  	beq	no_work_pending
>  	mov	r0, sp				@ 'regs'
>  	mov	r2, why				@ 'syscall'
> diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
> index f6bc5d4..13dec27 100644
> --- a/arch/arm/kernel/signal.c
> +++ b/arch/arm/kernel/signal.c
> @@ -707,4 +707,9 @@ do_notify_resume(struct pt_regs *regs, unsigned int thread_flags, int syscall)
>  {
>  	if (thread_flags & _TIF_SIGPENDING)
>  		do_signal(&current->blocked, regs, syscall);
> +
> +	if (thread_flags & _TIF_NOTIFY_RESUME) {
> +		clear_thread_flag(TIF_NOTIFY_RESUME);
> +		tracehook_notify_resume(regs);
> +	}
>  }

Thanks, that's much better.

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
