From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V2 11/19] csky: Atomic operations
Date: Sat, 7 Jul 2018 15:42:10 +0800
Message-ID: <20180707074209.GA32147@guoren>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <860b8db036b33d7b3648cb1f4ec827a53dc1a01b.1530465326.git.ren_guo@c-sky.com>
 <20180705175059.GE2530@hirez.programming.kicks-ass.net>
 <20180706110129.GC8707@guoren>
 <20180706115614.GV2476@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180706115614.GV2476@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, green.hu@gmail.com, Will Deacon <will.deacon@arm.com>
List-Id: linux-arch.vger.kernel.org

On Fri, Jul 06, 2018 at 01:56:14PM +0200, Peter Zijlstra wrote:
> That's how LL/SC works. What I was asking is if they have any effect on
> memory ordering. Some architectures have LL/SC imply memory ordering,
> most do not.
> 
> Going by your spinlock implementation they don't imply any memory
> ordering.
ldex/stex don't imply any memory ordering.

> 
> > > The mandated semantics for xchg() / cmpxchg() is an effective smp_mb()
> > > before _and_ after.
> > 
> > 	switch (size) {						\
> > 	case 4:							\
> > 		smp_mb();					\
> > 		asm volatile (					\
> > 		"1:	ldex.w		%0, (%3) \n"		\
> > 		"	mov		%1, %2   \n"		\
> > 		"	stex.w		%1, (%3) \n"		\
> > 		"	bez		%1, 1b   \n"		\
> > 			: "=&r" (__ret), "=&r" (tmp)		\
> > 			: "r" (__new), "r"(__ptr)		\
> > 			: "memory");				\
> > 		smp_mb();					\
> > 		break;						\
> > Hmm?
> > But I couldn't undertand what's wrong without the 1th smp_mb()?
> > 1th smp_mb will make all ld/st finish before ldex.w. Is it necessary?
> 
> Yes.
> 
> 	CPU0			CPU1
> 
> 	r1 = READ_ONCE(x);	WRITE_ONCE(y, 1);
> 	r2 = xchg(&y, 2);	smp_store_release(&x, 1);
> 
> must not allow: r1==1 && r2==0
CPU1 smp_store_release could be finished before WRITE_ONCE, so r1=1 &&
r2=0?
 
> > > The above implementation suggests LDEX implies a SYNC.IS, is this
> > > correct?
> > No, ldex doesn't imply a sync.is.
> 
> Right, as per the spinlock emails, then your proposed primitives are
> incorrect.
Yes, approve.

 Guo Ren
