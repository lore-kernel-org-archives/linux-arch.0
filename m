From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 2/4] arch: Clean up asm/barrier.h implementations using
 asm-generic/barrier.h
Date: Fri, 8 Nov 2013 10:28:18 +0000 (UTC)
Message-ID: <1426746962.63022.1383906498239.JavaMail.zimbra@efficios.com>
References: <20131108062645.GB2693@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.efficios.com ([78.47.125.74]:59567 "EHLO mail.efficios.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756980Ab3KHK2R (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 8 Nov 2013 05:28:17 -0500
In-Reply-To: <20131108062645.GB2693@Krystal>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: peterz@infradead.org
Cc: linux-arch@vger.kernel.org, geert@linux-m68k.org, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org, VICTORK@il.ibm.com, oleg@redhat.com, anton@samba.org, benh@kernel.crashing.org, fweisbec@gmail.com, michael@ellerman.id.au, mikey@neuling.org, linux@arm.linux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, tony.luck@intel.com

(forwarded due to SMTP issues)

----- Forwarded Message -----
> From: "Mathieu Desnoyers" <compudj@krystal.dyndns.org>
> To: "mathieu desnoyers" <mathieu.desnoyers@efficios.com>
> Sent: Friday, November 8, 2013 1:26:45 AM
> Subject: (forw) [mathieu.desnoyers@efficios.com: Re: [PATCH 2/4] arch: Clean up asm/barrier.h implementations using
> asm-generic/barrier.h]
> 
> ----- Forwarded message from Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> -----
> 
> Date: Thu, 7 Nov 2013 15:22:56 -0500
> To: peterz@infradead.org
> Cc: linux-arch@vger.kernel.org, geert@linux-m68k.org,
> paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org,
> VICTORK@il.ibm.com, oleg@redhat.com, anton@samba.org,
> 	benh@kernel.crashing.org, fweisbec@gmail.com, michael@ellerman.id.au,
> 	mikey@neuling.org, linux@arm.linux.org.uk, schwidefsky@de.ibm.com,
> 	heiko.carstens@de.ibm.com, tony.luck@intel.com
> User-Agent: Mutt/1.5.21 (2010-09-15)
> From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Subject: Re: [PATCH 2/4] arch: Clean up asm/barrier.h implementations using
> asm-generic/barrier.h
> 
> * peterz@infradead.org (peterz@infradead.org) wrote:
> > We're going to be adding a few new barrier primitives, and in order to
> > avoid endless duplication make more agressive use of
> > asm-generic/barrier.h.
> > 
> > Change the asm-generic/barrier.h such that it allows partial barrier
> > definitions and fills out the rest with defaults.
> > 
> > There are a few architectures (h8300, m32r, m68k) that could probably
> > do away with their barrier.h file entirely but are kept for now due to
> > their unconventional nop() implementation.
> 
> FWIW, we're using a very similar scheme for our memory barrier
> implementation in Userspace RCU. We include a generic header at the end,
> and we have per-architecture macro override, with ifdefs to see if we
> need to use the generic version.
> 
> Comments below,
> 
> > 
> > Cc: Tony Luck <tony.luck@intel.com>
> > Cc: Oleg Nesterov <oleg@redhat.com>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Frederic Weisbecker <fweisbec@gmail.com>
> > Cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
> > Cc: Michael Ellerman <michael@ellerman.id.au>
> > Cc: Michael Neuling <mikey@neuling.org>
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > Cc: Victor Kaplansky <VICTORK@il.ibm.com>
> > Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Reviewed-by: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> > Signed-off-by: Peter Zijlstra <peterz@infradead.org>
> > ---
> >  arch/alpha/include/asm/barrier.h      |   25 ++--------
> >  arch/arc/include/asm/Kbuild           |    1
> >  arch/arc/include/asm/atomic.h         |    5 ++
> >  arch/arc/include/asm/barrier.h        |   42 -----------------
> >  arch/avr32/include/asm/barrier.h      |   17 ++-----
> >  arch/blackfin/include/asm/barrier.h   |   18 -------
> >  arch/cris/include/asm/Kbuild          |    1
> >  arch/cris/include/asm/barrier.h       |   25 ----------
> >  arch/frv/include/asm/barrier.h        |    8 ---
> >  arch/h8300/include/asm/barrier.h      |   21 --------
> >  arch/hexagon/include/asm/Kbuild       |    1
> >  arch/hexagon/include/asm/barrier.h    |   41 -----------------
> >  arch/m32r/include/asm/barrier.h       |   80
> >  ----------------------------------
> >  arch/m68k/include/asm/barrier.h       |   14 -----
> >  arch/microblaze/include/asm/Kbuild    |    1
> >  arch/microblaze/include/asm/barrier.h |   27 -----------
> >  arch/mn10300/include/asm/Kbuild       |    1
> >  arch/mn10300/include/asm/barrier.h    |   37 ---------------
> >  arch/parisc/include/asm/Kbuild        |    1
> >  arch/parisc/include/asm/barrier.h     |   35 --------------
> >  arch/score/include/asm/Kbuild         |    1
> >  arch/score/include/asm/barrier.h      |   16 ------
> >  arch/sh/include/asm/barrier.h         |   21 +-------
> >  arch/sparc/include/asm/barrier_32.h   |   11 ----
> >  arch/tile/include/asm/barrier.h       |   68 ----------------------------
> >  arch/unicore32/include/asm/barrier.h  |   11 ----
> >  arch/xtensa/include/asm/barrier.h     |    9 ---
> >  include/asm-generic/barrier.h         |   44 ++++++++++++------
> >  28 files changed, 64 insertions(+), 518 deletions(-)
> > 
> [...]
> 
> > Index: linux-2.6/arch/arc/include/asm/atomic.h
> > ===================================================================
> > --- linux-2.6.orig/arch/arc/include/asm/atomic.h	2013-11-07
> > 17:03:11.626900787 +0100
> > +++ linux-2.6/arch/arc/include/asm/atomic.h	2013-11-07 17:03:11.607900434
> > +0100
> > @@ -190,6 +190,11 @@
> >  
> >  #endif /* !CONFIG_ARC_HAS_LLSC */
> >  
> > +#define smp_mb__before_atomic_dec()	barrier()
> > +#define smp_mb__after_atomic_dec()	barrier()
> > +#define smp_mb__before_atomic_inc()	barrier()
> > +#define smp_mb__after_atomic_inc()	barrier()
> 
> Maybe split the before/after atomic inc/dec change to a separate patch ?
> 
> > +
> >  /**
> >   * __atomic_add_unless - add unless the number is a given value
> >   * @v: pointer of type atomic_t
> > Index: linux-2.6/arch/arc/include/asm/barrier.h
> > ===================================================================
> > --- linux-2.6.orig/arch/arc/include/asm/barrier.h	2013-11-07
> > 17:03:11.626900787 +0100
> > +++ /dev/null	1970-01-01 00:00:00.000000000 +0000
> > @@ -1,42 +0,0 @@
> > -/*
> > - * Copyright (C) 2004, 2007-2010, 2011-2012 Synopsys, Inc.
> > (www.synopsys.com)
> > - *
> > - * This program is free software; you can redistribute it and/or modify
> > - * it under the terms of the GNU General Public License version 2 as
> > - * published by the Free Software Foundation.
> > - */
> > -
> > -#ifndef __ASM_BARRIER_H
> > -#define __ASM_BARRIER_H
> > -
> > -#ifndef __ASSEMBLY__
> > -
> > -/* TODO-vineetg: Need to see what this does, don't we need sync anywhere
> > */
> > -#define mb() __asm__ __volatile__ ("" : : : "memory")
> > -#define rmb() mb()
> > -#define wmb() mb()
> > -#define set_mb(var, value)  do { var = value; mb(); } while (0)
> > -#define set_wmb(var, value) do { var = value; wmb(); } while (0)
> > -#define read_barrier_depends()  mb()
> > -
> > -/* TODO-vineetg verify the correctness of macros here */
> > -#ifdef CONFIG_SMP
> > -#define smp_mb()        mb()
> > -#define smp_rmb()       rmb()
> > -#define smp_wmb()       wmb()
> > -#else
> > -#define smp_mb()        barrier()
> > -#define smp_rmb()       barrier()
> > -#define smp_wmb()       barrier()
> > -#endif
> > -
> > -#define smp_mb__before_atomic_dec()	barrier()
> > -#define smp_mb__after_atomic_dec()	barrier()
> > -#define smp_mb__before_atomic_inc()	barrier()
> > -#define smp_mb__after_atomic_inc()	barrier()
> > -
> > -#define smp_read_barrier_depends()      do { } while (0)
> > -
> > -#endif
> > -
> > -#endif
> 
> [...]
> 
> > Index: linux-2.6/arch/hexagon/include/asm/barrier.h
> > ===================================================================
> > --- linux-2.6.orig/arch/hexagon/include/asm/barrier.h	2013-11-07
> > 17:03:11.626900787 +0100
> > +++ /dev/null	1970-01-01 00:00:00.000000000 +0000
> > @@ -1,41 +0,0 @@
> > -/*
> > - * Memory barrier definitions for the Hexagon architecture
> > - *
> > - * Copyright (c) 2010-2011, The Linux Foundation. All rights reserved.
> > - *
> > - * This program is free software; you can redistribute it and/or modify
> > - * it under the terms of the GNU General Public License version 2 and
> > - * only version 2 as published by the Free Software Foundation.
> > - *
> > - * This program is distributed in the hope that it will be useful,
> > - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - * GNU General Public License for more details.
> > - *
> > - * You should have received a copy of the GNU General Public License
> > - * along with this program; if not, write to the Free Software
> > - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> > - * 02110-1301, USA.
> > - */
> > -
> > -#ifndef _ASM_BARRIER_H
> > -#define _ASM_BARRIER_H
> > -
> > -#define rmb()				barrier()
> > -#define read_barrier_depends()		barrier()
> > -#define wmb()				barrier()
> > -#define mb()				barrier()
> > -#define smp_rmb()			barrier()
> > -#define smp_read_barrier_depends()	barrier()
> > -#define smp_wmb()			barrier()
> > -#define smp_mb()			barrier()
> > -#define smp_mb__before_atomic_dec()	barrier()
> > -#define smp_mb__after_atomic_dec()	barrier()
> > -#define smp_mb__before_atomic_inc()	barrier()
> > -#define smp_mb__after_atomic_inc()	barrier()
> 
> This seems to remove before/after atomic inc/dec for hexagon, but I
> don't see where they are added back ?
> 
> > -
> > -/*  Set a value and use a memory barrier.  Used by the scheduler
> > somewhere.  */
> > -#define set_mb(var, value) \
> > -	do { var = value; mb(); } while (0)
> > -
> > -#endif /* _ASM_BARRIER_H */
> 
> [...]
> 
> > Index: linux-2.6/include/asm-generic/barrier.h
> > ===================================================================
> > --- linux-2.6.orig/include/asm-generic/barrier.h	2013-11-07
> > 17:03:11.626900787 +0100
> > +++ linux-2.6/include/asm-generic/barrier.h	2013-11-07 17:03:11.623900731
> > +0100
> > @@ -1,4 +1,5 @@
> > -/* Generic barrier definitions, based on MN10300 definitions.
> > +/*
> > + * Generic barrier definitions, originally based on MN10300 definitions.
> >   *
> >   * It should be possible to use these on really simple architectures,
> >   * but it serves more as a starting point for new ports.
> > @@ -16,35 +17,50 @@
> >  
> >  #ifndef __ASSEMBLY__
> >  
> > -#define nop() asm volatile ("nop")
> > +#include <linux/compiler.h>
> > +
> > +#ifndef nop
> > +#define nop()	asm volatile ("nop")
> > +#endif
> >  
> 
> I don't really understand why "no-op" sits within barrier.h. It might be
> a lack of imagination on my part though.
> 
> Other than that
> 
> Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> 
> Thanks,
> 
> Mathieu
> 
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
> 
> ----- End forwarded message -----
> 
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
