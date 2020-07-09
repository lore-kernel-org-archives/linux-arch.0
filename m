From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc: select ARCH_HAS_MEMBARRIER_SYNC_CORE
Date: Thu, 09 Jul 2020 20:24:56 +1000
Message-ID: <1594290193.f21t9y66td.astroid@bobo.none>
References: <20200706021822.1515189-1-npiggin@gmail.com>
        <cf10b0bc-de79-1b2b-8355-fc7bbeec47c3@csgroup.eu>
        <1594098302.nadnq2txti.astroid@bobo.none>
        <638683144.970.1594121101349.JavaMail.zimbra@efficios.com>
        <1594185107.e130s0d92x.astroid@bobo.none>
        <407005394.1910.1594217551840.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgGIKZF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2020 06:25:05 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA38EC061A0B
        for <linux-arch@vger.kernel.org>; Thu,  9 Jul 2020 03:25:04 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id b92so910411pjc.4
        for <linux-arch@vger.kernel.org>; Thu, 09 Jul 2020 03:25:04 -0700 (PDT)
In-Reply-To: <407005394.1910.1594217551840.JavaMail.zimbra@efficios.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, linux-arch <linux-arch@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>

Excerpts from Mathieu Desnoyers's message of July 9, 2020 12:12 am:
> ----- On Jul 8, 2020, at 1:17 AM, Nicholas Piggin npiggin@gmail.com wrote=
:
>=20
>> Excerpts from Mathieu Desnoyers's message of July 7, 2020 9:25 pm:
>>> ----- On Jul 7, 2020, at 1:50 AM, Nicholas Piggin npiggin@gmail.com wro=
te:
>>>=20
> [...]
>>>> I should actually change the comment for 64-bit because soft masked
>>>> interrupt replay is an interesting case. I thought it was okay (becaus=
e
>>>> the IPI would cause a hard interrupt which does do the rfi) but that
>>>> should at least be written.
>>>=20
>>> Yes.
>>>=20
>>>> The context synchronisation happens before
>>>> the Linux IPI function is called, but for the purpose of membarrier I
>>>> think that is okay (the membarrier just needs to have caused a memory
>>>> barrier + context synchronistaion by the time it has done).
>>>=20
>>> Can you point me to the code implementing this logic ?
>>=20
>> It's mostly in arch/powerpc/kernel/exception-64s.S and
>> powerpc/kernel/irq.c, but a lot of asm so easier to explain.
>>=20
>> When any Linux code does local_irq_disable(), we set interrupts as
>> software-masked in a per-cpu flag. When interrupts (including IPIs) come
>> in, the first thing we do is check that flag and if we are masked, then
>> record that the interrupt needs to be "replayed" in another per-cpu
>> flag. The interrupt handler then exits back using RFI (which is context
>> synchronising the CPU). Later, when the kernel code does
>> local_irq_enable(), it checks the replay flag to see if anything needs
>> to be done. At that point we basically just call the interrupt handler
>> code like a normal function, and when that returns there is no context
>> synchronising instruction.
>=20
> AFAIU this can only happen for interrupts nesting over irqoff sections,
> therefore over kernel code, never userspace, right ?

Right.

>> So membarrier IPI will always cause target CPUs to perform a context
>> synchronising instruction, but sometimes it happens before the IPI
>> handler function runs.
>=20
> If my understanding is correct, the replayed interrupt handler logic
> only nests over kernel code, which will eventually need to issue a
> context synchronizing instruction before returning to user-space.

Yes.

> All we care about is that starting from the membarrier, each core
> either:
>=20
> - interrupt user-space to issue the context synchronizing instruction if
>   they were running userspace, or
> - _eventually_ issue a context synchronizing instruction before returning
>   to user-space if they were running kernel code.
>=20
> So your earlier statement "the membarrier just needs to have caused a mem=
ory
> barrier + context synchronistaion by the time it has done" is not strictl=
y
> correct: the context synchronizing instruction does not strictly need to
> happen on each core before membarrier returns. A similar line of thoughts
> can be followed for memory barriers.

Ah okay that makes it simpler, then no such speical comment is required=20
for the powerpc specific interrupt handling.

Thanks,
Nick
