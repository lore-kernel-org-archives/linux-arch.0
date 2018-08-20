Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:54624 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbeHTTNH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Aug 2018 15:13:07 -0400
Date: Mon, 20 Aug 2018 17:56:50 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] locking: Remove an insn from spin and write locks
Message-ID: <20180820155650.GG24082@hirez.programming.kicks-ass.net>
References: <20180820150652.29482-1-willy@infradead.org>
 <f24a32be-6a4f-0df8-4289-14adc1046f50@redhat.com>
 <20180820155002.GB25153@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180820155002.GB25153@bombadil.infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Waiman Long <longman@redhat.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>
Message-ID: <20180820155650.fl45DyMlrOnyiRhOBq4ED-fvvPHeTwC7PhzVxcChPMQ@z>

On Mon, Aug 20, 2018 at 08:50:02AM -0700, Matthew Wilcox wrote:
> On Mon, Aug 20, 2018 at 11:14:04AM -0400, Waiman Long wrote:
> > On 08/20/2018 11:06 AM, Matthew Wilcox wrote:
> > > Both spin locks and write locks currently do:
> > >
> > >  f0 0f b1 17             lock cmpxchg %edx,(%rdi)
> > >  85 c0                   test   %eax,%eax
> > >  75 05                   jne    [slowpath]
> > >
> > > This 'test' insn is superfluous; the cmpxchg insn sets the Z flag
> > > appropriately.  Peter pointed out that using atomic_try_cmpxchg()
> > > will let the compiler know this is true.  Comparing before/after
> > > disassemblies show the only effect is to remove this insn.
> ...
> > >  static __always_inline int queued_spin_trylock(struct qspinlock *lock)
> > >  {
> > > +	u32 val = 0;
> > > +
> > >  	if (!atomic_read(&lock->val) &&
> > > -	   (atomic_cmpxchg_acquire(&lock->val, 0, _Q_LOCKED_VAL) == 0))
> > > +	    (atomic_try_cmpxchg(&lock->val, &val, _Q_LOCKED_VAL)))
> > 
> > Should you keep the _acquire suffix?
> 
> I don't know ;-)  Probably.  Peter didn't include it as part of his
> suggested fix, but on reviewing the documentation, it seems likely that
> it should be retained.  I put them back in and (as expected) it changes
> nothing on x86-64.

Yeah, _acquire should be retained; sorry about loosing that. I'm neck
deep into tlb invalidate stuff and wrote this without much thinking
involved.
