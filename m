Return-Path: <SRS0=9Vx7=A3=kvack.org=owner-linux-mm@kernel.org>
Date: Thu, 16 Jul 2020 13:00:38 +0200
From: peterz@infradead.org
Subject: Re: [RFC PATCH 4/7] x86: use exit_lazy_tlb rather than
 membarrier_mm_sync_core_before_usermode
Message-ID: <20200716110038.GA119549@hirez.programming.kicks-ass.net>
References: <1594868476.6k5kvx8684.astroid@bobo.none>
 <EFAD6E2F-EC08-4EB3-9ECC-2A963C023FC5@amacapital.net>
 <20200716085032.GO10769@hirez.programming.kicks-ass.net>
 <1594892300.mxnq3b9a77.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1594892300.mxnq3b9a77.astroid@bobo.none>
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Andy Lutomirski <luto@amacapital.net>, Anton Blanchard <anton@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Andy Lutomirski <luto@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86 <x86@kernel.org>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200716110038.5uDwm_kN0kVMb_a6QdUO6ps0tkfMCqyIRvmoeNxpEPE@z>

On Thu, Jul 16, 2020 at 08:03:36PM +1000, Nicholas Piggin wrote:
> Excerpts from Peter Zijlstra's message of July 16, 2020 6:50 pm:
> > On Wed, Jul 15, 2020 at 10:18:20PM -0700, Andy Lutomirski wrote:
> >> > On Jul 15, 2020, at 9:15 PM, Nicholas Piggin <npiggin@gmail.com> w=
rote:

> >> But I=E2=80=99m wondering if all this deferred sync stuff is wrong. =
In the
> >> brave new world of io_uring and such, perhaps kernel access matter
> >> too.  Heck, even:
> >=20
> > IIRC the membarrier SYNC_CORE use-case is about user-space
> > self-modifying code.
> >=20
> > Userspace re-uses a text address and needs to SYNC_CORE before it can=
 be
> > sure the old text is forgotten. Nothing the kernel does matters there=
.
> >=20
> > I suppose the manpage could be more clear there.
>=20
> True, but memory ordering of kernel stores from kernel threads for
> regular mem barrier is the concern here.
>=20
> Does io_uring update completion queue from kernel thread or interrupt,
> for example? If it does, then membarrier will not order such stores
> with user memory accesses.

So we're talking about regular membarrier() then? Not the SYNC_CORE
variant per-se.

Even there, I'll argue we don't care, but perhaps Mathieu has a
different opinion. All we care about is that all other threads (or CPUs
for GLOBAL) observe an smp_mb() before it returns.

Any serialization against whatever those other threads/CPUs are running
at the instant of the syscall is external to the syscall, we make no
gauarantees about that. That is, we can fundamentally not say what
another CPU is executing concurrently. Nor should we want to.

So if you feel that your membarrier() ought to serialize against remote
execution, you need to arrange a quiecent state on the remote side
yourself.

Now, normally membarrier() is used to implement userspace RCU like
things, and there all that matters is that the remote CPUs observe the
beginngin of the new grace-period, ie counter flip, and we observe their
read-side critical sections, or smething like that, it's been a while
since I looked at all that.

It's always been the case that concurrent syscalls could change user
memory, io_uring doesn't change that, it just makes it even less well
defined when that would happen. If you want to serialize against that,
you need to arrange that externally.
