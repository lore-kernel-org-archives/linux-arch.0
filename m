From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 4/5] MCS Lock: Barrier corrections
Date: Fri, 22 Nov 2013 12:37:38 -0800
Message-ID: <20131122203738.GC4138@linux.vnet.ibm.com>
References: <20131121225208.GJ4138@linux.vnet.ibm.com>
 <CA+55aFx3FSGAtdSTYmsZ8xtdpiSBM-XPSnxnMpRQY+S_v_72-g@mail.gmail.com>
 <20131122040856.GK4138@linux.vnet.ibm.com>
 <CA+55aFxSL96G_uuPSbJaXfGh7DpYZ1g0NcVfPKOFg1O0o0fyZg@mail.gmail.com>
 <20131122062314.GN4138@linux.vnet.ibm.com>
 <20131122151600.GA14988@gmail.com>
 <20131122184937.GX4138@linux.vnet.ibm.com>
 <CA+55aFyKKpf-i4pQ_dhy9gic74xtCbO+U8GXU6mCtQj1ZHy05A@mail.gmail.com>
 <20131122200620.GA4138@linux.vnet.ibm.com>
 <CA+55aFz0nP1_O8jO2UkX1DmDzcBm53-fFejvz=oY=x3cGNBJSQ@mail.gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFz0nP1_O8jO2UkX1DmDzcBm53-fFejvz=oY=x3cGNBJSQ@mail.gmail.com>
Sender: owner-linux-mm@kvack.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, Tim Chen <tim.c.chen@linux.intel.com>, Will Deacon <will.deacon@arm.com>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Waiman Long <waiman.long@hp.com>, Andrea Arcangeli <aarcange@redhat.com>, Alex Shi <alex.shi@linaro.org>, Andi Kleen <andi@firstfloor.org>, Michel Lespinasse <walken@google.com>, Davidlohr Bueso <davidlohr.bueso@hp.com>, Matthew R Wilcox <matthew.r.wilcox@intel.com>, Dave Hansen <dave.hansen@intel.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Rik van Riel <riel@redhat.com>, Peter Hurley <peter@h>
List-Id: linux-arch.vger.kernel.org

On Fri, Nov 22, 2013 at 12:09:31PM -0800, Linus Torvalds wrote:
> On Fri, Nov 22, 2013 at 12:06 PM, Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> >
> > I am sorry, but that is not always correct.  For example, in the contended
> > case for Tim Chen's MCS queued locks, the x86 acquisition-side handoff
> > code does -not- contain any stores or memory-barrier instructions.
> 
> So? In order to get *into* that contention code, you will have to go
> through the fast-case code. Which will contain a locked instruction.

So you must also maintain ordering against the critical section that just
ended on some other CPU.  And that just-ended critical section might
well have started -after- you passed through your own fast-case code.
In that case, the barriers in your fast-case code cannot possibly
help you.  Instead, ordering must be supplied by the code in the two
handoff code sequences.  And in the case of the most recent version of
Tim Chen's MCS lock on x86, the two handoff code sequences (release
and corresponding acquire) contain neither atomic instructions nor
memory-barrier instructions.

The weird thing is that it looks like those two handoff code sequences
nevertheless provide the unlock+lock guarantee on x86.  But I need to
look at it some more, and eventually run it by experts from Intel and
AMD.

							Thanx, Paul

> So I repeat: a "lock" sequence will always be a memory barrier on x86.
> 
>                    Linus
> 

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
