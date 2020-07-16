From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH 4/7] x86: use exit_lazy_tlb rather than
 membarrier_mm_sync_core_before_usermode
Date: Thu, 16 Jul 2020 20:03:36 +1000
Message-ID: <1594892300.mxnq3b9a77.astroid@bobo.none>
References: <1594868476.6k5kvx8684.astroid@bobo.none>
        <EFAD6E2F-EC08-4EB3-9ECC-2A963C023FC5@amacapital.net>
        <20200716085032.GO10769@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbgGPKDn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jul 2020 06:03:43 -0400
In-Reply-To: <20200716085032.GO10769@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>, Peter Zijlstra <peterz@infradead.org>
Cc: Anton Blanchard <anton@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Andy Lutomirski <luto@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86 <x86@kernel.org>

Excerpts from Peter Zijlstra's message of July 16, 2020 6:50 pm:
> On Wed, Jul 15, 2020 at 10:18:20PM -0700, Andy Lutomirski wrote:
>> > On Jul 15, 2020, at 9:15 PM, Nicholas Piggin <npiggin@gmail.com> wrote=
:
>=20
>> > CPU0                     CPU1
>> >                         1. user stuff
>> > a. membarrier()          2. enter kernel
>> > b. read rq->curr         3. rq->curr switched to kthread
>> > c. is kthread, skip IPI  4. switch_to kthread
>> > d. return to user        5. rq->curr switched to user thread
>> >                 6. switch_to user thread
>> >                 7. exit kernel
>> >                         8. more user stuff
>=20
>> I find it hard to believe that this is x86 only. Why would thread
>> switch imply core sync on any architecture?  Is x86 unique in having a
>> stupid expensive core sync that is heavier than smp_mb()?
>=20
> smp_mb() is nowhere near the most expensive barrier we have in Linux,
> mb() might qualify, since that has some completion requirements since it
> needs to serialize against external actors.
>=20
> On x86_64 things are rather murky, we have:
>=20
> 	LOCK prefix -- which implies smp_mb() before and after RmW
> 	LFENCE -- which used to be rmb like, until Spectre, and now it
> 		  is ISYNC like. Since ISYNC ensures an empty pipeline,
> 		  it also implies all loads are retired (and therefore
> 		  complete) it implies rmb.
> 	MFENCE -- which is a memop completion barrier like, it makes
> 		  sure all previously issued memops are complete.
>=20
> if you read that carefully, you'll note you'll have to use LFENCE +
> MFENCE to order against non-memops instructions.
>=20
> But none of them imply dumping the instruction decoder caches, that only
> happens on core serializing instructions like CR3 writes, IRET, CPUID
> and a few others, I think we recently got a SERIALIZE instruction to add
> to this list.
>=20
>=20
> On ARM64 there's something a whole different set of barriers, and again
> smp_mb() isn't nowhere near the top of the list. They have roughly 3
> classes:
>=20
> 	ISB -- instruction sync barrier
> 	DMB(x) -- memory ordering in domain x
> 	DSB(x) -- memory completion in domain x
>=20
> And they have at least 3 domains (IIRC), system, outer, inner.
>=20
> The ARM64 __switch_to() includes a dsb(sy), just like PowerPC used to
> have a SYNC, but since PowerPC is rare for only having one rediculously
> heavy serializing instruction, we got to re-use the smp_mb() early in
> __schedule() instead, but ARM64 can't do that.
>=20
>=20
> So rather than say that x86 is special here, I'd say that PowerPC is
> special here.

PowerPC is "special", I'll agree with you there :)

It does have a SYNC (HWSYNC) instruction that is mb(). It does not
serialize the core.

ISYNC is a nop. ICBI ; ISYNC does serialize the core.

Difference between them is probably much the same as difference between
MFENCE and CPUID on x86 CPUs. Serializing the core is almost always=20
pretty expensive. HWSYNC/MFENCE can be expensive if you have a lot of
or difficult (not exclusive in cache) outstanding with critical reads
after the barrier, but it can also be somewhat cheap if there are few
writes, and executed past, it only needs to hold up subsequent reads.

That said... implementation details. powerpc CPUs have traditionally
had fairly costly HWSYNC.


>> But I=E2=80=99m wondering if all this deferred sync stuff is wrong. In t=
he
>> brave new world of io_uring and such, perhaps kernel access matter
>> too.  Heck, even:
>=20
> IIRC the membarrier SYNC_CORE use-case is about user-space
> self-modifying code.
>=20
> Userspace re-uses a text address and needs to SYNC_CORE before it can be
> sure the old text is forgotten. Nothing the kernel does matters there.
>=20
> I suppose the manpage could be more clear there.

True, but memory ordering of kernel stores from kernel threads for
regular mem barrier is the concern here.

Does io_uring update completion queue from kernel thread or interrupt,
for example? If it does, then membarrier will not order such stores
with user memory accesses.

Thanks,
Nick
