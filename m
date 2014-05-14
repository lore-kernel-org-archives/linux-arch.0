From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v10 03/19] qspinlock: Add pending bit
Date: Wed, 14 May 2014 21:13:40 +0200
Message-ID: <20140514191339.GA22813@potion.brq.redhat.com>
References: <1399474907-22206-1-git-send-email-Waiman.Long@hp.com>
 <1399474907-22206-4-git-send-email-Waiman.Long@hp.com>
 <20140512152208.GA12309@potion.brq.redhat.com>
 <537276B4.10209@hp.com>
 <20140514165121.GA21370@potion.redhat.com>
 <20140514170016.GW30445@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140514170016.GW30445@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <waiman.long@hp.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, David Vrabel <david.vrabel@citrix.com>, Oleg Nesterov <oleg@redhat.com>, Gleb Natapov <gleb@redhat.com>, Scott J Norton <scott.norton@hp.com>, Chegu Vinod <chegu_vinod@hp.com>
List-Id: linux-arch.vger.kernel.org

2014-05-14 19:00+0200, Peter Zijlstra:
> On Wed, May 14, 2014 at 06:51:24PM +0200, Radim Kr=C4=8Dm=C3=A1=C5=99=
 wrote:
> > Ok.
> > I've seen merit in pvqspinlock even with slightly slower first-wait=
er,
> > so I would have happily sacrificed those horrible branches.
> > (I prefer elegant to optimized code, but I can see why we want to b=
e
> >  strictly better than ticketlock.)
> > Peter mentioned that we are focusing on bare-metal patches, so I'll
> > withold my other paravirt rants until they are polished.

(It was an ambiguous sentence, I have comments for later patches.)

> Well, paravirt must happen too, but comes later in this series, patch=
 3
> which we're replying to is still very much in the bare metal part of =
the
> series.

(I think that bare metal spans the first 7 patches.)

> I've not had time yet to decode all that Waiman has done to make
> paravirt work.
>=20
> But as a general rule I like patches that start with something simple
> and working and then optimize it, this series doesn't seem to quite
> grasp that.
>=20
> > And to forcefully bring this thread a little bit on-topic:
> >=20
> > Pending-bit is effectively a lock in a lock, so I was wondering why
> > don't we use more pending bits; advantages are the same, just dimin=
ished
> > by the probability of having an ideally contended lock:
> >  - waiter won't be blocked on RAM access if critical section (or mo=
re)
> >    ends sooner
> >  - some unlucky cacheline is not forgotten
> >  - faster unlock (no need for tail operations)
> > (- ?)
> > disadvantages are magnified:
> >  - increased complexity
> >  - intense cacheline sharing
> >    (I thought that this is the main disadvantage of ticketlock.)
> > (- ?)
> >=20
> > One bit still improved performance, is it the best we got?
>=20
> So, the advantage of one bit is that if we use a whole byte for 1 bit=
 we
> can avoid some atomic ops.
>=20
> The entire reason for this in-word spinner is to amortize the cost of
> hitting the external node cacheline.

Every pending CPU removes one length of the critical section from the
delay caused by cacheline propagation and really cold cache is
hundreds(?) of cycles, so we could burn some to ensure correctness and
still be waiting when the first pending CPU unlocks.

> So traditional locks like test-and-test and the ticket lock only ever
> access the spinlock word itsef, this MCS style queueing lock has a
> second (and, see my other rants in this thread, when done wrong more
> than 2) cacheline to touch.
>=20
> That said, all our benchmarking is pretty much for the cache-hot case=
,
> so I'm not entirely convinced yet that the one pending bit makes up f=
or
> it, it does in the cache-hot case.

Yeah, we probably use the faster pre-lock quite a lot.
Cover letter states that queue depth 1-3 is a bit slower than ticket
spinlock, so we might not be losing if we implemented a faster
in-word-lock of this capacity.  (Not that I'm a fan of the hybrid lock.=
)

> But... writing cache-cold benchmarks is _hard_ :/

Wouldn't clflush of the second cacheline before trying for the lock giv=
e
us a rough estimate?
