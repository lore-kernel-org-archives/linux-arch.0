From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH 5/9] RISC-V: Task implementation
Date: Thu, 29 Jun 2017 10:22:23 +0200
Message-ID: <20170629082222.GA5851@distanz.ch>
References: <20170606230007.19101-1-palmer@dabbelt.com>
 <20170628185538.1804-1-palmer@dabbelt.com>
 <20170628185538.1804-6-palmer@dabbelt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from sym2.noone.org ([178.63.92.236]:37328 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752463AbdF2IW1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 29 Jun 2017 04:22:27 -0400
Content-Disposition: inline
In-Reply-To: <20170628185538.1804-6-palmer@dabbelt.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: peterz@infradead.org, mingo@redhat.com, mcgrof@kernel.org, viro@zeniv.linux.org.uk, sfr@canb.auug.org.au, nicolas.dichtel@6wind.com, rmk+kernel@armlinux.org.uk, msalter@redhat.com, will.deacon@arm.com, james.hogan@imgtec.com, paul.gortmaker@windriver.com, linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, albert@sifive.com

On 2017-06-28 at 20:55:34 +0200, Palmer Dabbelt <palmer@dabbelt.com> wrote:
[...]
> diff --git a/arch/riscv/include/asm/kprobes.h b/arch/riscv/include/asm/kprobes.h
> new file mode 100644
> index 000000000000..1190de7a0f74
> --- /dev/null
> +++ b/arch/riscv/include/asm/kprobes.h
> @@ -0,0 +1,22 @@
> +/*
> + * Copyright (C) 2017 SiFive
> + *
> + *   This program is free software; you can redistribute it and/or
> + *   modify it under the terms of the GNU General Public License
> + *   as published by the Free Software Foundation, version 2.
> + *
> + *   This program is distributed in the hope that it will be useful,
> + *   but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *   GNU General Public License for more details.
> + */
> +
> +
> +#ifndef ASM_RISCV_KPROBES_H
> +#define ASM_RISCV_KPROBES_H
> +
> +#ifdef CONFIG_KPROBES
> +#error "RISC-V doesn't skpport CONFIG_KPROBES"

Typo: s/skpport/support/

> +#endif
> +
> +#endif
> diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
> new file mode 100644
> index 000000000000..65aa014db9b4
> --- /dev/null
> +++ b/arch/riscv/include/asm/processor.h
> @@ -0,0 +1,102 @@
> +/*
> + * Copyright (C) 2012 Regents of the University of California
> + *
> + *   This program is free software; you can redistribute it and/or
> + *   modify it under the terms of the GNU General Public License
> + *   as published by the Free Software Foundation, version 2.
> + *
> + *   This program is distributed in the hope that it will be useful,
> + *   but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *   GNU General Public License for more details.
> + */
> +
> +#ifndef _ASM_RISCV_PROCESSOR_H
> +#define _ASM_RISCV_PROCESSOR_H
> +
> +#include <linux/const.h>
> +
> +#include <asm/ptrace.h>
> +
> +/*
> + * This decides where the kernel will search for a free chunk of vm
> + * space during mmap's.
> + */
> +#define TASK_UNMAPPED_BASE	PAGE_ALIGN(TASK_SIZE >> 1)
> +
> +#ifdef __KERNEL__
> +#define STACK_TOP		TASK_SIZE
> +#define STACK_TOP_MAX		STACK_TOP
> +#define STACK_ALIGN		16
> +#endif /* __KERNEL__ */
> +
> +#ifndef __ASSEMBLY__
> +
> +struct task_struct;
> +struct pt_regs;
> +
> +/*
> + * Default implementation of macro that returns current
> + * instruction pointer ("program counter").
> + */
> +#define current_text_addr()	({ __label__ _l; _l: &&_l; })
> +
> +/* CPU-specific state of a task */
> +struct thread_struct {
> +	/* Callee-saved registers */
> +	unsigned long ra;
> +	unsigned long sp;	/* Kernel mode stack */
> +	unsigned long s[12];	/* s[0]: frame pointer */
> +	struct __riscv_d_ext_state fstate;
> +};
> +
> +#define INIT_THREAD {					\
> +	.sp = sizeof(init_stack) + (long)&init_stack,	\
> +}
> +
> +/* Return saved (kernel) PC of a blocked thread. */
> +#define thread_saved_pc(t)	((t)->thread.ra)
> +#define thread_saved_sp(t)	((t)->thread.sp)
> +#define thread_saved_fp(t)	((t)->thread.s[0])

These aren't needed outside of arch-specific code (anymore) and the
riscv port doesn't seem to be using them, so they can be omitted.
