From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 4/5] MCS Lock: Barrier corrections
Date: Thu, 21 Nov 2013 09:25:58 -0800
Message-ID: <20131121172558.GA27927@linux.vnet.ibm.com>
References: <cover.1384885312.git.tim.c.chen@linux.intel.com>
 <1384911463.11046.454.camel@schen9-DESK>
 <20131120153123.GF4138@linux.vnet.ibm.com>
 <20131120154643.GG19352@mudshark.cambridge.arm.com>
 <20131120171400.GI4138@linux.vnet.ibm.com>
 <20131121110308.GC10022@twins.programming.kicks-ass.net>
 <20131121125616.GI3694@twins.programming.kicks-ass.net>
 <20131121132041.GS4138@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20131121132041.GS4138@linux.vnet.ibm.com>
Sender: owner-linux-mm@kvack.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>, Tim Chen <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Waiman Long <waiman.long@hp.com>, Andrea Arcangeli <aarcange@redhat.com>, Alex Shi <alex.shi@linaro.org>, Andi Kleen <andi@firstfloor.org>, Michel Lespinasse <walken@google.com>, Davidlohr Bueso <davidlohr.bueso@hp.com>, Matthew R Wilcox <matthew.r.wilcox@intel.com>, Dave Hansen <dave.hansen@intel.com>, Rik van Riel <riel@redhat.com>, Peter Hurley <peter@hurleysoftware.com>, Raghavendra
List-Id: linux-arch.vger.kernel.org

On Thu, Nov 21, 2013 at 05:20:41AM -0800, Paul E. McKenney wrote:
> On Thu, Nov 21, 2013 at 01:56:16PM +0100, Peter Zijlstra wrote:
> > On Thu, Nov 21, 2013 at 12:03:08PM +0100, Peter Zijlstra wrote:
> > > On Wed, Nov 20, 2013 at 09:14:00AM -0800, Paul E. McKenney wrote:
> > > > > Hmm, so in the following case:
> > > > >=20
> > > > >   Access A
> > > > >   unlock()	/* release semantics */
> > > > >   lock()	/* acquire semantics */
> > > > >   Access B
> > > > >=20
> > > > > A cannot pass beyond the unlock() and B cannot pass the before =
the lock().
> > > > >=20
> > > > > I agree that accesses between the unlock and the lock can be mo=
ve across both
> > > > > A and B, but that doesn't seem to matter by my reading of the a=
bove.
> > > > >=20
> > > > > What is the problematic scenario you have in mind? Are you thin=
king of the
> > > > > lock() moving before the unlock()? That's only permitted by RCp=
c afaiu,
> > > > > which I don't think any architectures supported by Linux implem=
ent...
> > > > > (ARMv8 acquire/release is RCsc).
> > > >=20
> > > > If smp_load_acquire() and smp_store_release() are both implemente=
d using
> > > > lwsync on powerpc, and if Access A is a store and Access B is a l=
oad,
> > > > then Access A and Access B can be reordered.
> > > >=20
> > > > Of course, if every other architecture will be providing RCsc imp=
lementations
> > > > for smp_load_acquire() and smp_store_release(), which would not b=
e a bad
> > > > thing, then another approach is for powerpc to use sync rather th=
an lwsync
> > > > for one or the other of smp_load_acquire() or smp_store_release()=
.
> > >=20
> > > So which of the two would make most sense?
> > >=20
> > > As per the Document, loads/stores should not be able to pass up thr=
ough
> > > an ACQUIRE and loads/stores should not be able to pass down through=
 a
> > > RELEASE.
> > >=20
> > > I think PPC would match that if we use sync for smp_store_release()=
 such
> > > that it will flush the store buffer, and thereby guarantee all stor=
es
> > > are kept within the required section.
> >=20
> > Wouldn't that also mean that TSO archs need the full barrier on
> > RELEASE?
>=20
> It just might...  I was thinking not, but I do need to check.

I am still thinking not, at least for x86, given Section 8.2.2 of
"Intel=AE 64 and IA-32 Architectures Developer's Manual: Vol. 3A"
dated March 2013 from:

http://www.intel.com/content/www/us/en/architecture-and-technology/64-ia-=
32-architectures-software-developer-vol-3a-part-1-manual.html

Also from Sewell et al. "x86-TSO: A Rigorous and Usable Programmer's
Model for x86 Multiprocessors" in 2010 CACM.

Let's apply the Intel manual to the earlier example:

	CPU 0		CPU 1			CPU 2
	-----		-----			-----
	x =3D 1;		r1 =3D SLA(lock);		y =3D 1;
	SSR(lock, 1);	r2 =3D y;			smp_mb();
						r3 =3D x;

	assert(!(r1 =3D=3D 1 && r2 =3D=3D 0 && r3 =3D=3D 0));

Let's try applying this to x86:

o	Stores from a given processor are ordered, so everyone
	agrees that CPU 0's store to x happens before the store-release
	to lock.

o	Reads from a given processor are ordered, so everyone agrees
	that CPU 1's load from lock precedes its load from y.

o	Because r1 =3D=3D 1, we know that CPU 0's store to lock happened
	before CPU 1's load from lock.

o	Causality (AKA transitive visibility) means that everyone
	agrees that CPU 0's store to x happens before CPU 1's load
	from y.  (This is a crucial point, so it would be good to
	have confirmation/debunking from someone who understands
	the x86 architecture better than I do.)

o	CPU 2's memory barrier prohibits CPU 2's store to y from
	being reordered with its load from x.

o	Because r2 =3D=3D 0, we know that CPU 1's load from y happened
	before CPU 2's store to y.

o	At this point, it looks to me that (r1 =3D=3D 1 && r2 =3D=3D 0)
	implies r3 =3D=3D 1.

Sewell's model plays out as follows:

o	Rule 2 never applies in this example because no processor
	is reading its own write.

o	Rules 3 and 4 force CPU 0's writes to be seen in order.

o	Rule 1 combined with the ordered-instruction nature of
	the model force CPU 1's reads to happen in order.

o	Rule 4 means that if r1 =3D=3D 1, CPU 0's write to x is
	globally visible before CPU 1 loads from y.

o	The fact that r2 =3D=3D 0 combined with rules 1, 3, and 4
	mean that CPU 1's load from y happens before CPU 2 makes
	its store to y visible.

o	Rule 5 means that CPU 1 cannot execute its load from x
	until it has made its store to y globally visible.

o	Therefore, when CPU 2 executes its load from x, CPU 0's
	store to x must be visible, ruling out r3 =3D=3D 0, and
	preventing the assertion from firing.

The other three orderings would play out similarly.  (These are read
before lock release and read after subsequent lock acquisition, read
before lock release and write after subsequent lock acquisition, and
read before lock release and read after subsequent lock acquisition.)

But before chasing those down, is the analysis above sound?

							Thanx, Paul

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=3Dmailto:"dont@kvack.org"> email@kvack.org </a>
