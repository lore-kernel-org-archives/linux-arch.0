From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 2/8] powerpc/pseries: use smp_rmb() in H_CONFER spin yield
Date: Thu, 02 Jul 2020 20:36:27 +1000
Message-ID: <1593685552.uh4kepm08t.astroid@bobo.none>
References: <20200702074839.1057733-1-npiggin@gmail.com>
        <20200702074839.1057733-3-npiggin@gmail.com>
        <20200702082840.GC4781@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <kvm-ppc-owner@vger.kernel.org>
In-Reply-To: <20200702082840.GC4781@hirez.programming.kicks-ass.net>
Sender: kvm-ppc-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Anton Blanchard <anton@ozlabs.org>, Boqun Feng <boqun.feng@gmail.com>, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>, virtualization@lists.linux-foundation.org, Will Deacon <will@kernel.org>
List-Id: linux-arch.vger.kernel.org

Excerpts from Peter Zijlstra's message of July 2, 2020 6:28 pm:
> On Thu, Jul 02, 2020 at 05:48:33PM +1000, Nicholas Piggin wrote:
>> There is no need for rmb(), this allows faster lwsync here.
>=20
> Since you determined this; I'm thinking you actually understand the
> ordering here. How about recording this understanding in a comment?
>=20
> Also, should the lock->slock load not use READ_ONCE() ?

Yeah, good point. Maybe I'll drop it from this series, doesn't really=20
belong I just saw the cleanup and didn't want to forget it.

We we just ordering the two loads in this function, and !SMP isn't a=20
concern (i.e., no issues of !SMP guest on SMP HV), but yeah fixing
the lack of comment is warranted, thanks.

Thanks,
Nick
