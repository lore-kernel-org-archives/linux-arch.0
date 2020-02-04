Return-Path: <SRS0=47z6=3Y=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:43220 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbgBDR2W (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Feb 2020 12:28:22 -0500
Date: Tue, 4 Feb 2020 18:27:58 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v8 4/5] locking/qspinlock: Introduce starvation avoidance
 into CNA
Message-ID: <20200204172758.GF14879@hirez.programming.kicks-ass.net>
References: <8D3AFB47-B595-418C-9568-08780DDC58FF@oracle.com>
 <714892cd-d96f-4d41-ae8b-d7b7642a6e3c@redhat.com>
 <1669BFDE-A1A5-4ED8-B586-035460BBF68A@oracle.com>
 <20200125111931.GW11457@worktop.programming.kicks-ass.net>
 <F32558D8-4ACB-483A-AB4C-F565003A02E7@oracle.com>
 <20200203134540.GA14879@hirez.programming.kicks-ass.net>
 <6d11b22b-2fb5-7dea-f88b-b32f1576a5e0@redhat.com>
 <20200203152807.GK14914@hirez.programming.kicks-ass.net>
 <15fa978d-bd41-3ecb-83d5-896187e11244@redhat.com>
 <83762715-F68C-42DF-9B41-C4C48DF6762F@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <83762715-F68C-42DF-9B41-C4C48DF6762F@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex Kogan <alex.kogan@oracle.com>
Cc: Waiman Long <longman@redhat.com>, linux@armlinux.org.uk, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, hpa@zytor.com, x86@kernel.org, Hanjun Guo <guohanjun@huawei.com>, Jan Glauber <jglauber@marvell.com>, Steven Sistare <steven.sistare@oracle.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, dave.dice@oracle.com
Message-ID: <20200204172758.X02hZCjjFU0Uu1ibfP8yMBI7AzlVJ3E9NFBaa599fRw@z>

On Tue, Feb 04, 2020 at 11:54:02AM -0500, Alex Kogan wrote:
> > On Feb 3, 2020, at 10:47 AM, Waiman Long <longman@redhat.com> wrote:
> > 
> > On 2/3/20 10:28 AM, Peter Zijlstra wrote:
> >> On Mon, Feb 03, 2020 at 09:59:12AM -0500, Waiman Long wrote:
> >>> On 2/3/20 8:45 AM, Peter Zijlstra wrote:
> >>>> Presumably you have a workload where CNA is actually a win? That is,
> >>>> what inspired you to go down this road? Which actual kernel lock is so
> >>>> contended on NUMA machines that we need to do this?

> There are quite a few actually. files_struct.file_lock, file_lock_context.flc_lock
> and lockref.lock are some concrete examples that get very hot in will-it-scale
> benchmarks. 

Right, that's all a variant of banging on the same resources across
nodes. I'm not sure there's anything fundamental we can fix there.

> And then there are spinlocks in __futex_data.queues, 
> which get hot when applications have contended (pthread) locks — 
> LevelDB is an example.

A numa aware rework of futexes has been on the todo list for years :/

> Our initial motivation was based on an observation that kernel qspinlock is not 
> NUMA-aware. So what, you may ask. Much like people realized in the past that
> global spinning is bad for performance, and they switched from ticket lock to
> locks with local spinning (e.g., MCS), I think everyone would agree these days that
> bouncing a lock (and cache lines in general) across numa nodes is similarly bad.
> And as CNA demonstrates, we are easily leaving 2-3x speedups on the table by
> doing just that with the current qspinlock.

Actual benchmarks with performance numbers are required. It helps
motivate the patches as well as gives reviewers clues on how to
reproduce / inspect the claims made.
