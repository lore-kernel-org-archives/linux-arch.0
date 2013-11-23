From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 4/5] MCS Lock: Barrier corrections
Date: Sat, 23 Nov 2013 09:06:03 -0800
Message-ID: <20131123170603.GL4138@linux.vnet.ibm.com>
References: <20131122203738.GC4138@linux.vnet.ibm.com>
 <CA+55aFwHUuaGzW_=xEWNcyVnHT-zW8-bs6Xi=M458xM3Y1qE0w@mail.gmail.com>
 <20131122215208.GD4138@linux.vnet.ibm.com>
 <CA+55aFzS2yd-VbJB5t14mP8NZG8smB1BQaYCw3Zo19FWQL92vA@mail.gmail.com>
 <20131123002542.GF4138@linux.vnet.ibm.com>
 <CA+55aFy8kx1qaWszc9nrbUaqFu7GfTtDkpzPBeE2g2U6RZjYkA@mail.gmail.com>
 <20131123013654.GG4138@linux.vnet.ibm.com>
 <CA+55aFyJRAX4e9H0AFGcPMrBBTmGC6K_iCCS3dc7Mx6ejTmYMA@mail.gmail.com>
 <20131123040507.GI4138@linux.vnet.ibm.com>
 <20131123112450.GA26801@gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20131123112450.GA26801@gmail.com>
Sender: owner-linux-mm@kvack.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Tim Chen <tim.c.chen@linux.intel.com>, Will Deacon <will.deacon@arm.com>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Waiman Long <waiman.long@hp.com>, Andrea Arcangeli <aarcange@redhat.com>, Alex Shi <alex.shi@linaro.org>, Andi Kleen <andi@firstfloor.org>, Michel Lespinasse <walken@google.com>, Davidlohr Bueso <davidlohr.bueso@hp.com>, Matthew R Wilcox <matthew.r.wilcox@intel.com>, Dave Hansen <dave.hansen@intel.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Rik van Riel <riel@redhat.com>
List-Id: linux-arch.vger.kernel.org

On Sat, Nov 23, 2013 at 12:24:50PM +0100, Ingo Molnar wrote:
> 
> * Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:
> 
> > > x86 does have that extra "Memory ordering obeys causality (memory 
> > > ordering respects transitive visibility)." rule, and the example 
> > > in the architecture manual (section 8.2.3.6 "Stores Are 
> > > Transitively Visible") seems to very much about this, but your 
> > > particular example is subtly different, so..
> > 
> > Indeed, my example needs CPU 1's -load- from y to be transitively 
> > visible, so I am nervous about this one as well.
> > 
> > > I will have to ruminate on this.
> > 
> > The rules on the left-hand column of page 5 of the below URL apply 
> > to this example more straightforwardly, but I don't know that Intel 
> > and AMD stand behind them:
> > 
> > 	http://www.cl.cam.ac.uk/~pes20/weakmemory/cacm.pdf
> > 
> > My guess is that x86 does guarantee this ordering, but at this point 
> > I would have to ask someone from Intel and AMD.
> 
> An additional option might be to create a user-space testcase 
> engineered to hit all the exotic ordering situations, one that might 
> disprove any particular assumptions we have about the behavior of 
> hardware. (Back a decade ago when the x86 space first introduced quad 
> core CPUs with newfangled on-die cache coherency I managed to 
> demonstrate a causality violation by simulating kernel locks in 
> user-space, which turned out to be a hardware bug. Also, when 
> Hyperthreading/SMT was new it demonstrated many interesting bugs never 
> seen in practice before. So running stuff on real hardware is useful.)
> 
> And a cache coherency (and/or locking) test suite would be very useful 
> anyway, for so many other purposes as well: such as a new platform/CPU 
> bootstrap, or to prove the correctness of some fancy new locking 
> scheme people want to add. Maybe as an extension to rcutorture, or a 
> generalization of it?

I have the locking counterpart of rcutorture on my todo list.  ;-)

Of course, we cannot prove locks correct via testing, but a quick test
can often find a bug faster and more reliably than manual inspection.

							Thanx, Paul

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
