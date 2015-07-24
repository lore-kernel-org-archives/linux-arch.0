From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: perf_mmap__write_tail() and control dependencies
Date: Fri, 24 Jul 2015 08:29:05 -0700
Message-ID: <20150724152905.GA4766@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:40396 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027AbbGXP3J (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jul 2015 11:29:09 -0400
Received: from /spool/local
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Fri, 24 Jul 2015 09:29:09 -0600
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: peterz@infradead.org
Cc: will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, paulus@samba.org, rostedt@goodmis.org

Hello, Peter,

The ring-buffer code uses control dependencies, and the shiny new
READ_ONCE_CTRL() is now in mainline.  I was idly curious about whether
the write side could use smp_store_release(), and I found this:

static inline void perf_mmap__write_tail(struct perf_mmap *md, u64 tail)
{
	struct perf_event_mmap_page *pc = md->base;

	/*
	 * ensure all reads are done before we write the tail out.
	 */
	mb();
	pc->data_tail = tail;
}

I see mb() rather than smp_mb().  Did I find the correct code for the
write side?  If so, why mb() rather than smp_mb()?  To serialize against
MMIO interactions with hardware counters or some such?

							Thanx, Paul
