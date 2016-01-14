Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:60321 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755651AbcANWzf (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 14 Jan 2016 17:55:35 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Thu, 14 Jan 2016 15:55:35 -0700
Date: Thu, 14 Jan 2016 14:55:10 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [v3,11/41] mips: reuse asm-generic/barrier.h
Message-ID: <20160114225510.GJ3818@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20160112114111.GB15737@arm.com>
 <569565DA.2010903@imgtec.com>
 <20160113104516.GE25458@arm.com>
 <5696CF08.8080700@imgtec.com>
 <20160114121449.GC15828@arm.com>
 <5697F6D2.60409@imgtec.com>
 <20160114203430.GC3818@linux.vnet.ibm.com>
 <56980C91.1010403@imgtec.com>
 <20160114212913.GF3818@linux.vnet.ibm.com>
 <569814F2.50801@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <569814F2.50801@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc: Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Joe Perches <joe@perches.com>, David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net, adi-buildroot-devel@lists.sourceforge.net, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, xen-devel@lists.xenproject.org, Ralf Baechle <ralf@linux-mips.org>, Ingo Molnar <mingo@kernel.org>, ddaney.cavm@gmail.com, james.hogan@imgtec.com, Michael Ellerman <mpe@ellerman.id.au>
Message-ID: <20160114225510.OSMHizI0T_9NIaen0IBqG0iOuXwJdMaxT7L61dldhMI@z>

On Thu, Jan 14, 2016 at 01:36:50PM -0800, Leonid Yegoshin wrote:
> On 01/14/2016 01:29 PM, Paul E. McKenney wrote:
> >
> >>On 01/14/2016 12:34 PM, Paul E. McKenney wrote:
> >>>
> >>>The WRC+addr+addr is OK because data dependencies are not required to be
> >>>transitive, in other words, they are not required to flow from one CPU to
> >>>another without the help of an explicit memory barrier.
> >>I don't see any reliable way to fit WRC+addr+addr into "DATA
> >>DEPENDENCY BARRIERS" section recommendation to have data dependency
> >>barrier between read of a shared pointer/index and read the shared
> >>data based on that pointer. If you have this two reads, it doesn't
> >>matter the rest of scenario, you should put the dependency barrier
> >>in code anyway. If you don't do it in WRC+addr+addr scenario then
> >>after years it can be easily changed to different scenario which
> >>fits some of scenario in "DATA DEPENDENCY BARRIERS" section and
> >>fails.
> >The trick is that lockless_dereference() contains an
> >smp_read_barrier_depends():
> >
> >#define lockless_dereference(p) \
> >({ \
> >	typeof(p) _________p1 = READ_ONCE(p); \
> >	smp_read_barrier_depends(); /* Dependency order vs. p above. */ \
> >	(_________p1); \
> >})
> >
> >Or am I missing your point?
> 
> WRC+addr+addr has no any barrier. lockless_dereference() has a
> barrier. I don't see a common points between this and that in your
> answer, sorry.

Me, I am wondering what WRC+addr+addr has to do with anything at all.

<Going back through earlier email>

OK, so it looks like Will was asking not about WRC+addr+addr, but instead
about WRC+sync+addr.  This would drop an smp_mb() into cpu2() in my
earlier example, which needs to provide ordering.

I am guessing that the manual's "Older instructions which must be globally
performed when the SYNC instruction completes" provides the equivalent
of ARM/Power A-cumulativity, which can be thought of as transitivity
backwards in time.  This leads me to believe that your smp_mb() needs
to use SYNC rather than SYNC_MB, as was the subject of earlier spirited
discussion in this thread.

Suppose you have something like this:

	void cpu0(void)
	{
		WRITE_ONCE(a, 1);
		SYNC_MB();
		r0 = READ_ONCE(b);
	}

	void cpu1(void)
	{
		WRITE_ONCE(b, 1);
		SYNC_MB();
		r1 = READ_ONCE(c);
	}

	void cpu2(void)
	{
		WRITE_ONCE(c, 1);
		SYNC_MB();
		r2 = READ_ONCE(d);
	}

	void cpu3(void)
	{
		WRITE_ONCE(d, 1);
		SYNC_MB();
		r3 = READ_ONCE(a);
	}

Does your hardware guarantee that it is not possible for all of r0,
r1, r2, and r3 to be equal to zero at the end of the test, assuming
that a, b, c, and d are all initially zero, and the four functions
above run concurrently?  There are many similar litmus tests for other
combinations of reads and writes, but this is perhaps the nastiest from
a hardware viewpoint.  Does SYNC_MB() provide sufficient ordering for
this sort of situation?

Another (more academic) case is this one, with x and y initially zero:

	void cpu0(void)
	{
		WRITE_ONCE(x, 1);
	}

	void cpu1(void)
	{
		WRITE_ONCE(y, 1);
	}

	void cpu2(void)
	{
		r1 = READ_ONCE(x, 1);
		SYNC_MB();
		r2 = READ_ONCE(y, 1);
	}

	void cpu3(void)
	{
		r3 = READ_ONCE(y, 1);
		SYNC_MB();
		r4 = READ_ONCE(x, 1);
	}

Does SYNC_MB() prohibit r1 == 1 && r2 == 0 && r3 == 1 && r4 == 0?

Now, I don't know of any specific use cases for this pattern, but it
is greatly beloved of some of the old-school concurrency community,
so it is likely to crop up at some point, despite my best efforts.  :-/

							Thanx, Paul

