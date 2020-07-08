From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 0/6] powerpc: queued spinlocks and rwlocks
Date: Wed, 08 Jul 2020 15:10:52 +1000
Message-ID: <1594184204.ncuq7vstsz.astroid@bobo.none>
References: <20200706043540.1563616-1-npiggin@gmail.com>
        <24f75d2c-60cd-2766-4aab-1a3b1c80646e@redhat.com>
        <1594101082.hfq9x5yact.astroid@bobo.none>
        <de3ead58-7f81-8ebd-754d-244f6be24af4@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <kvm-ppc-owner@vger.kernel.org>
In-Reply-To: <de3ead58-7f81-8ebd-754d-244f6be24af4@redhat.com>
Sender: kvm-ppc-owner@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org, Waiman Long <longman@redhat.com>
Cc: Anton Blanchard <anton@ozlabs.org>, Boqun Feng <boqun.feng@gmail.com>, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, Will Deacon <will@kernel.org>
List-Id: linux-arch.vger.kernel.org

Excerpts from Waiman Long's message of July 8, 2020 1:33 pm:
> On 7/7/20 1:57 AM, Nicholas Piggin wrote:
>> Yes, powerpc could certainly get more performance out of the slow
>> paths, and then there are a few parameters to tune.
>>
>> We don't have a good alternate patching for function calls yet, but
>> that would be something to do for native vs pv.
>>
>> And then there seem to be one or two tunable parameters we could
>> experiment with.
>>
>> The paravirt locks may need a bit more tuning. Some simple testing
>> under KVM shows we might be a bit slower in some cases. Whether this
>> is fairness or something else I'm not sure. The current simple pv
>> spinlock code can do a directed yield to the lock holder CPU, whereas
>> the pv qspl here just does a general yield. I think we might actually
>> be able to change that to also support directed yield. Though I'm
>> not sure if this is actually the cause of the slowdown yet.
>=20
> Regarding the paravirt lock, I have taken a further look into the=20
> current PPC spinlock code. There is an equivalent of pv_wait() but no=20
> pv_kick(). Maybe PPC doesn't really need that.

So powerpc has two types of wait, either undirected "all processors" or=20
directed to a specific processor which has been preempted by the=20
hypervisor.

The simple spinlock code does a directed wait, because it knows the CPU=20
which is holding the lock. In this case, there is a sequence that is=20
used to ensure we don't wait if the condition has become true, and the
target CPU does not need to kick the waiter it will happen automatically
(see splpar_spin_yield). This is preferable because we only wait as=20
needed and don't require the kick operation.

The pv spinlock code I did uses the undirected wait, because we don't
know the CPU number which we are waiting on. This is undesirable because=20
it's higher overhead and the wait is not so accurate.

I think perhaps we could change things so we wait on the correct CPU=20
when queued, which might be good enough (we could also put the lock
owner CPU in the spinlock word, if we add another format).

> Attached are two=20
> additional qspinlock patches that adds a CONFIG_PARAVIRT_QSPINLOCKS_LITE=20
> option to not require pv_kick(). There is also a fixup patch to be=20
> applied after your patchset.
>=20
> I don't have access to a PPC LPAR with shared processor at the moment,=20
> so I can't test the performance of the paravirt code. Would you mind=20
> adding my patches and do some performance test on your end to see if it=20
> gives better result?

Great, I'll do some tests. Any suggestions for what to try?

Thanks,
Nick
