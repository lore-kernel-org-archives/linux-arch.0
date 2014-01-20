From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v7 6/6] MCS Lock: add Kconfig entries to allow
 arch-specific hooks
Date: Mon, 20 Jan 2014 13:35:16 +0100
Message-ID: <CAMuHMdXmTOAqpaCPY=TT=dD4JPJ2Sz094Yavvh8LqFXheX3UpA@mail.gmail.com>
References: <cover.1389890175.git.tim.c.chen@linux.intel.com>
	<1389917316.3138.16.camel@schen9-DESK>
	<20140120123030.GE31570@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20140120123030.GE31570@twins.programming.kicks-ass.net>
Sender: owner-linux-mm@kvack.org
To: Peter Zijlstra <peterz@infradead.org>, Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Tim Chen <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "Paul E.McKenney" <paulmck@linux.vnet.ibm.com>, Will Deacon <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Linux-Arch <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Waiman Long <waiman.long@hp.com>, Andrea Arcangeli <aarcange@redhat.com>, Alex Shi <alex.shi@linaro.org>, Andi Kleen <andi@firstfloor.org>, Michel Lespinasse <walken@google.com>, Davidlohr Bueso <davidlohr.bueso@hp.com>, Matthew R Wilcox <matthew.r.wilcox@intel.com>, Dave Hansen <dave.hansen@intel.com>, Rik van Riel <riel@redhat.com>, Peter Hurley <peter@hurleysoftware.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, George Spelvin <linux@horizon.>
List-Id: linux-arch.vger.kernel.org

On Mon, Jan 20, 2014 at 1:30 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> Then again, people seem to whinge if you don't keep these Kbuild files
> sorted, but manually sorting 29 files is just not something I like to
> do.

So you're offloading this to Stephen, who will see merge conflicts and will do
it anyway, delaying the next -next release by a few minutes?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
