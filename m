From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v7 0/6] MCS Lock: MCS lock code cleanup and optimizations
Date: Mon, 20 Jan 2014 15:22:21 +0100
Message-ID: <20140120142221.GA12626@gmail.com>
References: <cover.1389890175.git.tim.c.chen@linux.intel.com>
 <1389917284.3138.10.camel@schen9-DESK>
 <20140120135847.GG31570@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20140120135847.GG31570@twins.programming.kicks-ass.net>
Sender: owner-linux-mm@kvack.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "Paul E.McKenney" <paulmck@linux.vnet.ibm.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Waiman Long <waiman.long@hp.com>, Andrea Arcangeli <aarcange@redhat.com>, Alex Shi <alex.shi@linaro.org>, Andi Kleen <andi@firstfloor.org>, Michel Lespinasse <walken@google.com>, Davidlohr Bueso <davidlohr.bueso@hp.com>, Matthew R Wilcox <matthew.r.wilcox@intel.com>, Dave Hansen <dave.hansen@intel.com>, Rik van Riel <riel@redhat.com>, Peter Hurley <peter@hurleysoftware.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, George Spelvin <linux@horizon.com>, "H. Peter Anvin" <hpa@zytor.com>, Arnd
List-Id: linux-arch.vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Jan 16, 2014 at 04:08:04PM -0800, Tim Chen wrote:
> > This is an update of the MCS lock patch series posted in November.
> 
> Aside from the smallish gripes I posted about;
> 
> Acked-by: Peter Zijlstra <peterz@infradead.org>

Okay - can apply them to the locking tree once those gripes (and any 
other review feedback) are fixed and if no-one is unhappy with the 
patches.

Thanks,

	Ingo

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
