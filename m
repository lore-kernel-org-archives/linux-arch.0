From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/4] arch: Clean up asm/barrier.h implementations using
 asm-generic/barrier.h
Date: Fri, 8 Nov 2013 12:03:35 +0100
Message-ID: <20131108110335.GH19203@twins.programming.kicks-ass.net>
References: <20131108062645.GB2693@Krystal>
 <1426746962.63022.1383906498239.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:48065 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753046Ab3KHLEF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 8 Nov 2013 06:04:05 -0500
Content-Disposition: inline
In-Reply-To: <1426746962.63022.1383906498239.JavaMail.zimbra@efficios.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-arch@vger.kernel.org, geert@linux-m68k.org, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org, VICTORK@il.ibm.com, oleg@redhat.com, anton@samba.org, benh@kernel.crashing.org, fweisbec@gmail.com, michael@ellerman.id.au, mikey@neuling.org, linux@arm.linux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, tony.luck@intel.com

On Fri, Nov 08, 2013 at 10:28:18AM +0000, Mathieu Desnoyers wrote:
> (forwarded due to SMTP issues)
> > > +#define smp_mb__before_atomic_dec()	barrier()
> > > +#define smp_mb__after_atomic_dec()	barrier()
> > > +#define smp_mb__before_atomic_inc()	barrier()
> > > +#define smp_mb__after_atomic_inc()	barrier()
> > 
> > Maybe split the before/after atomic inc/dec change to a separate patch ?

> > This seems to remove before/after atomic inc/dec for hexagon, but I
> > don't see where they are added back ?

Oops, yeah, split these two into a separate patch.

> > > +#ifndef nop
> > > +#define nop()	asm volatile ("nop")
> > > +#endif
> > >  
> > 
> > I don't really understand why "no-op" sits within barrier.h. It might be
> > a lack of imagination on my part though.

Yeah, not sure either..

> > Other than that
> > 
> > Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks!
