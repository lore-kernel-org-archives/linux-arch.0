Return-Path: <SRS0=zisY=3X=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:50404 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgBCP2u (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Feb 2020 10:28:50 -0500
Date: Mon, 3 Feb 2020 16:28:07 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v8 4/5] locking/qspinlock: Introduce starvation avoidance
 into CNA
Message-ID: <20200203152807.GK14914@hirez.programming.kicks-ass.net>
References: <20200124075235.GX14914@hirez.programming.kicks-ass.net>
 <2c6741c5-d89d-4b2c-cebe-a7c7f6eed884@redhat.com>
 <48ce49e5-98a7-23cd-09f4-8290a65abbb5@redhat.com>
 <8D3AFB47-B595-418C-9568-08780DDC58FF@oracle.com>
 <714892cd-d96f-4d41-ae8b-d7b7642a6e3c@redhat.com>
 <1669BFDE-A1A5-4ED8-B586-035460BBF68A@oracle.com>
 <20200125111931.GW11457@worktop.programming.kicks-ass.net>
 <F32558D8-4ACB-483A-AB4C-F565003A02E7@oracle.com>
 <20200203134540.GA14879@hirez.programming.kicks-ass.net>
 <6d11b22b-2fb5-7dea-f88b-b32f1576a5e0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d11b22b-2fb5-7dea-f88b-b32f1576a5e0@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, hpa@zytor.com, x86@kernel.org, Hanjun Guo <guohanjun@huawei.com>, Jan Glauber <jglauber@marvell.com>, Steven Sistare <steven.sistare@oracle.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, dave.dice@oracle.com
Message-ID: <20200203152807.S_wuDylCfVr1LRzv-YryyEadP-RFs7C5HH5zgzWoSTQ@z>

On Mon, Feb 03, 2020 at 09:59:12AM -0500, Waiman Long wrote:
> On 2/3/20 8:45 AM, Peter Zijlstra wrote:

> > Presumably you have a workload where CNA is actually a win? That is,
> > what inspired you to go down this road? Which actual kernel lock is so
> > contended on NUMA machines that we need to do this?
> 
> Today, a 2-socket Rome server can have 128 cores and 256 threads. If we
> scale up more, we could easily have more than 1000 threads in a system.
> With that many logical cpus available, it is easy to envision some heavy
> spinlock contention can happen fairly regularly. This patch can
> alleviate the congestion and improve performance under that
> circumstance. Of course, the specific locks that are contended will
> depend on the workloads.

Not the point. If there isn't an issue today, we don't have anything to
fix.

Furthermore, we've always adressed specific issues by looking at the
locking granularity, first.

So again, what specific lock inspired all these patches?
