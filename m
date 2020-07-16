From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH 4/7] x86: use exit_lazy_tlb rather than
 membarrier_mm_sync_core_before_usermode
Date: Thu, 16 Jul 2020 11:34:52 -0400 (EDT)
Message-ID: <47821133.15875.1594913692220.JavaMail.zimbra@efficios.com>
References: <1594868476.6k5kvx8684.astroid@bobo.none> <EFAD6E2F-EC08-4EB3-9ECC-2A963C023FC5@amacapital.net> <20200716085032.GO10769@hirez.programming.kicks-ass.net> <1594892300.mxnq3b9a77.astroid@bobo.none> <20200716110038.GA119549@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200716110038.GA119549@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, Andy Lutomirski <luto@amacapital.net>, Anton Blanchard <anton@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>
List-Id: linux-arch.vger.kernel.org

----- On Jul 16, 2020, at 7:00 AM, Peter Zijlstra peterz@infradead.org wrot=
e:

> On Thu, Jul 16, 2020 at 08:03:36PM +1000, Nicholas Piggin wrote:
>> Excerpts from Peter Zijlstra's message of July 16, 2020 6:50 pm:
>> > On Wed, Jul 15, 2020 at 10:18:20PM -0700, Andy Lutomirski wrote:
>> >> > On Jul 15, 2020, at 9:15 PM, Nicholas Piggin <npiggin@gmail.com> wr=
ote:
>=20
>> >> But I=E2=80=99m wondering if all this deferred sync stuff is wrong. I=
n the
>> >> brave new world of io_uring and such, perhaps kernel access matter
>> >> too.  Heck, even:
>> >=20
>> > IIRC the membarrier SYNC_CORE use-case is about user-space
>> > self-modifying code.
>> >=20
>> > Userspace re-uses a text address and needs to SYNC_CORE before it can =
be
>> > sure the old text is forgotten. Nothing the kernel does matters there.
>> >=20
>> > I suppose the manpage could be more clear there.
>>=20
>> True, but memory ordering of kernel stores from kernel threads for
>> regular mem barrier is the concern here.
>>=20
>> Does io_uring update completion queue from kernel thread or interrupt,
>> for example? If it does, then membarrier will not order such stores
>> with user memory accesses.
>=20
> So we're talking about regular membarrier() then? Not the SYNC_CORE
> variant per-se.
>=20
> Even there, I'll argue we don't care, but perhaps Mathieu has a
> different opinion.

I agree with Peter that we don't care about accesses to user-space
memory performed concurrently with membarrier.

What we'd care about in terms of accesses to user-space memory from the
kernel is something that would be clearly ordered as happening before
or after the membarrier call, for instance a read(2) followed by
membarrier(2) after the read returns, or a read(2) issued after return
from membarrier(2). The other scenario we'd care about is with the compiler
barrier paired with membarrier: e.g. read(2) returns, compiler barrier,
followed by a store. Or load, compiler barrier, followed by write(2).

All those scenarios imply before/after ordering wrt either membarrier or
the compiler barrier. I notice that io_uring has a "completion" queue.
Let's try to come up with realistic usage scenarios.

So the dependency chain would be provided by e.g.:

* Infrequent read / Frequent write, communicating read completion through v=
ariable X

wait for io_uring read request completion -> membarrier -> store X=3D1

with matching

load from X (waiting for X=3D=3D1) -> asm volatile (::: "memory") -> submit=
 io_uring write request

or this other scenario:

* Frequent read / Infrequent write, communicating read completion through v=
ariable X

load from X (waiting for X=3D=3D1) -> membarrier -> submit io_uring write r=
equest

with matching

wait for io_uring read request completion -> asm volatile (::: "memory") ->=
 store X=3D1

Thanks,

Mathieu


--=20
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
