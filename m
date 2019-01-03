Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34575 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfACFp6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Jan 2019 00:45:58 -0500
Date: Wed, 2 Jan 2019 21:45:55 -0800
From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] RISC-V: Add _TIF_NEED_RESCHED check for kernel thread
 when CONFIG_PREEMPT=y
Message-ID: <20190103054555.GA30904@roeck-us.net>
References: <1546486353-23115-1-git-send-email-vincentc@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546486353-23115-1-git-send-email-vincentc@andestech.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincent Chen <vincentc@andestech.com>
Cc: palmer@sifive.com, aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org
Message-ID: <20190103054555.TkPt3EO8SKAVWI-5jDhVKDlZpNLv4Gbu96rdm2vxpRQ@z>

On Thu, Jan 03, 2019 at 11:32:33AM +0800, Vincent Chen wrote:
> The cond_resched() can be used to yield the CPU resource if
> CONFIG_PREEMPT is not defined. Otherwise, cond_resched() is a dummy
> function. In order to avoid kernel thread occupying entire CPU,
> when CONFIG_PREEMPT=y, the kernel thread needs to follow the
> rescheduling mechanism like a user thread.
> 
> Signed-off-by: Vincent Chen <vincentc@andestech.com>

This patch seems to do the trick. I no longer see a problem with
CONFIG_PREEMPT=y and the various lock torture tests enabled, as
previously reported.

Nice catch and fix.

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> ---
>  arch/riscv/kernel/asm-offsets.c |    1 +
>  arch/riscv/kernel/entry.S       |   18 +++++++++++++++++-
>  2 files changed, 18 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
> index 6a92a2f..dac9834 100644
> --- a/arch/riscv/kernel/asm-offsets.c
> +++ b/arch/riscv/kernel/asm-offsets.c
> @@ -39,6 +39,7 @@ void asm_offsets(void)
>  	OFFSET(TASK_STACK, task_struct, stack);
>  	OFFSET(TASK_TI, task_struct, thread_info);
>  	OFFSET(TASK_TI_FLAGS, task_struct, thread_info.flags);
> +	OFFSET(TASK_TI_PREEMPT_COUNT, task_struct, thread_info.preempt_count);
>  	OFFSET(TASK_TI_KERNEL_SP, task_struct, thread_info.kernel_sp);
>  	OFFSET(TASK_TI_USER_SP, task_struct, thread_info.user_sp);
>  	OFFSET(TASK_TI_CPU, task_struct, thread_info.cpu);
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 13d4826..728b72d 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -144,6 +144,10 @@ _save_context:
>  	REG_L x2,  PT_SP(sp)
>  	.endm
>  
> +#if !IS_ENABLED(CONFIG_PREEMPT)
> +#define resume_kernel restore_all
> +#endif
> +
>  ENTRY(handle_exception)
>  	SAVE_ALL
>  
> @@ -228,7 +232,7 @@ ret_from_exception:
>  	REG_L s0, PT_SSTATUS(sp)
>  	csrc sstatus, SR_SIE
>  	andi s0, s0, SR_SPP
> -	bnez s0, restore_all
> +	bnez s0, resume_kernel
>  
>  resume_userspace:
>  	/* Interrupts must be disabled here so flags are checked atomically */
> @@ -250,6 +254,18 @@ restore_all:
>  	RESTORE_ALL
>  	sret
>  
> +#if IS_ENABLED(CONFIG_PREEMPT)
> +resume_kernel:
> +	REG_L s0, TASK_TI_PREEMPT_COUNT(tp)
> +	bnez s0, restore_all
> +need_resched:
> +	REG_L s0, TASK_TI_FLAGS(tp)
> +	andi s0, s0, _TIF_NEED_RESCHED
> +	beqz s0, restore_all
> +	call preempt_schedule_irq
> +	j need_resched
> +#endif
> +
>  work_pending:
>  	/* Enter slow path for supplementary processing */
>  	la ra, ret_from_exception
