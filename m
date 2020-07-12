From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/2] locking/qspinlock: Store lock holder cpu in lock if
 feasible
Date: Sun, 12 Jul 2020 19:33:48 +0200
Message-ID: <20200712173348.GA10769@hirez.programming.kicks-ass.net>
References: <20200711182128.29130-1-longman@redhat.com>
 <20200711182128.29130-2-longman@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbgGLReA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 12 Jul 2020 13:34:00 -0400
Content-Disposition: inline
In-Reply-To: <20200711182128.29130-2-longman@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, Davidlohr Bueso <dave@stgolabs.net>

On Sat, Jul 11, 2020 at 02:21:27PM -0400, Waiman Long wrote:

> +static DEFINE_PER_CPU_READ_MOSTLY(u8, pcpu_lockval) = _Q_LOCKED_VAL;
>  
>  /*
>   * We must be able to distinguish between no-tail and the tail at 0:0,
> @@ -138,6 +139,19 @@ struct mcs_spinlock *grab_mcs_node(struct mcs_spinlock *base, int idx)
>  
>  #define _Q_LOCKED_PENDING_MASK (_Q_LOCKED_MASK | _Q_PENDING_MASK)
>  
> +static __init int __init_pcpu_lockval(void)
> +{
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		u8 lockval = (cpu + 2 < _Q_LOCKED_MASK - 1) ? cpu + 2
> +							    : _Q_LOCKED_VAL;
> +		per_cpu(pcpu_lockval, cpu) = lockval;
> +	}
> +	return 0;
> +}
> +early_initcall(__init_pcpu_lockval);

> +	u8 lockval = this_cpu_read(pcpu_lockval);

Urgh... so you'd rather read a guaranteed cold line than to use
smp_processor_id(), which we already use anyway?

I'm skeptical this helps anything, and it certainly makes the code more
horrible :-(
