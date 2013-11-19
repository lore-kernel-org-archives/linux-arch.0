From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 4/4] MCS Lock: Barrier corrections
Date: Tue, 19 Nov 2013 11:23:20 -0800
Message-ID: <20131119192319.GR4138@linux.vnet.ibm.com>
References: <cover.1383935697.git.tim.c.chen@linux.intel.com>
 <1383940358.11046.417.camel@schen9-DESK>
 <20131111181049.GL28302@mudshark.cambridge.arm.com>
 <20131111182059.GC21461@twins.programming.kicks-ass.net>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20131111182059.GC21461@twins.programming.kicks-ass.net>
Sender: owner-linux-mm@kvack.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>, Tim Chen <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Waiman Long <waiman.long@hp.com>, Andrea Arcangeli <aarcange@redhat.com>, Alex Shi <alex.shi@linaro.org>, Andi Kleen <andi@firstfloor.org>, Michel Lespinasse <walken@google.com>, Davidlohr Bueso <davidlohr.bueso@hp.com>, Matthew R Wilcox <matthew.r.wilcox@intel.com>, Dave Hansen <dave.hansen@intel.com>, Rik van Riel <riel@redhat.com>, Peter Hurley <peter@hurleysoftware.com>, Raghavendra
List-Id: linux-arch.vger.kernel.org

On Mon, Nov 11, 2013 at 07:20:59PM +0100, Peter Zijlstra wrote:
> On Mon, Nov 11, 2013 at 06:10:49PM +0000, Will Deacon wrote:
> > > +	/*
> > > +	 * Wait until the lock holder passes the lock down.
> > > +	 * Using smp_load_acquire() provides a memory barrier that
> > > +	 * ensures subsequent operations happen after the lock is acquired.
> > > +	 */
> > > +	while (!(smp_load_acquire(&node->locked)))
> > >  		arch_mutex_cpu_relax();
> 
> > Thinking more about that, the real issue here is that arch_mutex_cpu_relax()
> > doesn't have a corresponding hook on the unlock side. On ARM, for example,
> > we can enter a low-power state using the wfe instruction, but that requires
> > the unlocker to wake up the core when the lock is released.
> 
> That said, it would be ever so awesome if we could come to some sort of
> conclusion on control dependencies here.
> 
> I _know_ C/C++ doesn't do them, but at the end of the day the compiler
> still generates ASM and as long as we're relatively certain there's a
> loop there (there has to be, right? :-), we could maybe rely on it
> anyway.

I believe that we will be able to rely on control dependencies leading
to stores (not loads!), but even then they are not guaranteed to provide
transitivity.  This lack of transitivity sounds problematic for locking
primitives.

							Thanx, Paul

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
