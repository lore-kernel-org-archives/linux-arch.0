Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:43836 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753672AbeGFMFo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Jul 2018 08:05:44 -0400
Date: Fri, 6 Jul 2018 14:05:32 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH V2 11/19] csky: Atomic operations
Message-ID: <20180706120532.GX2476@hirez.programming.kicks-ass.net>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <860b8db036b33d7b3648cb1f4ec827a53dc1a01b.1530465326.git.ren_guo@c-sky.com>
 <20180705180008.GG2530@hirez.programming.kicks-ass.net>
 <20180706114812.GC27148@guoren>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706114812.GC27148@guoren>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <ren_guo@c-sky.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, green.hu@gmail.com
Message-ID: <20180706120532.p_wH5CpRAtP91kkcCTUvsnaTJcn4u0-oBMD9uvjj4lY@z>

On Fri, Jul 06, 2018 at 07:48:12PM +0800, Guo Ren wrote:
> On Thu, Jul 05, 2018 at 08:00:08PM +0200, Peter Zijlstra wrote:
> > On Mon, Jul 02, 2018 at 01:30:14AM +0800, Guo Ren wrote:
> > > +#ifdef CONFIG_CPU_HAS_LDSTEX
> > > +ENTRY(csky_cmpxchg)
> > > +	USPTOKSP
> > > +	mfcr	a3, epc
> > > +	INCTRAP	a3
> > > +
> > > +	subi    sp, 8
> > > +	stw     a3, (sp, 0)
> > > +	mfcr    a3, epsr
> > > +	stw     a3, (sp, 4)
> > > +
> > > +	psrset	ee
> > > +1:
> > > +	ldex	a3, (a2)
> > > +	cmpne	a0, a3
> > > +	bt16	2f
> > > +	mov	a3, a1
> > > +	stex	a3, (a2)
> > > +	bez	a3, 1b
> > > +2:
> > > +	sync.is
> > > +	mvc	a0
> > > +	ldw	a3, (sp, 0)
> > > +	mtcr	a3, epc
> > > +	ldw     a3, (sp, 4)
> > > +	mtcr	a3, epsr
> > > +	addi	sp, 8
> > > +	KSPTOUSP
> > > +	rte
> > > +END(csky_cmpxchg)
> > > +#else
> > 
> > Please explain... if the CPU has LDEX/STEX, then _why_ do you need this?
> Our libc use csky_cmpxchg and we want it compatible. Of course, we'll
> also implement the ldex/stex atomic operations in libs in future.

I would strongly suggest not providing this syscall on SMP systems from
the get go. There is no point in starting with legacy problems without
an actual legacy.
