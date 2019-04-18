Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33418 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388535AbfDRLw2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 18 Apr 2019 07:52:28 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3IBnk6V086033
        for <linux-arch@vger.kernel.org>; Thu, 18 Apr 2019 07:52:25 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rxrq30497-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 18 Apr 2019 07:52:25 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <rppt@linux.ibm.com>;
        Thu, 18 Apr 2019 12:52:22 +0100
Date: Thu, 18 Apr 2019 14:52:07 +0300
From: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [patch V2 28/29] stacktrace: Provide common infrastructure
References: <20190418084119.056416939@linutronix.de>
 <20190418084255.652003111@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190418084255.652003111@linutronix.de>
Message-ID: <20190418115207.GB13304@rapoport-lnx>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org, Andy Lutomirski <luto@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Alexander Potapenko <glider@google.com>, linux-arch@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org, David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>, Catalin Marinas <catalin.marinas@arm.com>, Dmitry Vyukov <dvyukov@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, kasan-dev@googlegroups.com, Mike Rapoport <rppt@linux.vnet.ibm.com>, Akinobu Mita <akinobu.mita@gmail.com>, iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Johannes Thumshirn <jthumshirn@suse.de>, David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org, dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>, Alasdair Kergon <agk@redhat.com>, intel-gfx@lists.freedesktop.org, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>, Jani Nikula <jani.nikula@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>, Rodrigo Vivi <rodrigo.vivi@intel.com>
Message-ID: <20190418115207.i1bEut7i7E5fEoTVv-mqEkWyvHsGoX2bqPqcTt94QrY@z>

