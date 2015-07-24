From: Will Deacon <will.deacon@arm.com>
Subject: Re: perf_mmap__write_tail() and control dependencies
Date: Fri, 24 Jul 2015 16:36:20 +0100
Message-ID: <20150724153620.GF12569@arm.com>
References: <20150724152905.GA4766@linux.vnet.ibm.com>
 <20150724153316.GL19282@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:45547 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751904AbbGXPgU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 24 Jul 2015 11:36:20 -0400
Content-Disposition: inline
In-Reply-To: <20150724153316.GL19282@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "paulus@samba.org" <paulus@samba.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>

On Fri, Jul 24, 2015 at 04:33:16PM +0100, Peter Zijlstra wrote:
> On Fri, Jul 24, 2015 at 08:29:05AM -0700, Paul E. McKenney wrote:
> > The ring-buffer code uses control dependencies, and the shiny new
> > READ_ONCE_CTRL() is now in mainline.  I was idly curious about whether
> > the write side could use smp_store_release(), and I found this:
> > 
> > static inline void perf_mmap__write_tail(struct perf_mmap *md, u64 tail)
> > {
> > 	struct perf_event_mmap_page *pc = md->base;
> > 
> > 	/*
> > 	 * ensure all reads are done before we write the tail out.
> > 	 */
> > 	mb();
> > 	pc->data_tail = tail;
> > }
> > 
> > I see mb() rather than smp_mb().  Did I find the correct code for the
> > write side?  If so, why mb() rather than smp_mb()?  To serialize against
> > MMIO interactions with hardware counters or some such?
> 
> This is userspace, it doesn't patch itself depending on if its run on an
> SMP machine or not.

Yup, and that's why mb() expands to dmb instead of dsb in
tools/arch/arm64/include/asm/barrier.h (I see there's an XXX: comment
there asking about the difference).

Will
