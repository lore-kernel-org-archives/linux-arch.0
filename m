Return-Path: <SRS0=hCR/=AV=kvack.org=owner-linux-mm@kernel.org>
Date: Fri, 10 Jul 2020 11:48:00 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 5/7] lazy tlb: introduce lazy mm refcount helper
 functions
Message-ID: <20200710094800.GA4800@hirez.programming.kicks-ass.net>
References: <20200710015646.2020871-1-npiggin@gmail.com>
 <20200710015646.2020871-6-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710015646.2020871-6-npiggin@gmail.com>
Sender: owner-linux-mm@kvack.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-arch@vger.kernel.org, x86@kernel.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, Anton Blanchard <anton@ozlabs.org>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200710094800.Efx-b25TIN7ojifoxdFUGjWh3dNFWO8sVpP5Tr_5V0g@z>

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