On Thu, Apr 18, 2019 at 10:41:47AM +0200, Thomas Gleixner wrote:
> All architectures which support stacktrace carry duplicated code and
> do the stack storage and filtering at the architecture side.
> 
> Provide a consolidated interface with a callback function for consuming the
> stack entries provided by the architecture specific stack walker. This
> removes lots of duplicated code and allows to implement better filtering
> than 'skip number of entries' in the future without touching any
> architecture specific code.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-arch@vger.kernel.org
> ---
>  include/linux/stacktrace.h |   38 +++++++++
>  kernel/stacktrace.c        |  173 +++++++++++++++++++++++++++++++++++++++++++++
>  lib/Kconfig                |    4 +
>  3 files changed, 215 insertions(+)
> 
> --- a/include/linux/stacktrace.h
> +++ b/include/linux/stacktrace.h
> @@ -23,6 +23,43 @@ unsigned int stack_trace_save_regs(struc
>  unsigned int stack_trace_save_user(unsigned long *store, unsigned int size);
> 
>  /* Internal interfaces. Do not use in generic code */
> +#ifdef CONFIG_ARCH_STACKWALK
> +
> +/**
> + * stack_trace_consume_fn - Callback for arch_stack_walk()
> + * @cookie:	Caller supplied pointer handed back by arch_stack_walk()
> + * @addr:	The stack entry address to consume
> + * @reliable:	True when the stack entry is reliable. Required by
> + *		some printk based consumers.
> + *
> + * Returns:	True, if the entry was consumed or skipped
> + *		False, if there is no space left to store
> + */
> +typedef bool (*stack_trace_consume_fn)(void *cookie, unsigned long addr,
> +				       bool reliable);
> +/**
> + * arch_stack_walk - Architecture specific function to walk the stack
> +

Nit: no '*' at line beginning makes kernel-doc unhappy

> + * @consume_entry:	Callback which is invoked by the architecture code for
> + *			each entry.
> + * @cookie:		Caller supplied pointer which is handed back to
> + *			@consume_entry
> + * @task:		Pointer to a task struct, can be NULL
> + * @regs:		Pointer to registers, can be NULL
> + *
> + * @task	@regs:
> + * NULL		NULL	Stack trace from current
> + * task		NULL	Stack trace from task (can be current)
> + * NULL		regs	Stack trace starting on regs->stackpointer

This will render as a single line with 'make *docs'.
Adding line separators makes this actually a table in the generated docs:

 * ============ ======= ============================================
 * task		regs
 * ============ ======= ============================================
 * NULL		NULL	Stack trace from current
 * task		NULL	Stack trace from task (can be current)
 * NULL		regs	Stack trace starting on regs->stackpointer
 * ============ ======= ============================================


> + */
> +void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
> +		     struct task_struct *task, struct pt_regs *regs);
> +int arch_stack_walk_reliable(stack_trace_consume_fn consume_entry, void *cookie,
> +			     struct task_struct *task);
> +void arch_stack_walk_user(stack_trace_consume_fn consume_entry, void *cookie,
> +			  const struct pt_regs *regs);
> +
> +#else /* CONFIG_ARCH_STACKWALK */
>  struct stack_trace {
>  	unsigned int nr_entries, max_entries;
>  	unsigned long *entries;
> @@ -37,6 +74,7 @@ extern void save_stack_trace_tsk(struct
>  extern int save_stack_trace_tsk_reliable(struct task_struct *tsk,
>  					 struct stack_trace *trace);
>  extern void save_stack_trace_user(struct stack_trace *trace);
> +#endif /* !CONFIG_ARCH_STACKWALK */
>  #endif /* CONFIG_STACKTRACE */
> 
>  #if defined(CONFIG_STACKTRACE) && defined(CONFIG_HAVE_RELIABLE_STACKTRACE)
> --- a/kernel/stacktrace.c
> +++ b/kernel/stacktrace.c
> @@ -5,6 +5,8 @@
>   *
>   *  Copyright (C) 2006 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
>   */
> +#include <linux/sched/task_stack.h>
> +#include <linux/sched/debug.h>
>  #include <linux/sched.h>
>  #include <linux/kernel.h>
>  #include <linux/export.h>
> @@ -64,6 +66,175 @@ int stack_trace_snprint(char *buf, size_
>  }
>  EXPORT_SYMBOL_GPL(stack_trace_snprint);
> 
> +#ifdef CONFIG_ARCH_STACKWALK
> +
> +struct stacktrace_cookie {
> +	unsigned long	*store;
> +	unsigned int	size;
> +	unsigned int	skip;
> +	unsigned int	len;
> +};
> +
> +static bool stack_trace_consume_entry(void *cookie, unsigned long addr,
> +				      bool reliable)
> +{
> +	struct stacktrace_cookie *c = cookie;
> +
> +	if (c->len >= c->size)
> +		return false;
> +
> +	if (c->skip > 0) {
> +		c->skip--;
> +		return true;
> +	}
> +	c->store[c->len++] = addr;
> +	return c->len < c->size;
> +}
> +
> +static bool stack_trace_consume_entry_nosched(void *cookie, unsigned long addr,
> +					      bool reliable)
> +{
> +	if (in_sched_functions(addr))
> +		return true;
> +	return stack_trace_consume_entry(cookie, addr, reliable);
> +}
> +
> +/**
> + * stack_trace_save - Save a stack trace into a storage array
> + * @store:	Pointer to storage array
> + * @size:	Size of the storage array
> + * @skipnr:	Number of entries to skip at the start of the stack trace
> + *
> + * Returns number of entries stored.

Can you please s/Returns/Return:/ so that kernel-doc will recognize this as
return section.

This is relevant for other comments below as well.

> + */
> +unsigned int stack_trace_save(unsigned long *store, unsigned int size,
> +			      unsigned int skipnr)
> +{
> +	stack_trace_consume_fn consume_entry = stack_trace_consume_entry;
> +	struct stacktrace_cookie c = {
> +		.store	= store,
> +		.size	= size,
> +		.skip	= skipnr + 1,
> +	};
> +
> +	arch_stack_walk(consume_entry, &c, current, NULL);
> +	return c.len;
> +}
> +EXPORT_SYMBOL_GPL(stack_trace_save);
> +
> +/**
> + * stack_trace_save_tsk - Save a task stack trace into a storage array
> + * @task:	The task to examine
> + * @store:	Pointer to storage array
> + * @size:	Size of the storage array
> + * @skipnr:	Number of entries to skip at the start of the stack trace
> + *
> + * Returns number of entries stored.
> + */
> +unsigned int stack_trace_save_tsk(struct task_struct *tsk, unsigned long *store,
> +				  unsigned int size, unsigned int skipnr)
> +{
> +	stack_trace_consume_fn consume_entry = stack_trace_consume_entry_nosched;
> +	struct stacktrace_cookie c = {
> +		.store	= store,
> +		.size	= size,
> +		.skip	= skipnr + 1,
> +	};
> +
> +	if (!try_get_task_stack(tsk))
> +		return 0;
> +
> +	arch_stack_walk(consume_entry, &c, tsk, NULL);
> +	put_task_stack(tsk);
> +	return c.len;
> +}
> +
> +/**
> + * stack_trace_save_regs - Save a stack trace based on pt_regs into a storage array
> + * @regs:	Pointer to pt_regs to examine
> + * @store:	Pointer to storage array
> + * @size:	Size of the storage array
> + * @skipnr:	Number of entries to skip at the start of the stack trace
> + *
> + * Returns number of entries stored.
> + */
> +unsigned int stack_trace_save_regs(struct pt_regs *regs, unsigned long *store,
> +				   unsigned int size, unsigned int skipnr)
> +{
> +	stack_trace_consume_fn consume_entry = stack_trace_consume_entry;
> +	struct stacktrace_cookie c = {
> +		.store	= store,
> +		.size	= size,
> +		.skip	= skipnr,
> +	};
> +
> +	arch_stack_walk(consume_entry, &c, current, regs);
> +	return c.len;
> +}
> +
> +#ifdef CONFIG_HAVE_RELIABLE_STACKTRACE
> +/**
> + * stack_trace_save_tsk_reliable - Save task stack with verification
> + * @tsk:	Pointer to the task to examine
> + * @store:	Pointer to storage array
> + * @size:	Size of the storage array
> + *
> + * Returns:	An error if it detects any unreliable features of the
> + *		stack. Otherwise it guarantees that the stack trace is
> + *		reliable and returns the number of entries stored.
> + *
> + * If the task is not 'current', the caller *must* ensure the task is inactive.
> + */
> +int stack_trace_save_tsk_reliable(struct task_struct *tsk, unsigned long *store,
> +				  unsigned int size)
> +{
> +	stack_trace_consume_fn consume_entry = stack_trace_consume_entry;
> +	struct stacktrace_cookie c = {
> +		.store	= store,
> +		.size	= size,
> +	};
> +	int ret;
> +
> +	/*
> +	 * If the task doesn't have a stack (e.g., a zombie), the stack is
> +	 * "reliably" empty.
> +	 */
> +	if (!try_get_task_stack(tsk))
> +		return 0;
> +
> +	ret = arch_stack_walk_reliable(consume_entry, &c, tsk);
> +	put_task_stack(tsk);
> +	return ret;
> +}
> +#endif
> +
> +#ifdef CONFIG_USER_STACKTRACE_SUPPORT
> +/**
> + * stack_trace_save_user - Save a user space stack trace into a storage array
> + * @store:	Pointer to storage array
> + * @size:	Size of the storage array
> + *
> + * Returns number of entries stored.
> + */
> +unsigned int stack_trace_save_user(unsigned long *store, unsigned int size)
> +{
> +	stack_trace_consume_fn consume_entry = stack_trace_consume_entry;
> +	struct stacktrace_cookie c = {
> +		.store	= store,
> +		.size	= size,
> +	};
> +
> +	/* Trace user stack if not a kernel thread */
> +	if (!current->mm)
> +		return 0;
> +
> +	arch_stack_walk_user(consume_entry, &c, task_pt_regs(current));
> +	return c.len;
> +}
> +#endif
> +
> +#else /* CONFIG_ARCH_STACKWALK */
> +
>  /*
>   * Architectures that do not implement save_stack_trace_*()
>   * get these weak aliases and once-per-bootup warnings
> @@ -193,3 +364,5 @@ unsigned int stack_trace_save_user(unsig
>  	return trace.nr_entries;
>  }
>  #endif /* CONFIG_USER_STACKTRACE_SUPPORT */
> +
> +#endif /* !CONFIG_ARCH_STACKWALK */
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -597,6 +597,10 @@ config ARCH_HAS_UACCESS_FLUSHCACHE
>  config ARCH_HAS_UACCESS_MCSAFE
>  	bool
> 
> +# Temporary. Goes away when all archs are cleaned up
> +config ARCH_STACKWALK
> +       bool
> +
>  config STACKDEPOT
>  	bool
>  	select STACKTRACE
> 
> 

-- 
Sincerely yours,
Mike.
