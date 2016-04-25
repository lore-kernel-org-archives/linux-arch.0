From: Chris Metcalf <cmetcalf@mellanox.com>
Subject: Re: [RFC][PATCH 22/31] locking,tile: Implement
 atomic{,64}_fetch_{add,sub,and,or,xor}()
Date: Mon, 25 Apr 2016 17:10:58 -0400
Message-ID: <571E87E2.3010306@mellanox.com>
References: <20160422090413.393652501@infradead.org>
 <20160422093924.482859927@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-am1on0057.outbound.protection.outlook.com ([157.56.112.57]:5440
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964811AbcDYVL2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 25 Apr 2016 17:11:28 -0400
In-Reply-To: <20160422093924.482859927@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, torvalds@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de, will.deacon@arm.com, paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com, waiman.long@hpe.com, fweisbec@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, egtvedt@samfundet.no, realmz6@gmail.com, ysato@users.sourceforge.jp, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, dhowells@redhat.com, jejb@parisc-linux.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, dalias@libc.org, davem@davemloft.net, jcmvbkbc@gmail.com, arnd@arndb.de, dbueso@suse.de, fengguang.wu@intel.com

[Grr, resending as text/plain; I have no idea what inspired Thunderbird
to send this as multipart/mixed with HTML.]

On 4/22/2016 5:04 AM, Peter Zijlstra wrote:
> Implement FETCH-OP atomic primitives, these are very similar to the
> existing OP-RETURN primitives we already have, except they return the
> value of the atomic variable_before_  modification.
>
> This is especially useful for irreversible operations -- such as
> bitops (because it becomes impossible to reconstruct the state prior
> to modification).
>
> XXX please look at the tilegx (CONFIG_64BIT) atomics, I think we get
> the barriers wrong (at the very least they're inconsistent).
>
> Signed-off-by: Peter Zijlstra (Intel)<peterz@infradead.org>
> ---
>   arch/tile/include/asm/atomic.h    |    4 +
>   arch/tile/include/asm/atomic_32.h |   60 +++++++++++++------
>   arch/tile/include/asm/atomic_64.h |  117 +++++++++++++++++++++++++-------------
>   arch/tile/include/asm/bitops_32.h |   18 ++---
>   arch/tile/lib/atomic_32.c         |   42 ++++++-------
>   arch/tile/lib/atomic_asm_32.S     |   14 ++--
>   6 files changed, 161 insertions(+), 94 deletions(-)
>
> [...]
>   static inline int atomic_add_return(int i, atomic_t *v)
>   {
>   	int val;
>   	smp_mb();  /* barrier for proper semantics */
>   	val = __insn_fetchadd4((void *)&v->counter, i) + i;
>   	barrier();  /* the "+ i" above will wait on memory */
> +	/* XXX smp_mb() instead, as per cmpxchg() ? */
>   	return val;
>   }

The existing code is subtle but I'm pretty sure it's not a bug.

The tilegx architecture will take the "+ i" and generate an add instruction.
The compiler barrier will make sure the add instruction happens before
anything else that could touch memory, and the microarchitecture will make
sure that the result of the atomic fetchadd has been returned to the core
before any further instructions are issued.  (The memory architecture is
lazy, but when you feed a load through an arithmetic operation, we block
issuing any further instructions until the add's operands are available.)

This would not be an adequate memory barrier in general, since other loads
or stores might still be in flight, even if the "val" operand had made it
from memory to the core at this point.  However, we have issued no other
stores or loads since the previous memory barrier, so we know that there
can be no other loads or stores in flight, and thus the compiler barrier
plus arithmetic op is equivalent to a memory barrier here.

In hindsight, perhaps a more substantial comment would have been helpful
here.  Unless you see something missing in my analysis, I'll plan to go
ahead and add a suitable comment here :-)

Otherwise, though just based on code inspection so far:

Acked-by: Chris Metcalf<cmetcalf@mellanox.com>  [for tile]

-- 
Chris Metcalf, Mellanox Technologies
http://www.mellanox.com
