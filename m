From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v8 4/6] MCS Lock: Move mcs_lock/unlock function into its
 own
Date: Wed, 22 Jan 2014 14:06:19 +0100
Message-ID: <20140122130619.GA9429@gmail.com>
References: <cover.1390239879.git.tim.c.chen@linux.intel.com>
 <1390267471.3138.38.camel@schen9-DESK>
 <20140121101915.GS31570@twins.programming.kicks-ass.net>
 <20140121104140.GA4092@gmail.com>
 <1390330623.3138.56.camel@schen9-DESK>
 <20140121190658.GA5862@gmail.com>
 <1390331671.3138.58.camel@schen9-DESK>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <1390331671.3138.58.camel@schen9-DESK>
Sender: owner-linux-mm@kvack.org
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "Paul E.McKenney" <paulmck@linux.vnet.ibm.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Waiman Long <waiman.long@hp.com>, Andrea Arcangeli <aarcange@redhat.com>, Alex Shi <alex.shi@linaro.org>, Andi Kleen <andi@firstfloor.org>, Michel Lespinasse <walken@google.com>, Davidlohr Bueso <davidlohr.bueso@hp.com>, Matthew R Wilcox <matthew.r.wilcox@intel.com>, Dave Hansen <dave.hansen@intel.com>, Rik van Riel <riel@redhat.com>, Peter Hurley <peter@hurleysoftware.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, George Spelvin <linux@horizon.com>, "H. Peter Anvin" <hpa@zytor.com>, Arnd
List-Id: linux-arch.vger.kernel.org


* Tim Chen <tim.c.chen@linux.intel.com> wrote:

> > > For the time being, I'll just remove the EXPORT.  If people feel 
> > > that inline is the right way to go, then we'll leave the 
> > > function in mcs_spin_lock.h and not create mcs_spin_lock.c.
> > 
> > Well, 'people' could be you, the person touching the code? This is 
> > really something that is discoverable: look at the critical path 
> > in the inlined and the out of line case, and compare the number of 
> > instructions. This can be done based on disassembly of the 
> > affected code.
> 
> Okay, will make it inline function and drop the move of to 
> mcs_spin_lock.c

Only if I'm right! I was speculating.

Thanks,

	Ingo

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
