From: Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH v2 4/4] MCS Lock: Make mcs_spinlock.h includable in
 other files
Date: Tue, 05 Nov 2013 11:30:42 -0800
Message-ID: <1383679842.11046.298.camel@schen9-DESK>
References: <cover.1383670202.git.tim.c.chen@linux.intel.com>
	 <1383673359.11046.280.camel@schen9-DESK>
	 <20131105185717.GZ16117@laptop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20131105185717.GZ16117@laptop.programming.kicks-ass.net>
Sender: owner-linux-mm@kvack.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Waiman Long <waiman.long@hp.com>, Andrea Arcangeli <aarcange@redhat.com>, Alex Shi <alex.shi@linaro.org>, Andi Kleen <andi@firstfloor.org>, Michel Lespinasse <walken@google.com>, Davidlohr Bueso <davidlohr.bueso@hp.com>, Matthew R Wilcox <matthew.r.wilcox@intel.com>, Dave Hansen <dave.hansen@intel.com>, Rik van Riel <riel@redhat.com>, Peter Hurley <peter@hurleysoftware.com>, "Paul
 E.McKenney" <paulmck@linux.vnet.ibm.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, George Spelvin <linux@horizon.com>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Aswin Chandramouleeswaran <aswin@hp.com>, Scott
List-Id: linux-arch.vger.kernel.org

On Tue, 2013-11-05 at 19:57 +0100, Peter Zijlstra wrote:
> On Tue, Nov 05, 2013 at 09:42:39AM -0800, Tim Chen wrote:
> > + * The _raw_mcs_spin_lock() function should not be called directly. Instead,
> > + * users should call mcs_spin_lock().
> >   */
> > -static noinline
> > -void mcs_spin_lock(struct mcs_spinlock **lock, struct mcs_spinlock *node)
> > +static inline
> > +void _raw_mcs_spin_lock(struct mcs_spinlock **lock, struct mcs_spinlock *node)
> >  {
> >  	struct mcs_spinlock *prev;
> >  
> 
> So why keep it in the header at all?

I also made the suggestion originally of keeping both lock and unlock in
mcs_spinlock.c.  Wonder if Waiman decides to keep them in header 
because in-lining the unlock function makes execution a bit faster?

Tim

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
