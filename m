Return-Path: <SRS0=HZcf=3N=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:48224 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgAXPNt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jan 2020 10:13:49 -0500
Date: Fri, 24 Jan 2020 16:13:09 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v8 4/5] locking/qspinlock: Introduce starvation avoidance
 into CNA
Message-ID: <20200124151309.GE14879@hirez.programming.kicks-ass.net>
References: <20191230194042.67789-1-alex.kogan@oracle.com>
 <20191230194042.67789-5-alex.kogan@oracle.com>
 <20200121132949.GL14914@hirez.programming.kicks-ass.net>
 <cfdf635d-be2e-9d4b-c4ca-6bcbddc6868f@redhat.com>
 <3862F8A1-FF9B-40AD-A88E-2C0BA7AF6F58@oracle.com>
 <20200124075235.GX14914@hirez.programming.kicks-ass.net>
 <2c6741c5-d89d-4b2c-cebe-a7c7f6eed884@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c6741c5-d89d-4b2c-cebe-a7c7f6eed884@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, hpa@zytor.com, x86@kernel.org, Hanjun Guo <guohanjun@huawei.com>, Jan Glauber <jglauber@marvell.com>, Steven Sistare <steven.sistare@oracle.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, dave.dice@oracle.com
Message-ID: <20200124151309.yNa8xhfIBzzjq1MrL8z6cF83bg3nzNULnESjqY7t2Gs@z>

On Fri, Jan 24, 2020 at 09:42:42AM -0500, Waiman Long wrote:
> On 1/24/20 2:52 AM, Peter Zijlstra wrote:
> > On Thu, Jan 23, 2020 at 04:33:54PM -0500, Alex Kogan wrote:
> >> Let me put this question to you. What do you think the number should be?
> > I think it would be very good to keep the inter-node latency below 1ms.
> It is hard to guarantee that given that lock hold times can vary quite a
> lot depending on the workload. What we can control is just how many
> later lock waiters can jump ahead before a given waiter.

We're not into this for easy. And exactly because it depends on a lot we
need a lot of data.

Worst case lock acquisition times directly translate into worst case
IRQ-off latencies, and even the most die hard throughput oriented
workloads don't like to experience multiple ticks worth of irq-off
latencies.

> > But to realize that we need data on the lock hold times. Specifically
> > for the heavily contended locks that make CNA worth it in the first
> > place.
> >
> > I don't see that data, so I don't see how we can argue about this let
> > alone call something reasonable.
> >
> In essence, CNA lock is for improving throughput on NUMA machines at the
> expense of increasing worst case latency. If low latency is important,

Latency is _always_ important. Otherwise we'd never have put so much
time and effort into fair locks to begin with. Unbounded latency sucks
unconditionally.

> it should be disabled. If CONFIG_PREEMPT_RT is on,
> CONFIG_NUMA_AWARE_SPINLOCKS should be off.

You're spouting nonsense. You cannot claim any random number is
reasonable without argument.
