From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 4/5] MCS Lock: Barrier corrections
Date: Thu, 21 Nov 2013 14:18:59 -0800
Message-ID: <20131121221859.GH4138@linux.vnet.ibm.com>
References: <cover.1384885312.git.tim.c.chen@linux.intel.com>
 <1384911463.11046.454.camel@schen9-DESK>
 <20131120153123.GF4138@linux.vnet.ibm.com>
 <20131120154643.GG19352@mudshark.cambridge.arm.com>
 <20131120171400.GI4138@linux.vnet.ibm.com>
 <20131121110308.GC10022@twins.programming.kicks-ass.net>
 <20131121125616.GI3694@twins.programming.kicks-ass.net>
 <20131121132041.GS4138@linux.vnet.ibm.com>
 <20131121172558.GA27927@linux.vnet.ibm.com>
 <20131121215249.GZ16796@laptop.programming.kicks-ass.net>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20131121215249.GZ16796@laptop.programming.kicks-ass.net>
Sender: owner-linux-mm@kvack.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>, Tim Chen <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Waiman Long <waiman.long@hp.com>, Andrea Arcangeli <aarcange@redhat.com>, Alex Shi <alex.shi@linaro.org>, Andi Kleen <andi@firstfloor.org>, Michel Lespinasse <walken@google.com>, Davidlohr Bueso <davidlohr.bueso@hp.com>, Matthew R Wilcox <matthew.r.wilcox@intel.com>, Dave Hansen <dave.hansen@intel.com>, Rik van Riel <riel@redhat.com>, Peter Hurley <peter@hurleysoftware.com>, Raghavendra
List-Id: linux-arch.vger.kernel.org

On Thu, Nov 21, 2013 at 10:52:49PM +0100, Peter Zijlstra wrote:
> On Thu, Nov 21, 2013 at 09:25:58AM -0800, Paul E. McKenney wrote:
> > I am still thinking not, at least for x86, given Section 8.2.2 of
> > "Intel=AE 64 and IA-32 Architectures Developer's Manual: Vol. 3A"
> > dated March 2013 from:
> >
> > http://www.intel.com/content/www/us/en/architecture-and-technology/64=
-ia-32-architectures-software-developer-vol-3a-part-1-manual.html
> >
> > Also from Sewell et al. "x86-TSO: A Rigorous and Usable Programmer's
> > Model for x86 Multiprocessors" in 2010 CACM.
>=20
> Should be this one:
>=20
>   http://www.cl.cam.ac.uk/~pes20/weakmemory/cacm.pdf
>=20
> And the rules referenced below are on page 5; left-hand column.

Yep, that is the one!  (I was relying on my ACM Digital Library
subscription.)

> > Let's apply the Intel manual to the earlier example:
> >
> >	CPU 0		CPU 1			CPU 2
> >	-----		-----			-----
> >	x =3D 1;		r1 =3D SLA(lock);		y =3D 1;
> >	SSR(lock, 1);	r2 =3D y;			smp_mb();
> >						r3 =3D x;
> >
> >	assert(!(r1 =3D=3D 1 && r2 =3D=3D 0 && r3 =3D=3D 0));
> >
> > Let's try applying this to x86:
> >
> > o	Stores from a given processor are ordered, so everyone
> >	agrees that CPU 0's store to x happens before the store-release
> >	to lock.
> >
> > o	Reads from a given processor are ordered, so everyone agrees
> >	that CPU 1's load from lock precedes its load from y.
> >
> > o	Because r1 =3D=3D 1, we know that CPU 0's store to lock happened
> >	before CPU 1's load from lock.
> >
> > o	Causality (AKA transitive visibility) means that everyone
> >	agrees that CPU 0's store to x happens before CPU 1's load
> >	from y.  (This is a crucial point, so it would be good to
> >	have confirmation/debunking from someone who understands
> >	the x86 architecture better than I do.)
> >
> > o	CPU 2's memory barrier prohibits CPU 2's store to y from
> >	being reordered with its load from x.
> >
> > o	Because r2 =3D=3D 0, we know that CPU 1's load from y happened
> >	before CPU 2's store to y.
> >
> > o	At this point, it looks to me that (r1 =3D=3D 1 && r2 =3D=3D 0)
> >	implies r3 =3D=3D 1.
> >
> > Sewell's model plays out as follows:
> >
> > o	Rule 2 never applies in this example because no processor
> >	is reading its own write.
> >
> > o	Rules 3 and 4 force CPU 0's writes to be seen in order.
> >
> > o	Rule 1 combined with the ordered-instruction nature of
> >	the model force CPU 1's reads to happen in order.
> >
> > o	Rule 4 means that if r1 =3D=3D 1, CPU 0's write to x is
> >	globally visible before CPU 1 loads from y.
> >
> > o	The fact that r2 =3D=3D 0 combined with rules 1, 3, and 4
> >	mean that CPU 1's load from y happens before CPU 2 makes
> >	its store to y visible.
> >
> > o	Rule 5 means that CPU 1 cannot execute its load from x
> >	until it has made its store to y globally visible.
> >
> > o	Therefore, when CPU 2 executes its load from x, CPU 0's
> >	store to x must be visible, ruling out r3 =3D=3D 0, and
> >	preventing the assertion from firing.
> >
> > The other three orderings would play out similarly.  (These are read
> > before lock release and read after subsequent lock acquisition, read
> > before lock release and write after subsequent lock acquisition, and
> > read before lock release and read after subsequent lock acquisition.)
> >
> > But before chasing those down, is the analysis above sound?
>=20
> I _think_ so.. but its late. I'm also struggling to find where lwsync
> goes bad in this story, because as you say lwsync does all except flush
> the store buffer, which sounds like TSO.. but clearly is not quite the
> same.
>=20
> For one TSO has multi-copy atomicity, whereas ARM/PPC do not have this.

At least PPC lwsync does not have multi-copy atomicity.  The heavier sync
instruction does.  Last I checked, ARM did not have a direct replacment
for lwsync, though it does have something sort of like eieio.

But yes, we were trying to use lwsync for both smp_load_acquire() and
smp_store_release(), which does not provide exactly the same guarantees
that TSO does.  Though it does come close in many cases.

> The explanation of lwsync given in 3.3 of 'A Tutorial Introduction to
> the ARM and POWER Relaxed Memory Models'
>=20
>   http://www.cl.cam.ac.uk/~pes20/ppc-supplemental/test7.pdf
>=20
> Leaves me slightly puzzled as to the exact differences between the 2 WW
> variants.

The WW at the top of the page is discussing the ARM "dmb" instruction
and the PPC "sync" instruction, both of which are full barriers, and
both of which can therefore be thought of as flushing the store buffer.

In contrast, the WW at the bottom of the page is discussing the PPC
lwsync instruction, which most definitely is not guaranteed to flush
the write buffer.

> Anyway, hopefully a little sleep will cure some of my confusion,
> otherwise I'll try and confuse you more tomorrow ;-)

Fair enough!  ;-)

							Thanx, Paul

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=3Dmailto:"dont@kvack.org"> email@kvack.org </a>
