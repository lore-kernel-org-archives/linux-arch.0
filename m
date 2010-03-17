From: Jamie Lokier <jamie@shareable.org>
Subject: Re: SMP barriers semantics
Date: Wed, 17 Mar 2010 13:42:43 +0000
Message-ID: <20100317134243.GA15235@shareable.org>
References: <1267527178.14461.9.camel@e102109-lin.cambridge.arm.com> <20100303005529.GA3879@brick.ozlabs.ibm.com> <1267617825.15589.82.camel@e102109-lin.cambridge.arm.com> <20100312123105.GB4400@linux-mips.org> <1268792716.2335.170.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail2.shareable.org ([80.68.89.115]:54248 "EHLO
	mail2.shareable.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753822Ab0CQNnM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 17 Mar 2010 09:43:12 -0400
Content-Disposition: inline
In-Reply-To: <1268792716.2335.170.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, Catalin Marinas <catalin.marinas@arm.com>, Paul Mackerras <paulus@samba.org>, linux-arch@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>, Francois Romieu <romieu@fr.zoreil.com>

Benjamin Herrenschmidt wrote:
> Maybe we can agree on a set of relaxed accessors defined specifically
> with those semantics (more relaxed implies use of raw_*) :
> 
>   - order is guaranteed between MMIOs
>   - no order is guaranteed between MMIOs and spinlocks

No order between MMIOs and spinlocks will be fun :-)

>   - a read access is not guaranteed to be performed until the read value
>     is actually consumed by the processor

How do you define 'consumed'?  It's not obvious: see
read_barrier_depends() on Alpha, and elsewhere speculative read
optimisations (including by the compiler on IA64, in theory).

> Along with barriers along the line of (that's where we may want to
> discuss a bit I believe)
> 
>   - io_to_mem_rbarrier() : orders MMIO read vs. subsequent memory read
>   - mem_to_io_wbarrier() : order memory write vs. subsequent MMIO write
>                            (includes spin_unlock ?)
>   - io_to_mem_barrier()  : order any MMIO s. subsequent memory accesses
>   - mem_to_io_barrier()  : order memory accesses vs any subsequent MMIO
>   - flush_io_read(val)   : takes value from MMIO read, enforce it's
>                            before completed further instructions are
>                            issued, acts as compiler&execution barrier. 
> 
> What do you guys think ? I think io_to_mem_rbarrier() and
> mem_to_io_wbarrier() cover most useful cases, except maybe the IO vs.
> locks.

I'm thinking the current scheme with "heavy" barriers that serialise
everything is better - because it's simple to understand.  I think the
above set are likely to be accidentally misused, and even pass review
occasionally when they are wrong, even if it's just due to brain farts.

The "heavy" barrier names could change from rmb/mb/wmb to
io_rmb/io_mb/io_wmb or something.

Is there any real performance advantage expected from more
fine-grained MMIO barriers?

Another approach is a flags argument to a single macro:
barrier(BARRIER_MMIO_READ_BEFORE | BARRIER_MEM_READ_AFTER), etc.
Each arch would expand it to a barrier at least as strong as the one
requested.  C++0x atomics are going down this route, I think.

-- Jamie
