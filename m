From: Paul Mackerras <paulus@samba.org>
Subject: Re: [patch 0/3] [Announcement] Performance Counters for Linux
Date: Fri, 5 Dec 2008 11:22:11 +1100
Message-ID: <18744.29747.728320.652642@cargo.ozlabs.ibm.com>
References: <20081204225345.654705757@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:51427 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751697AbYLEAdr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 4 Dec 2008 19:33:47 -0500
In-Reply-To: <20081204225345.654705757@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Stephane Eranian <eranian@googlemail.com>, Eric Dumazet <dada1@cosmosbay.com>, Robert Richter <robert.richter@amd.com>, Arjan van de Veen <arjan@infradead.org>, Peter Anvin <hpa@zytor.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>, David Miller <davem@davemloft.net>

Thomas Gleixner writes:

> We'd like to announce a brand new implementation of performance counter
> support for Linux. It is a very simple and extensible design that has the
> potential to implement the full range of features we would expect from such
> a subsystem.

Looks like the sort of thing I was thinking about a year or so ago
when I was trying to come up with a simpler API than perfmon2.
However, it turned out that my design, and I believe yours too, can't
do some things that users really want to do with performance
counters.

One thing that this sort of thing can't do is to get values from
multiple counters that correlate with each other.  For instance, we
would often want to count, say, L2 cache misses and instructions
completed at the same time, and be able to read both counters at very
close to the same time, so that we can measure average L2 cache misses
per instruction completed, which is useful.

Another problem is that this abstraction provides no way to deal with
interrelationships between counters.  For example, on PowerPC it is
common to have a facility where one counter overflowing can cause all
the other counters to freeze.  I don't see this abstraction providing
any way to handle that.

It looks to me that your new API will be unworkable for real
performance measurement and tuning, just like mine ended up being. :)

Paul.
