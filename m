From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: SMP barriers semantics
Date: Wed, 17 Mar 2010 10:31:03 +0000
Message-ID: <1268821863.21344.85.camel@e102109-lin.cambridge.arm.com>
References: <1267527178.14461.9.camel@e102109-lin.cambridge.arm.com>
	 <20100303005529.GA3879@brick.ozlabs.ibm.com>
	 <1267617825.15589.82.camel@e102109-lin.cambridge.arm.com>
	 <20100312123105.GB4400@linux-mips.org>  <1268792716.2335.170.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:36726 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754081Ab0CQKdR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 17 Mar 2010 06:33:17 -0400
In-Reply-To: <1268792716.2335.170.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, Paul Mackerras <paulus@samba.org>, linux-arch@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>, Francois Romieu <romieu@fr.zoreil.com>

On Wed, 2010-03-17 at 02:25 +0000, Benjamin Herrenschmidt wrote:
> On Fri, 2010-03-12 at 13:31 +0100, Ralf Baechle wrote:
> > Be afraid, very afraid when you find a non-SMP memory barrier in the
> > kernel.  A while ago I reviewed a number of uses throughout the kernel and
> > each one of them was somehow buggy - either entirely unnecessary or should
> > be replaced with an SMP memory barrier or was simple miss-placed.
> 
> Yes, it's a problem that's plaguing us too.... Now that ARM is moving to
> a memory model that is similar to powerpc, maybe we should revisit
> things a little bit :-)
> 
> The way we sort out the issues currently on powerpc is very heavy handed
> and consists of sticking full barriers in our MMIO accessors.
> 
> We would -like- to improve that but there's just too much drivers out
> there that assume some kind of ordering between consistent memory
> accesses and IOs and between IOs and locks.

I find the memory-barriers.txt document pretty much alright, apart from
some clarification on the SMP barriers with respect to MMIO accesses.

> Maybe we can agree on a set of relaxed accessors defined specifically
> with those semantics (more relaxed implies use of raw_*) :
> 
>   - order is guaranteed between MMIOs
>   - no order is guaranteed between MMIOs and memory (cachable) accesses
>   - no order is guaranteed between MMIOs and spinlocks

I would add:

  - no order is guaranteed between MMIOs and interrupts
enabling/disabling

>   - a read access is not guaranteed to be performed until the read value
>     is actually consumed by the processor

I don't think we have this issue on ARM, we have speculative memory
accesses but not lazy accesses. Other architectures may of course
differ.

> Along with barriers along the line of (that's where we may want to
> discuss a bit I believe)
> 
>   - io_to_mem_rbarrier() : orders MMIO read vs. subsequent memory read

I currently assume rmb() to be enough for this (otherwise I don't see
where else the mandatory barriers would be useful).

>   - mem_to_io_wbarrier() : order memory write vs. subsequent MMIO write

wmb()

>                            (includes spin_unlock ?)

memory-barriers.txt suggests mmiowb() in such cases.

>   - io_to_mem_barrier()  : order any MMIO s. subsequent memory accesses

mb()

>   - mem_to_io_barrier()  : order memory accesses vs any subsequent MMIO

mb()

>   - flush_io_read(val)   : takes value from MMIO read, enforce it's
>                            before completed further instructions are
>                            issued, acts as compiler&execution barrier.

Could add a mmiorb()?

Ideally, we should avoid adding more barriers to Linux since many
drivers don't seem to use them anyway.

-- 
Catalin
