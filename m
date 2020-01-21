Return-Path: <SRS0=zjVl=3K=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:50982 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728932AbgAUNuv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jan 2020 08:50:51 -0500
Date: Tue, 21 Jan 2020 14:50:34 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v8 4/5] locking/qspinlock: Introduce starvation avoidance
 into CNA
Message-ID: <20200121135034.GA14946@hirez.programming.kicks-ass.net>
References: <20191230194042.67789-1-alex.kogan@oracle.com>
 <20191230194042.67789-5-alex.kogan@oracle.com>
 <20200121132949.GL14914@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121132949.GL14914@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex Kogan <alex.kogan@oracle.com>
Cc: linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com, bristot@redhat.com
Message-ID: <20200121135034.vG4qcdtT5ROD-PrGuOP5AizlJWBvUnhl7_Dh842ZOvI@z>

On Tue, Jan 21, 2020 at 02:29:49PM +0100, Peter Zijlstra wrote:
> On Mon, Dec 30, 2019 at 02:40:41PM -0500, Alex Kogan wrote:
> 
> > +/*
> > + * Controls the threshold for the number of intra-node lock hand-offs before
> > + * the NUMA-aware variant of spinlock is forced to be passed to a thread on
> > + * another NUMA node. By default, the chosen value provides reasonable
> > + * long-term fairness without sacrificing performance compared to a lock
> > + * that does not have any fairness guarantees. The default setting can
> > + * be changed with the "numa_spinlock_threshold" boot option.
> > + */
> > +int intra_node_handoff_threshold __ro_after_init = 1 << 16;
> 
> There is a distinct lack of quantitative data to back up that
> 'reasonable' claim there.
> 
> Where is the table of inter-node latencies observed for the various
> values tested, and on what criteria is this number deemed reasonable?
> 
> To me, 64k lock hold times seems like a giant number, entirely outside
> of reasonable.

Daniel, IIRC you just did a paper on constructing worst case latencies
from measuring pieces. Do you have data on average lock hold times?
