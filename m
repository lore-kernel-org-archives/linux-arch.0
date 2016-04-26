From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH 22/31] locking,tile: Implement
 atomic{,64}_fetch_{add,sub,and,or,xor}()
Date: Tue, 26 Apr 2016 17:28:44 +0200
Message-ID: <20160426152844.GZ3448@twins.programming.kicks-ass.net>
References: <20160422090413.393652501@infradead.org>
 <20160422093924.482859927@infradead.org>
 <571E840A.8090703@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:39430 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751840AbcDZP3e (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 26 Apr 2016 11:29:34 -0400
Content-Disposition: inline
In-Reply-To: <571E840A.8090703@mellanox.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Metcalf <cmetcalf@mellanox.com>
Cc: torvalds@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de, will.deacon@arm.com, paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com, waiman.long@hpe.com, fweisbec@gmail.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, egtvedt@samfundet.no, realmz6@gmail.com, ysato@users.sourceforge.jp, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, dhowells@redhat.com, jejb@parisc-linux.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, dalias@libc.org, davem@davemloft.net, jcmvbkbc@gmail.com, arnd@arndb.de, dbueso@suse.de, fengguang.wu@intel.com

On Mon, Apr 25, 2016 at 04:54:34PM -0400, Chris Metcalf wrote:
> On 4/22/2016 5:04 AM, Peter Zijlstra wrote:

> >  static inline int atomic_add_return(int i, atomic_t *v)
> >  {
> >  	int val;
> >  	smp_mb();  /* barrier for proper semantics */
> >  	val = __insn_fetchadd4((void *)&v->counter, i) + i;
> >  	barrier();  /* the "+ i" above will wait on memory */
> >+	/* XXX smp_mb() instead, as per cmpxchg() ? */
> >  	return val;
> >  }
> 
> The existing code is subtle but I'm pretty sure it's not a bug.
> 
> The tilegx architecture will take the "+ i" and generate an add instruction.
> The compiler barrier will make sure the add instruction happens before
> anything else that could touch memory, and the microarchitecture will make
> sure that the result of the atomic fetchadd has been returned to the core
> before any further instructions are issued.  (The memory architecture is
> lazy, but when you feed a load through an arithmetic operation, we block
> issuing any further instructions until the add's operands are available.)
> 
> This would not be an adequate memory barrier in general, since other loads
> or stores might still be in flight, even if the "val" operand had made it
> from memory to the core at this point.  However, we have issued no other
> stores or loads since the previous memory barrier, so we know that there
> can be no other loads or stores in flight, and thus the compiler barrier
> plus arithmetic op is equivalent to a memory barrier here.
> 
> In hindsight, perhaps a more substantial comment would have been helpful
> here.  Unless you see something missing in my analysis, I'll plan to go
> ahead and add a suitable comment here :-)
> 
> Otherwise, though just based on code inspection so far:
> 
> Acked-by: Chris Metcalf <cmetcalf@mellanox.com> [for tile]

Thanks!

Just to verify; the new fetch-op thingies _do_ indeed need the extra
smp_mb() as per my patch, because there is no trailing instruction
depending on the completion of the load?
