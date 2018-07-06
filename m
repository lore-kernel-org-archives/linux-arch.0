From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V2 11/19] csky: Atomic operations
Date: Fri, 6 Jul 2018 19:48:12 +0800
Message-ID: <20180706114812.GC27148@guoren>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <860b8db036b33d7b3648cb1f4ec827a53dc1a01b.1530465326.git.ren_guo@c-sky.com>
 <20180705180008.GG2530@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180705180008.GG2530@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, green.hu@gmail.com
List-Id: linux-arch.vger.kernel.org

On Thu, Jul 05, 2018 at 08:00:08PM +0200, Peter Zijlstra wrote:
> On Mon, Jul 02, 2018 at 01:30:14AM +0800, Guo Ren wrote:
> > +#ifdef CONFIG_CPU_HAS_LDSTEX
> > +ENTRY(csky_cmpxchg)
> > +	USPTOKSP
> > +	mfcr	a3, epc
> > +	INCTRAP	a3
> > +
> > +	subi    sp, 8
> > +	stw     a3, (sp, 0)
> > +	mfcr    a3, epsr
> > +	stw     a3, (sp, 4)
> > +
> > +	psrset	ee
> > +1:
> > +	ldex	a3, (a2)
> > +	cmpne	a0, a3
> > +	bt16	2f
> > +	mov	a3, a1
> > +	stex	a3, (a2)
> > +	bez	a3, 1b
> > +2:
> > +	sync.is
> > +	mvc	a0
> > +	ldw	a3, (sp, 0)
> > +	mtcr	a3, epc
> > +	ldw     a3, (sp, 4)
> > +	mtcr	a3, epsr
> > +	addi	sp, 8
> > +	KSPTOUSP
> > +	rte
> > +END(csky_cmpxchg)
> > +#else
> 
> Please explain... if the CPU has LDEX/STEX, then _why_ do you need this?
Our libc use csky_cmpxchg and we want it compatible. Of course, we'll
also implement the ldex/stex atomic operations in libs in future.

 Guo Ren
