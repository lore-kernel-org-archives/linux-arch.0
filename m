Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:43115 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753882AbcDYI2F (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 25 Apr 2016 04:28:05 -0400
Date: Mon, 25 Apr 2016 10:26:39 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH 19/31] locking,s390: Implement
 atomic{,64}_fetch_{add,sub,and,or,xor}()
Message-ID: <20160425082639.GC3430@twins.programming.kicks-ass.net>
References: <20160422090413.393652501@infradead.org>
 <20160422093924.273699893@infradead.org>
 <20160425100625.5f250bc1@mschwide>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160425100625.5f250bc1@mschwide>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: torvalds@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de, will.deacon@arm.com, paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com, waiman.long@hpe.com, fweisbec@gmail.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, egtvedt@samfundet.no, realmz6@gmail.com, ysato@users.sourceforge.jp, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, dhowells@redhat.com, jejb@parisc-linux.org, mpe@ellerman.id.au, dalias@libc.org, davem@davemloft.net, cmetcalf@mellanox.com, jcmvbkbc@gmail.com, arnd@arndb.de, dbueso@suse.de, fengguang.wu@intel.com
Message-ID: <20160425082639.DuPA9yuO9hRKHf3n7ueQq5PjQ68s7F9RECsrBmo3vB0@z>

On Mon, Apr 25, 2016 at 10:06:25AM +0200, Martin Schwidefsky wrote:
> On Fri, 22 Apr 2016 11:04:32 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > Implement FETCH-OP atomic primitives, these are very similar to the
> > existing OP-RETURN primitives we already have, except they return the
> > value of the atomic variable _before_ modification.
> > 
> > This is especially useful for irreversible operations -- such as
> > bitops (because it becomes impossible to reconstruct the state prior
> > to modification).
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  arch/s390/include/asm/atomic.h |   42 +++++++++++++++++++++++++++++++----------
> >  1 file changed, 32 insertions(+), 10 deletions(-)
> 
> That looks good, the code compiles and the functions are generated correctly.
> We will know for sure if it works after the first user of these new functions
> hit the kernel.

So we already have an atomic_fetch_or() user in the kernel, and this
series adds an atomic_fetch_add_acquire() user.

But yes, we'll undoubtedly grow more over time :-)

> Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

Thanks!
