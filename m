From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 0/6] powerpc: queued spinlocks and rwlocks
Date: Fri, 24 Jul 2020 02:12:21 +1000
Message-ID: <1595520724.nzha5zvbid.astroid@bobo.none>
References: <20200706043540.1563616-1-npiggin@gmail.com>
        <24f75d2c-60cd-2766-4aab-1a3b1c80646e@redhat.com>
        <1594101082.hfq9x5yact.astroid@bobo.none>
        <20200708084106.GE597537@hirez.programming.kicks-ass.net>
        <1595327263.lk78cqolxm.astroid@bobo.none>
        <eaabf501-80fe-dd15-c03c-f75ce4f75877@redhat.com>
        <1595510571.u39qfc8d1o.astroid@bobo.none>
        <af825bce-ecf3-66e4-ad63-a844dbd2e775@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <kvm-ppc-owner@vger.kernel.org>
In-Reply-To: <af825bce-ecf3-66e4-ad63-a844dbd2e775@redhat.com>
Sender: kvm-ppc-owner@vger.kernel.org
To: Waiman Long <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Anton Blanchard <anton@ozlabs.org>, Boqun Feng <boqun.feng@gmail.com>, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@redhat.com>, virtualization@lists.linux-foundation.org, Will Deacon <will@kernel.org>
List-Id: linux-arch.vger.kernel.org

Excerpts from Waiman Long's message of July 24, 2020 12:29 am:
> On 7/23/20 9:30 AM, Nicholas Piggin wrote:
>>> I would prefer to extract out the pending bit handling code out into a
>>> separate helper function which can be overridden by the arch code
>>> instead of breaking the slowpath into 2 pieces.
>> You mean have the arch provide a queued_spin_lock_slowpath_pending
>> function that the slow path calls?
>>
>> I would actually prefer the pending handling can be made inline in
>> the queued_spin_lock function, especially with out-of-line locks it
>> makes sense to put it there.
>>
>> We could ifdef out queued_spin_lock_slowpath_queue if it's not used,
>> then __queued_spin_lock_slowpath_queue would be inlined into the
>> caller so there would be no split?
>=20
> The pending code is an optimization for lightly contended locks. That is=20
> why I think it is appropriate to extract it into a helper function and=20
> mark it as such.
>=20
> You can certainly put the code in the arch's spin_lock code, you just=20
> has to override the generic pending code by a null function.

I see what you mean. I guess that would work fine.

Thanks,
Nick
