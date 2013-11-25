From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v6 4/5] MCS Lock: Barrier corrections
Date: Mon, 25 Nov 2013 13:09:02 +0100
Message-ID: <20131125120902.GY10022@twins.programming.kicks-ass.net>
References: <CA+55aFz0nP1_O8jO2UkX1DmDzcBm53-fFejvz=oY=x3cGNBJSQ@mail.gmail.com>
 <20131122203738.GC4138@linux.vnet.ibm.com>
 <CA+55aFwHUuaGzW_=xEWNcyVnHT-zW8-bs6Xi=M458xM3Y1qE0w@mail.gmail.com>
 <20131122215208.GD4138@linux.vnet.ibm.com>
 <CA+55aFzS2yd-VbJB5t14mP8NZG8smB1BQaYCw3Zo19FWQL92vA@mail.gmail.com>
 <20131123002542.GF4138@linux.vnet.ibm.com>
 <CA+55aFy8kx1qaWszc9nrbUaqFu7GfTtDkpzPBeE2g2U6RZjYkA@mail.gmail.com>
 <20131123013654.GG4138@linux.vnet.ibm.com>
 <CA+55aFxQy8afgf6geqJOEHmsJ=ME-6CXrrPfj=aggH7u_jEEZA@mail.gmail.com>
 <CA+55aFzr7=N=_t03Luzxg2Ln9_h+M9Ud5spLi7FH+5j7ynkPUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFzr7=N=_t03Luzxg2Ln9_h+M9Ud5spLi7FH+5j7ynkPUg@mail.gmail.com>
Sender: owner-linux-mm@kvack.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@kernel.org>, Tim Chen <tim.c.chen@linux.intel.com>, Will Deacon <will.deacon@arm.com>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Waiman Long <waiman.long@hp.com>, Andrea Arcangeli <aarcange@redhat.com>, Alex Shi <alex.shi@linaro.org>, Andi Kleen <andi@firstfloor.org>, Michel Lespinasse <walken@google.com>, Davidlohr Bueso <davidlohr.bueso@hp.com>, Matthew R Wilcox <matthew.r.wilcox@intel.com>, Dave Hansen <dave.hansen@intel.com>, Rik van Riel <riel@redhat.com>, Peter Hurley <peter@hurleysoftware.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, George Spelvin <linux@horizon.com>
List-Id: linux-arch.vger.kernel.org

On Sat, Nov 23, 2013 at 12:39:53PM -0800, Linus Torvalds wrote:
> On Sat, Nov 23, 2013 at 12:21 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > And as far as I can tell, the above gives you: A < B < C < D < E < F <
> > A. Which doesn't look possible.
> 
> Hmm.. I guess technically all of those cases aren't "strictly
> precedes" as much as "cannot have happened in the opposite order". So
> the "<" might be "<=". Which I guess *is* possible: "it all happened
> at the same time". And then the difference between your suggested
> "lwsync" and "sync" in the unlock path on CPU0 basically approximating
> the difference between "A <= B" and "A < B"..
> 
> Ho humm.

But remember, there's an actual full proper barrier between E and F, so
at best you'd end up with something like:

  A <= B <= C <= D <= E < F <= A

Which is still an impossibility.

I'm hoping others will explain things, as I'm very much on shaky ground
myself wrt transitivity.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
