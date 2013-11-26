From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 4/5] MCS Lock: Barrier corrections
Date: Mon, 25 Nov 2013 19:16:26 -0800
Message-ID: <20131126031626.GE4138@linux.vnet.ibm.com>
References: <20131121132041.GS4138@linux.vnet.ibm.com>
 <20131121172558.GA27927@linux.vnet.ibm.com>
 <20131121215249.GZ16796@laptop.programming.kicks-ass.net>
 <20131121221859.GH4138@linux.vnet.ibm.com>
 <20131122155835.GR3866@twins.programming.kicks-ass.net>
 <20131122182632.GW4138@linux.vnet.ibm.com>
 <20131122185107.GJ4971@laptop.programming.kicks-ass.net>
 <20131125173540.GK3694@twins.programming.kicks-ass.net>
 <20131125180250.GR4138@linux.vnet.ibm.com>
 <5293E37F.5020908@zytor.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <5293E37F.5020908@zytor.com>
Sender: owner-linux-mm@kvack.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>, Tim Chen <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Waiman Long <waiman.long@hp.com>, Andrea Arcangeli <aarcange@redhat.com>, Alex Shi <alex.shi@linaro.org>, Andi Kleen <andi@firstfloor.org>, Michel Lespinasse <walken@google.com>, Davidlohr Bueso <davidlohr.bueso@hp.com>, Matthew R Wilcox <matthew.r.wilcox@intel.com>, Dave Hansen <dave.hansen@intel.com>, Rik van Riel <riel@redhat.com>Peter Hurley <p>
List-Id: linux-arch.vger.kernel.org

On Mon, Nov 25, 2013 at 03:55:43PM -0800, H. Peter Anvin wrote:
> On 11/25/2013 10:02 AM, Paul E. McKenney wrote:
> >=20
> > I still do not believe that it does.  Again, strangely enough.
> >=20
> > We need to ask someone in Intel that understands this all the way dow=
n
> > to the silicon.  The guy I used to rely on for this no longer works
> > at Intel.
> >=20
> > Do you know someone who fits this description, or should I start send=
ing
> > cold-call emails to various Intel contacts?
>=20
> Feel free to poke me if you need any help.

My biggest question is the definition of "Memory ordering obeys causality
(memory ordering respects transitive visibility)" in Section 3.2.2 of
the "Intel=AE 64 and IA-32 Architectures Developer's Manual: Vol. 3A"
dated March 2013 from:

http://www.intel.com/content/www/us/en/architecture-and-technology/64-ia-=
32-architectures-software-developer-vol-3a-part-1-manual.html

I am guessing that is orders loads as well as stores, so that a load
is said to be "visible" to some other CPU once that CPU no longer has
the opportunity to affect the return value from the load.  Is that a
reasonable interpretation?

More generally, is the model put forward by Sewell et al. in "x86-TSO:
A Rigorous and Usable Programmer's Model for x86 Multiprocessors"
accurate?  This is on pages 4 and 5 here:

	http://www.cl.cam.ac.uk/~pes20/weakmemory/cacm.pdf

							Thanx, Paul

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=3Dmailto:"dont@kvack.org"> email@kvack.org </a>
