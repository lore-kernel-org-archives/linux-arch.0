Return-Path: <SRS0=GmBk=AY=kvack.org=owner-linux-mm@kernel.org>
MIME-Version: 1.0
References: <20200710015646.2020871-1-npiggin@gmail.com> <20200710015646.2020871-8-npiggin@gmail.com>
In-Reply-To: <20200710015646.2020871-8-npiggin@gmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Mon, 13 Jul 2020 08:59:04 -0700
Message-ID: <CALCETrWbD=3SUOuq9P7Syb+a1DoBjjem8hq9_HCvn7wyqETkpw@mail.gmail.com>
Subject: Re: [RFC PATCH 7/7] lazy tlb: shoot lazies, a non-refcounting lazy
 tlb option
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-mm@kvack.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Linux-MM <linux-mm@kvack.org>, Anton Blanchard <anton@ozlabs.org>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200713155904.pCrjPAAH_r5jjcOjh8MpcZPRP9Au0m6jKpJysNge6Q0@z>

On Thu, Jul 9, 2020 at 6:57 PM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> On big systems, the mm refcount can become highly contented when doing
> a lot of context switching with threaded applications (particularly
> switching between the idle thread and an application thread).
>
> Abandoning lazy tlb slows switching down quite a bit in the important
> user->idle->user cases, so so instead implement a non-refcounted scheme
> that causes __mmdrop() to IPI all CPUs in the mm_cpumask and shoot down
> any remaining lazy ones.
>
> On a 16-socket 192-core POWER8 system, a context switching benchmark
> with as many software threads as CPUs (so each switch will go in and
> out of idle), upstream can achieve a rate of about 1 million context
> switches per second. After this patch it goes up to 118 million.
>

I read the patch a couple of times, and I have a suggestion that could
be nonsense.  You are, effectively, using mm_cpumask() as a sort of
refcount.  You're saying "hey, this mm has no more references, but it
still has nonempty mm_cpumask(), so let's send an IPI and shoot down
those references too."  I'm wondering whether you actually need the
IPI.  What if, instead, you actually treated mm_cpumask as a refcount
for real?  Roughly, in __mmdrop(), you would only free the page tables
if mm_cpumask() is empty.  And, in the code that removes a CPU from
mm_cpumask(), you would check if mm_users == 0 and, if so, check if
you just removed the last bit from mm_cpumask and potentially free the
mm.

Getting the locking right here could be a bit tricky -- you need to
avoid two CPUs simultaneously exiting lazy TLB and thinking they
should free the mm, and you also need to avoid an mm with mm_users
hitting zero concurrently with the last remote CPU using it lazily
exiting lazy TLB.  Perhaps this could be resolved by having mm_count
== 1 mean "mm_cpumask() is might contain bits and, if so, it owns the
mm" and mm_count == 0 meaning "now it's dead" and using some careful
cmpxchg or dec_return to make sure that only one CPU frees it.

Or maybe you'd need a lock or RCU for this, but the idea would be to
only ever take the lock after mm_users goes to zero.

--Andy
