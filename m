From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 7/7] lazy tlb: shoot lazies, a non-refcounting lazy
 tlb option
Date: Fri, 10 Jul 2020 11:35:56 +0200
Message-ID: <20200710093556.GY4800@hirez.programming.kicks-ass.net>
References: <20200710015646.2020871-1-npiggin@gmail.com>
 <20200710015646.2020871-8-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbgGJJgP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Jul 2020 05:36:15 -0400
Content-Disposition: inline
In-Reply-To: <20200710015646.2020871-8-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-arch@vger.kernel.org, x86@kernel.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, Anton Blanchard <anton@ozlabs.org>

On Fri, Jul 10, 2020 at 11:56:46AM +1000, Nicholas Piggin wrote:
> On big systems, the mm refcount can become highly contented when doing
> a lot of context switching with threaded applications (particularly
> switching between the idle thread and an application thread).
> 
> Abandoning lazy tlb slows switching down quite a bit in the important
> user->idle->user cases, so so instead implement a non-refcounted scheme
> that causes __mmdrop() to IPI all CPUs in the mm_cpumask and shoot down
> any remaining lazy ones.
> 
> On a 16-socket 192-core POWER8 system, a context switching benchmark
> with as many software threads as CPUs (so each switch will go in and
> out of idle), upstream can achieve a rate of about 1 million context
> switches per second. After this patch it goes up to 118 million.

That's mighty impressive, however:

> +static void shoot_lazy_tlbs(struct mm_struct *mm)
> +{
> +	if (IS_ENABLED(CONFIG_MMU_LAZY_TLB_SHOOTDOWN)) {
> +		smp_call_function_many(mm_cpumask(mm), do_shoot_lazy_tlb, (void *)mm, 1);
> +		do_shoot_lazy_tlb(mm);
> +	}
> +}

IIRC you (power) never clear a CPU from that mask, so for other
workloads I can see this resulting in massive amounts of IPIs.

For instance, take as many processes as you have CPUs. For each,
manually walk the task across all CPUs and exit. Again.

Clearly, that's an extreme, but still...
