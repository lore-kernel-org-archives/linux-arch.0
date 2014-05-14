From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v10 03/19] qspinlock: Add pending bit
Date: Wed, 14 May 2014 18:51:24 +0200
Message-ID: <20140514165121.GA21370@potion.redhat.com>
References: <1399474907-22206-1-git-send-email-Waiman.Long@hp.com>
 <1399474907-22206-4-git-send-email-Waiman.Long@hp.com>
 <20140512152208.GA12309@potion.brq.redhat.com>
 <537276B4.10209@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <537276B4.10209@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Waiman Long <waiman.long@hp.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, David Vrabel <david.vrabel@citrix.com>, Oleg Nesterov <oleg@redhat.com>, Gleb Natapov <gleb@redhat.com>, Scott J Norton <scott.norton@hp.com>, Chegu Vinod <chegu_vinod@hp.com>
List-Id: linux-arch.vger.kernel.org

2014-05-13 15:47-0400, Waiman Long:
> On 05/12/2014 11:22 AM, Radim Kr=C4=8Dm=C3=A1=C5=99 wrote:
> >I think there is an unwanted scenario on virtual machines:
> >1) VCPU sets the pending bit and start spinning.
> >2) Pending VCPU gets descheduled.
> >     - we have PLE and lock holder isn't running [1]
> >     - the hypervisor randomly preempts us
> >3) Lock holder unlocks while pending VCPU is waiting in queue.
> >4) Subsequent lockers will see free lock with set pending bit and wi=
ll
> >    loop in trylock's 'for (;;)'
> >     - the worst-case is lock starving [2]
> >     - PLE can save us from wasting whole timeslice
> >
> >Retry threshold is the easiest solution, regardless of its ugliness =
[4].
>=20
> Yes, that can be a real issue. Some sort of retry threshold, as you s=
aid,
> should be able to handle it.
>=20
> BTW, the relevant patch should be 16/19 where the PV spinlock stuff s=
hould
> be discussed. This patch is perfectly fine.

Ouch, my apology to Peter didn't make it ... Agreed, I should have spli=
t
the comment under patches
 [06/19] (part quoted above; does not depend on PV),
 [16/19] (part quoted below) and
 [17/19] (general doubts).

> >Another minor design flaw is that formerly first VCPU gets appended =
to
> >the tail when it decides to queue;
> >is the performance gain worth it?
> >
> >Thanks.
>=20
> Yes, the performance gain is worth it. The primary goal is to be not =
worse
> than ticket spinlock in light load situation which is the most common=
 case.
> This feature is need to achieve that.

Ok.
I've seen merit in pvqspinlock even with slightly slower first-waiter,
so I would have happily sacrificed those horrible branches.
(I prefer elegant to optimized code, but I can see why we want to be
 strictly better than ticketlock.)
Peter mentioned that we are focusing on bare-metal patches, so I'll
withold my other paravirt rants until they are polished.

And to forcefully bring this thread a little bit on-topic:

Pending-bit is effectively a lock in a lock, so I was wondering why
don't we use more pending bits; advantages are the same, just diminishe=
d
by the probability of having an ideally contended lock:
 - waiter won't be blocked on RAM access if critical section (or more)
   ends sooner
 - some unlucky cacheline is not forgotten
 - faster unlock (no need for tail operations)
(- ?)
disadvantages are magnified:
 - increased complexity
 - intense cacheline sharing
   (I thought that this is the main disadvantage of ticketlock.)
(- ?)

One bit still improved performance, is it the best we got?

Thanks.
