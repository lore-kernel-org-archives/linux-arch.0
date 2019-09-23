Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6820 "EHLO
 mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
 with ESMTP id S1726086AbfIWJGK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
 Mon, 23 Sep 2019 05:06:10 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1]) by
 mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8N94jPU145844
 for <linux-arch@vger.kernel.org>; Mon, 23 Sep 2019 05:06:08 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103]) by
 mx0b-001b2d01.pphosted.com with ESMTP id 2v6rh6wfhg-1 (version=TLSv1.2
 cipher=AES256-GCM-SHA384 bits=256 verify=NOT) for
 <linux-arch@vger.kernel.org>; Mon, 23 Sep 2019 05:06:08 -0400
Received: from localhost by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted for
 <linux-arch@vger.kernel.org> from <rppt@linux.ibm.com>; Mon, 23 Sep 2019
 10:06:06 +0100
Date: Mon, 23 Sep 2019 12:05:58 +0300
From: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [RFC patch 01/15] entry: Provide generic syscall entry
 functionality
References: <20190919150314.054351477@linutronix.de>
 <20190919150808.521907403@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919150808.521907403@linutronix.de>
Message-ID: <20190923090557.GA8357@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20190923090558.3j5V7JPJsoSdMZvXtxiQwvj_MlDkiEnB7IZq5BeAbzo@z>

On Thu, Sep 19, 2019 at 05:03:15PM +0200, Thomas Gleixner wrote:
> On syscall entry certain work needs to be done conditionally like tracing,
> seccomp etc. This code is duplicated in all architectures.
> 
> Provide a generic version.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/Kconfig                 |    3 +
>  include/linux/entry-common.h |  122 +++++++++++++++++++++++++++++++++++++++++++
>  kernel/Makefile              |    1 
>  kernel/entry/Makefile        |    3 +
>  kernel/entry/common.c        |   33 +++++++++++
>  5 files changed, 162 insertions(+)
> 
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -27,6 +27,9 @@ config HAVE_IMA_KEXEC
>  config HOTPLUG_SMT
>  	bool
> 
> +config GENERIC_ENTRY
> +       bool
> +
>  config OPROFILE
>  	tristate "OProfile system profiling"
>  	depends on PROFILING
> --- /dev/null
> +++ b/include/linux/entry-common.h
> @@ -0,0 +1,122 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __LINUX_ENTRYCOMMON_H
> +#define __LINUX_ENTRYCOMMON_H
> +
> +#include <linux/tracehook.h>
> +#include <linux/syscalls.h>
> +#include <linux/seccomp.h>
> +#include <linux/sched.h>
> +#include <linux/audit.h>
> +
> +#include <asm/entry-common.h>
> +
> +/*
> + * Define dummy _TIF work flags if not defined by the architecture or for
> + * disabled functionality.
> + */
> +#ifndef _TIF_SYSCALL_TRACE
> +# define _TIF_SYSCALL_TRACE		(0)
> +#endif
> +
> +#ifndef _TIF_SYSCALL_EMU
> +# define _TIF_SYSCALL_EMU		(0)
> +#endif
> +
> +#ifndef _TIF_SYSCALL_TRACEPOINT
> +# define _TIF_SYSCALL_TRACEPOINT	(0)
> +#endif
> +
> +#ifndef _TIF_SECCOMP
> +# define _TIF_SECCOMP			(0)
> +#endif
> +
> +#ifndef _TIF_AUDIT
> +# define _TIF_AUDIT			(0)
> +#endif
> +
> +/*
> + * TIF flags handled in syscall_enter_from_usermode()
> + */
> +#ifndef ARCH_SYSCALL_ENTER_WORK
> +# define ARCH_SYSCALL_ENTER_WORK	(0)
> +#endif
> +
> +#define SYSCALL_ENTER_WORK						\
> +	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | TIF_SECCOMP |	\
> +	 _TIF_SYSCALL_TRACEPOINT | _TIF_SYSCALL_EMU |			\
> +	 ARCH_SYSCALL_ENTER_WORK)
> +
> +/**
> + * arch_syscall_enter_tracehook - Wrapper around tracehook_report_syscall_entry()
> + *
> + * Defaults to tracehook_report_syscall_entry(). Can be replaced by
> + * architecture specific code.
> + *
> + * Invoked from syscall_enter_from_usermode()
> + */

