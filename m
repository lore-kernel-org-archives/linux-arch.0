From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: perf_mmap__write_tail() and control dependencies
Date: Fri, 24 Jul 2015 17:35:45 +0200
Message-ID: <20150724153545.GN18673@twins.programming.kicks-ass.net>
References: <20150724152905.GA4766@linux.vnet.ibm.com>
 <20150724153316.GL19282@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:51781 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752248AbbGXPfy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jul 2015 11:35:54 -0400
Content-Disposition: inline
In-Reply-To: <20150724153316.GL19282@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, paulus@samba.org, rostedt@goodmis.org

On Fri, Jul 24, 2015 at 05:33:16PM +0200, Peter Zijlstra wrote:
> On Fri, Jul 24, 2015 at 08:29:05AM -0700, Paul E. McKenney wrote:
> > Hello, Peter,
> > 
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

Furthremore, reading the buffer is a much less frequent occurrence than
writing entries to it. So its less performance critical.
