From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v6 4/5] MCS Lock: Barrier corrections
Date: Fri, 22 Nov 2013 19:51:07 +0100
Message-ID: <20131122185107.GJ4971@laptop.programming.kicks-ass.net>
References: <20131120154643.GG19352@mudshark.cambridge.arm.com>
 <20131120171400.GI4138@linux.vnet.ibm.com>
 <20131121110308.GC10022@twins.programming.kicks-ass.net>
 <20131121125616.GI3694@twins.programming.kicks-ass.net>
 <20131121132041.GS4138@linux.vnet.ibm.com>
 <20131121172558.GA27927@linux.vnet.ibm.com>
 <20131121215249.GZ16796@laptop.programming.kicks-ass.net>
 <20131121221859.GH4138@linux.vnet.ibm.com>
 <20131122155835.GR3866@twins.programming.kicks-ass.net>
 <20131122182632.GW4138@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20131122182632.GW4138@linux.vnet.ibm.com>
Sender: owner-linux-mm@kvack.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Will Deacon <will.deacon@arm.com>, Tim Chen <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Waiman Long <waiman.long@hp.com>, Andrea Arcangeli <aarcange@redhat.com>, Alex Shi <alex.shi@linaro.org>, Andi Kleen <andi@firstfloor.org>, Michel Lespinasse <walken@google.com>, Davidlohr Bueso <davidlohr.bueso@hp.com>, Matthew R Wilcox <matthew.r.wilcox@intel.com>, Dave Hansen <dave.hansen@intel.com>, Rik van Riel <riel@redhat.com>, Peter Hurley <peter@hurleysoftware.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, George Spelvin <linux@horizon.com>, "H. Peter Anvin" <hpa@zyto>
List-Id: linux-arch.vger.kernel.org

On Fri, Nov 22, 2013 at 10:26:32AM -0800, Paul E. McKenney wrote:
> The real source of my cognitive pain is that here we have a sequence of
> code that has neither atomic instructions or memory-barrier instructions,
> but it looks like it still manages to act as a full memory barrier.
> Still not quite sure I should trust it...

Yes, this is something that puzzles me too.

That said, the two rules that:

1)  stores aren't re-ordered against other stores
2)  reads aren't re-ordered against other reads

Do make that:

	STORE x
	LOAD  x

form a fence that neither stores nor loads can pass through from
either side; note however that they themselves rely on the data
dependency to not reorder against themselves.

If you put them the other way around:

	LOAD x
	STORE y

we seem to get a stronger variant because stores are not re-ordered
against older reads.

There is however the exception cause for rule 1) above, which includes
clflush, non-temporal stores and string ops; the actual mfence
instruction doesn't seem to have this exception and would thus be
slightly stronger still.

Still confusion situation all round.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
