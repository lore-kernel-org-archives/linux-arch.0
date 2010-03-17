From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: SMP barriers semantics
Date: Wed, 17 Mar 2010 13:25:16 +1100
Message-ID: <1268792716.2335.170.camel@pasglop>
References: <1267527178.14461.9.camel@e102109-lin.cambridge.arm.com>
	 <20100303005529.GA3879@brick.ozlabs.ibm.com>
	 <1267617825.15589.82.camel@e102109-lin.cambridge.arm.com>
	 <20100312123105.GB4400@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:44652 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752297Ab0CQC0T (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 16 Mar 2010 22:26:19 -0400
In-Reply-To: <20100312123105.GB4400@linux-mips.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Paul Mackerras <paulus@samba.org>, linux-arch@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>, Francois Romieu <romieu@fr.zoreil.com>

On Fri, 2010-03-12 at 13:31 +0100, Ralf Baechle wrote:
> 
> Be afraid, very afraid when you find a non-SMP memory barrier in the
> kernel.  A while ago I reviewed a number of uses throughout the kernel and
> each one of them was somehow buggy - either entirely unnecessary or should
> be replaced with an SMP memory barrier or was simple miss-placed. 

Yes, it's a problem that's plaguing us too.... Now that ARM is moving to
a memory model that is similar to powerpc, maybe we should revisit
things a little bit :-)

The way we sort out the issues currently on powerpc is very heavy handed
and consists of sticking full barriers in our MMIO accessors.

We would -like- to improve that but there's just too much drivers out
there that assume some kind of ordering between consistent memory
accesses and IOs and between IOs and locks.

The only "sane" way out here would thus be to define a set of MMIO
accessors with relaxed ordering semantics along with appropriate
barriers. However, when we tried to do that, we mostly failed agreeing
on what the semantics actually should be since most architectures are
going to be subtly different in that regard.

The __raw_* variants are of no use since they have other effects such as
not performing endian swapping on BE architectures. Plus we don't have
the proper explicit barriers anyways.

Maybe we can agree on a set of relaxed accessors defined specifically
with those semantics (more relaxed implies use of raw_*) :

  - order is guaranteed between MMIOs
  - no order is guaranteed between MMIOs and memory (cachable) accesses
  - no order is guaranteed between MMIOs and spinlocks
  - a read access is not guaranteed to be performed until the read value
    is actually consumed by the processor

Along with barriers along the line of (that's where we may want to
discuss a bit I believe)

  - io_to_mem_rbarrier() : orders MMIO read vs. subsequent memory read
  - mem_to_io_wbarrier() : order memory write vs. subsequent MMIO write
                           (includes spin_unlock ?)
  - io_to_mem_barrier()  : order any MMIO s. subsequent memory accesses
  - mem_to_io_barrier()  : order memory accesses vs any subsequent MMIO
  - flush_io_read(val)   : takes value from MMIO read, enforce it's
                           before completed further instructions are
                           issued, acts as compiler&execution barrier. 

What do you guys think ? I think io_to_mem_rbarrier() and
mem_to_io_wbarrier() cover most useful cases, except maybe the IO vs.
locks.

Maybe for the later (locks) we can stick to the arch is responsible for
making that happen, for example by having MMIO writes set a per-cpu flag
and having spin_unlock do a barrier when that is set, and take that out
of the list of non-guaranteed ordering semantics.

Cheers,
Ben.
 
