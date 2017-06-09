From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 13/17] RISC-V: Add include subdirectory
Date: Fri, 9 Jun 2017 10:16:35 +0200
Message-ID: <20170609081635.mrqnzk3wxwou4nqy@hirez.programming.kicks-ass.net>
References: <20170523004107.536-1-palmer@dabbelt.com>
 <20170606230007.19101-1-palmer@dabbelt.com>
 <20170606230007.19101-14-palmer@dabbelt.com>
 <20170607131727.chhlzuu4gysyuqrn@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:42056 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751412AbdFIIQm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Jun 2017 04:16:42 -0400
Content-Disposition: inline
In-Reply-To: <20170607131727.chhlzuu4gysyuqrn@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, olof@lixom.net, albert@sifive.com, patches@groups.riscv.org, Will Deacon <will.deacon@arm.com>

On Wed, Jun 07, 2017 at 03:17:27PM +0200, Peter Zijlstra wrote:

> > +static inline void arch_spin_unlock(arch_spinlock_t *lock)
> > +{
> > +	__asm__ __volatile__ (
> > +		"amoswap.w.rl x0, x0, %0"
> > +		: "=A" (lock->lock)
> > +		:: "memory");
> > +}
> > +
> > +static inline int arch_spin_trylock(arch_spinlock_t *lock)
> > +{
> > +	int tmp = 1, busy;
> > +
> > +	__asm__ __volatile__ (
> > +		"amoswap.w.aq %0, %2, %1"
> > +		: "=r" (busy), "+A" (lock->lock)
> > +		: "r" (tmp)
> > +		: "memory");
> > +
> > +	return !busy;
> > +}

One other thing, you need to describe the acquire/release semantics for
your platform. Is the above lock RCpc or RCsc ? If RCpc, you need to
look into adding smp_mb__after_unlock_lock().
