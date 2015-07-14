From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/5] atomics: add acquire/release/relaxed variants of
 some atomic operations
Date: Tue, 14 Jul 2015 12:25:11 +0200
Message-ID: <20150714102511.GI19282@twins.programming.kicks-ass.net>
References: <1436790687-11984-1-git-send-email-will.deacon@arm.com>
 <1436790687-11984-2-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:59180 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752021AbbGNKZV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jul 2015 06:25:21 -0400
Content-Disposition: inline
In-Reply-To: <1436790687-11984-2-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org, Waiman.Long@hp.com, linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com

On Mon, Jul 13, 2015 at 01:31:23PM +0100, Will Deacon wrote:
> +
> +/*
> + * Relaxed variants of xchg, cmpxchg and some atomic operations.
> + *
> + * We support four variants:
> + *
> + * - Fully ordered: The default implementation, no suffix required.
> + * - Acquire: Provides ACQUIRE semantics, _acquire suffix.
> + * - Release: Provides RELEASE semantics, _release suffix.
> + * - Relaxed: No ordering guarantees, _relaxed suffix.
> + *
> + * See Documentation/memory-barriers.txt for ACQUIRE/RELEASE definitions.
> + */
> +
> +#ifndef atomic_read_acquire
> +#define  atomic_read_acquire(v)		smp_load_acquire(&(v)->counter)
> +#endif
> +
> +#ifndef atomic_set_release
> +#define  atomic_set_release(v, i)	smp_store_release(&(v)->counter, (i))
> +#endif
> +
> +#ifndef atomic_add_return_relaxed
> +#define  atomic_add_return_relaxed	atomic_add_return
> +#endif
> +#ifndef atomic_add_return_acquire
> +#define  atomic_add_return_acquire	atomic_add_return
> +#endif
> +#ifndef atomic_add_return_release
> +#define  atomic_add_return_release	atomic_add_return
> +#endif

Could we not define _{acquire,release} in terms of _relaxed and
smp_mb__{after,before}_atomic() ?

That way most archs really only need to implement _relaxed and be done
with it. ARM is special in that it actually has acquire/release
semantics in hardware (IA64 has it in the ISA but its not effective).
