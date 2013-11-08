From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 3/4] arch: Introduce smp_load_acquire(),
 smp_store_release()
Date: Fri, 8 Nov 2013 15:58:43 +1100
Message-ID: <20131108045843.GA813@iris.ozlabs.ibm.com>
References: <20131107220314.740353088@infradead.org>
 <20131107221254.226041159@infradead.org>
 <20131107210320.GC27329@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:59600 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753652Ab3KHE67 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 7 Nov 2013 23:58:59 -0500
Content-Disposition: inline
In-Reply-To: <20131107210320.GC27329@Krystal>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: peterz@infradead.org, linux-arch@vger.kernel.org, geert@linux-m68k.org, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org, VICTORK@il.ibm.com, oleg@redhat.com, anton@samba.org, benh@kernel.crashing.org, fweisbec@gmail.com, michael@ellerman.id.au, mikey@neuling.org, linux@arm.linux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, tony.luck@intel.com, Will Deacon <will.deacon@arm.com>

On Thu, Nov 07, 2013 at 04:03:20PM -0500, Mathieu Desnoyers wrote:
> * peterz@infradead.org (peterz@infradead.org) wrote:

> > +#define smp_store_release(p, v)						\
> > +do {									\
> > +	compiletime_assert_atomic_type(*p);				\
> > +	__lwsync();							\
> 
> Even though this is correct, it appears to bear more overhead than
> necessary. See arch/powerpc/include/asm/synch.h
> 
> PPC_ACQUIRE_BARRIER and PPC_RELEASE_BARRIER
> 
> You'll notice that some variants of powerpc require something more
> heavy-weight than a lwsync instruction. The fallback will be "isync"
> rather than "sync" if you use PPC_ACQUIRE_BARRIER and
> PPC_RELEASE_BARRIER rather than LWSYNC directly.

I think this needs to fall back to sync as Peter has it.  isync is not
actually a memory barrier.  It is more like an execution barrier, and
when used after stwcx.; bne (or stdcx.; bne) it has the effect of
preventing following loads/stores from being executed until the
stwcx. has completed.  In this case we're not using stwcx./stdcx.,
just a normal store, so isync won't have the desired effect.

Regards,
Paul.
