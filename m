From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: perf_mmap__write_tail() and control dependencies
Date: Fri, 24 Jul 2015 08:49:12 -0700
Message-ID: <20150724154912.GL3717@linux.vnet.ibm.com>
References: <20150724152905.GA4766@linux.vnet.ibm.com>
 <20150724153316.GL19282@twins.programming.kicks-ass.net>
 <20150724153620.GF12569@arm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:34832 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750975AbbGXPtR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jul 2015 11:49:17 -0400
Received: from /spool/local
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Fri, 24 Jul 2015 09:49:17 -0600
Content-Disposition: inline
In-Reply-To: <20150724153620.GF12569@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "paulus@samba.org" <paulus@samba.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>

On Fri, Jul 24, 2015 at 04:36:20PM +0100, Will Deacon wrote:
> On Fri, Jul 24, 2015 at 04:33:16PM +0100, Peter Zijlstra wrote:
> > On Fri, Jul 24, 2015 at 08:29:05AM -0700, Paul E. McKenney wrote:
> > > The ring-buffer code uses control dependencies, and the shiny new
> > > READ_ONCE_CTRL() is now in mainline.  I was idly curious about whether
> > > the write side could use smp_store_release(), and I found this:
> > > 
> > > static inline void perf_mmap__write_tail(struct perf_mmap *md, u64 tail)
> > > {
> > > 	struct perf_event_mmap_page *pc = md->base;
> > > 
> > > 	/*
> > > 	 * ensure all reads are done before we write the tail out.
> > > 	 */
> > > 	mb();
> > > 	pc->data_tail = tail;
> > > }
> > > 
> > > I see mb() rather than smp_mb().  Did I find the correct code for the
> > > write side?  If so, why mb() rather than smp_mb()?  To serialize against
> > > MMIO interactions with hardware counters or some such?
> > 
> > This is userspace, it doesn't patch itself depending on if its run on an
> > SMP machine or not.
> 
> Yup, and that's why mb() expands to dmb instead of dsb in
> tools/arch/arm64/include/asm/barrier.h (I see there's an XXX: comment
> there asking about the difference).

Thank you both!  I will therefore refrain from attempting to restrict
READ_ONCE_CTRL() to pairing with smp_store_release().  ;-)

							Thanx, Paul
