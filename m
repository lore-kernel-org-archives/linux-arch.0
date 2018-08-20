From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] locking: Remove an insn from spin and write locks
Date: Mon, 20 Aug 2018 08:50:02 -0700
Message-ID: <20180820155002.GB25153@bombadil.infradead.org>
References: <20180820150652.29482-1-willy@infradead.org>
 <f24a32be-6a4f-0df8-4289-14adc1046f50@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f24a32be-6a4f-0df8-4289-14adc1046f50@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Waiman Long <longman@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

On Mon, Aug 20, 2018 at 11:14:04AM -0400, Waiman Long wrote:
> On 08/20/2018 11:06 AM, Matthew Wilcox wrote:
> > Both spin locks and write locks currently do:
> >
> >  f0 0f b1 17             lock cmpxchg %edx,(%rdi)
> >  85 c0                   test   %eax,%eax
> >  75 05                   jne    [slowpath]
> >
> > This 'test' insn is superfluous; the cmpxchg insn sets the Z flag
> > appropriately.  Peter pointed out that using atomic_try_cmpxchg()
> > will let the compiler know this is true.  Comparing before/after
> > disassemblies show the only effect is to remove this insn.
...
> >  static __always_inline int queued_spin_trylock(struct qspinlock *lock)
> >  {
> > +	u32 val = 0;
> > +
> >  	if (!atomic_read(&lock->val) &&
> > -	   (atomic_cmpxchg_acquire(&lock->val, 0, _Q_LOCKED_VAL) == 0))
> > +	    (atomic_try_cmpxchg(&lock->val, &val, _Q_LOCKED_VAL)))
> 
> Should you keep the _acquire suffix?

I don't know ;-)  Probably.  Peter didn't include it as part of his
suggested fix, but on reviewing the documentation, it seems likely that
it should be retained.  I put them back in and (as expected) it changes
nothing on x86-64.

> BTW, qspinlock and qrwlock are now also used by AArch64, mips and sparc.
> Have you tried to see what the effect will be for those architecture?

Nope!  That's why I cc'd linux-arch, because I don't know who (other
than arm64 and x86) is using q-locks these days.
