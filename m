From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 5/7] lazy tlb: introduce lazy mm refcount helper
 functions
Date: Fri, 10 Jul 2020 11:48:00 +0200
Message-ID: <20200710094800.GA4800@hirez.programming.kicks-ass.net>
References: <20200710015646.2020871-1-npiggin@gmail.com>
 <20200710015646.2020871-6-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbgGJJsN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Jul 2020 05:48:13 -0400
Content-Disposition: inline
In-Reply-To: <20200710015646.2020871-6-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-arch@vger.kernel.org, x86@kernel.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, Anton Blanchard <anton@ozlabs.org>

On Fri, Jul 10, 2020 at 11:56:44AM +1000, Nicholas Piggin wrote:

> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 73199470c265..ad95812d2a3f 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -1253,7 +1253,7 @@ void start_secondary(void *unused)
>  	unsigned int cpu = smp_processor_id();
>  	struct cpumask *(*sibling_mask)(int) = cpu_sibling_mask;
>  
> -	mmgrab(&init_mm);
> +	mmgrab(&init_mm); /* XXX: where is the mmput for this? */
>  	current->active_mm = &init_mm;
>  
>  	smp_store_cpu_info(cpu);

Right; so IIRC it should be this one:

> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 134688d79589..ff9fcbc4e76b 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -578,7 +578,7 @@ static int finish_cpu(unsigned int cpu)
>  	 */
>  	if (mm != &init_mm)
>  		idle->active_mm = &init_mm;
> -	mmdrop(mm);
> +	mmdrop_lazy_tlb(mm);
>  	return 0;
>  }