Nit: the kernel-doc here and in other places in the patchset lacks
parameter and return value descriptions, which will create lots of warnings
for 'make *docs'.

> +static inline __must_check int arch_syscall_enter_tracehook(struct pt_regs *regs);
> +
> +#ifndef arch_syscall_enter_tracehook
> +static inline __must_check int arch_syscall_enter_tracehook(struct pt_regs *regs)
> +{
> +	return tracehook_report_syscall_entry(regs);
> +}
> +#endif
> +
> +/**
> + * arch_syscall_enter_seccomp - Architecture specific seccomp invocation
> + * @regs:	Pointer to currents pt_regs
> + *
> + * Invoked from syscall_enter_from_usermode(). Can be replaced by
> + * architecture specific code.
> + */
> +static inline long arch_syscall_enter_seccomp(struct pt_regs *regs);
> +
> +#ifndef arch_syscall_enter_seccomp
> +static inline long arch_syscall_enter_seccomp(struct pt_regs *regs)
> +{
> +	return secure_computing(NULL);
> +}
> +#endif
> +
> +/**
> + * arch_syscall_enter_audit - Architecture specific audit invocation
> + * @regs:	Pointer to currents pt_regs
> + *
> + * Invoked from syscall_enter_from_usermode(). Must be replaced by
> + * architecture specific code if the architecture supports audit.
> + */
> +static inline void arch_syscall_enter_audit(struct pt_regs *regs);
> +
> +#ifndef arch_syscall_enter_audit
> +static inline void arch_syscall_enter_audit(struct pt_regs *regs) { }
> +#endif
> +
> +/* Common syscall enter function */
> +long core_syscall_enter_from_usermode(struct pt_regs *regs, long syscall);
> +
> +/**
> + * syscall_enter_from_usermode - Check and handle work before invoking
> + *				 a syscall
> + * @regs:	Pointer to currents pt_regs
> + * @syscall:	The syscall number
> + *
> + * Invoked from architecture specific syscall entry code with interrupts
> + * enabled.
> + *
> + * Returns: The original or a modified syscall number
> + */
> +static inline long syscall_enter_from_usermode(struct pt_regs *regs,
> +					       long syscall)
> +{
> +	unsigned long ti_work = READ_ONCE(current_thread_info()->flags);
> +
> +	if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
> +		BUG_ON(regs != task_pt_regs(current));
> +
> +	if (ti_work & SYSCALL_ENTER_WORK)
> +		syscall = core_syscall_enter_from_usermode(regs, syscall);
> +	return syscall;
> +}
> +
> +#endif
> --- a/kernel/Makefile
> +++ b/kernel/Makefile
> @@ -43,6 +43,7 @@ obj-y += irq/
>  obj-y += rcu/
>  obj-y += livepatch/
>  obj-y += dma/
> +obj-y += entry/
> 
>  obj-$(CONFIG_CHECKPOINT_RESTORE) += kcmp.o
>  obj-$(CONFIG_FREEZER) += freezer.o
> --- /dev/null
> +++ b/kernel/entry/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_GENERIC_ENTRY) += common.o
> --- /dev/null
> +++ b/kernel/entry/common.c
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/context_tracking.h>
> +#include <linux/entry-common.h>
> +
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/syscalls.h>
> +
> +long core_syscall_enter_from_usermode(struct pt_regs *regs, long syscall)
> +{
> +	unsigned long ti_work = READ_ONCE(current_thread_info()->flags);
> +	unsigned long ret = 0;
> +
> +	if (ti_work & (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_EMU)) {
> +		ret = arch_syscall_enter_tracehook(regs);
> +		if (ret || (ti_work & _TIF_SYSCALL_EMU))
> +			return -1L;
> +	}
> +
> +	/* Do seccomp after ptrace, to catch any tracer changes. */
> +	if (ti_work & _TIF_SECCOMP) {
> +		ret = arch_syscall_enter_seccomp(regs);
> +		if (ret == -1L)
> +			return ret;
> +	}
> +
> +	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
> +		trace_sys_enter(regs, syscall);
> +
> +	arch_syscall_enter_audit(regs);
> +
> +	return ret ? : syscall;
> +}
> 
> 

-- 
Sincerely yours,
Mike.
