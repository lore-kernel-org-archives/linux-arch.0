From: Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [PATCH 6/7] sched, x86: Provide a per-cpu preempt_count
 implementation
Date: Tue, 10 Sep 2013 07:02:51 -0700
Message-ID: <1378821771.26319.82.camel@edumazet-glaptop>
References: <20130910130811.507933095@infradead.org>
	 <20130910132011.396291123@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:47633 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751348Ab3IJOCx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 Sep 2013 10:02:53 -0400
In-Reply-To: <20130910132011.396291123@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Andi Kleen <ak@linux.intel.com>, Peter Anvin <hpa@zytor.com>, Mike Galbraith <bitbucket@online.de>, Thomas Gleixner <tglx@linutronix.de>, Arjan van de Ven <arjan@linux.intel.com>, Frederic Weisbecker <fweisbec@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Tue, 2013-09-10 at 15:08 +0200, Peter Zijlstra wrote:

> +static __always_inline int preempt_count(void)
> +{
> +	return __this_cpu_read_4(__preempt_count) & ~PREEMPT_NEED_RESCHED;
> +}

Not sure why you used the _4 prefix on all accessors ?

>  
> +#ifdef CONFIG_PREEMPT_COUNT
> +	/*
> +	 * If it were not for PREEMPT_ACTIVE we could guarantee that the
> +	 * preempt_count of all tasks was equal here and this would not be
> +	 * needed.
> +	 */
> +	task_thread_info(prev_p)->saved_preempt_count = __raw_get_cpu_var(__preempt_count);

	this_cpu_read(__preempt_count) ?

> +	__raw_get_cpu_var(__preempt_count) = task_thread_info(next_p)->saved_preempt_count;

	this_cpu_write(__preempt_count,
                       task_thread_info(next_p)->saved_preempt_count;

> +#endif
> +
>  	this_cpu_write(kernel_stack,
>  		  (unsigned long)task_stack_page(next_p) +
>  		  THREAD_SIZE - KERNEL_STACK_OFFSET);
> 
> 
