Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:33324 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732614AbfGPP66 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Jul 2019 11:58:58 -0400
Date: Tue, 16 Jul 2019 17:58:39 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 2/5] locking/qspinlock: Refactor the qspinlock slow
 path
Message-ID: <20190716155839.GF3402@hirez.programming.kicks-ass.net>
References: <20190715192536.104548-1-alex.kogan@oracle.com>
 <20190715192536.104548-3-alex.kogan@oracle.com>
 <20190716102034.GN3419@hirez.programming.kicks-ass.net>
 <9D5B6F33-6003-4CCA-BBE5-998B5A679B9C@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9D5B6F33-6003-4CCA-BBE5-998B5A679B9C@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex Kogan <alex.kogan@oracle.com>
Cc: linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
Message-ID: <20190716155839.w1FWEu2nHfIXvDeh1BLXt2xpELWcvA9SRXQwVACNR6Q@z>

On Tue, Jul 16, 2019 at 10:53:02AM -0400, Alex Kogan wrote:
> On Jul 16, 2019, at 6:20 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > On Mon, Jul 15, 2019 at 03:25:33PM -0400, Alex Kogan wrote:
> > 
> >> +/*
> >> + * set_locked_empty_mcs - Try to set the spinlock value to _Q_LOCKED_VAL,
> >> + * and by doing that unlock the MCS lock when its waiting queue is empty
> >> + * @lock: Pointer to queued spinlock structure
> >> + * @val: Current value of the lock
> >> + * @node: Pointer to the MCS node of the lock holder
> >> + *
> >> + * *,*,* -> 0,0,1
> >> + */
> >> +static __always_inline bool __set_locked_empty_mcs(struct qspinlock *lock,
> >> +						   u32 val,
> >> +						   struct mcs_spinlock *node)
> >> +{
> >> +	return atomic_try_cmpxchg_relaxed(&lock->val, &val, _Q_LOCKED_VAL);
> >> +}
> > 
> > That name is nonsense. It should be something like:
> > 
> > static __always_inline bool __try_clear_tail(…)
> 
> We already have set_locked(), so I was trying to convey the fact that we are
> doing the same here, but only when the MCS chain is empty.
> 
> I can use __try_clear_tail() instead.

Thing is, we go into this function with: *,0,1 and are trying to obtain
0,0,1. IOW, we're trying to clear the tail, while preserving pending and
locked.
