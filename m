From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc: select ARCH_HAS_MEMBARRIER_SYNC_CORE
Date: Wed, 08 Jul 2020 15:17:49 +1000
Message-ID: <1594185107.e130s0d92x.astroid@bobo.none>
References: <20200706021822.1515189-1-npiggin@gmail.com>
        <cf10b0bc-de79-1b2b-8355-fc7bbeec47c3@csgroup.eu>
        <1594098302.nadnq2txti.astroid@bobo.none>
        <638683144.970.1594121101349.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgGHFRz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Jul 2020 01:17:55 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D692C061755
        for <linux-arch@vger.kernel.org>; Tue,  7 Jul 2020 22:17:55 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t15so664025pjq.5
        for <linux-arch@vger.kernel.org>; Tue, 07 Jul 2020 22:17:55 -0700 (PDT)
In-Reply-To: <638683144.970.1594121101349.JavaMail.zimbra@efficios.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, linux-arch <linux-arch@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>

Excerpts from Mathieu Desnoyers's message of July 7, 2020 9:25 pm:
> ----- On Jul 7, 2020, at 1:50 AM, Nicholas Piggin npiggin@gmail.com wrote=
:
>=20
>> Excerpts from Christophe Leroy's message of July 6, 2020 7:53 pm:
>>>=20
>>>=20
>>> Le 06/07/2020 =C3=A0 04:18, Nicholas Piggin a =C3=A9crit=C2=A0:
>>>> diff --git a/arch/powerpc/include/asm/exception-64s.h
>>>> b/arch/powerpc/include/asm/exception-64s.h
>>>> index 47bd4ea0837d..b88cb3a989b6 100644
>>>> --- a/arch/powerpc/include/asm/exception-64s.h
>>>> +++ b/arch/powerpc/include/asm/exception-64s.h
>>>> @@ -68,6 +68,10 @@
>>>>    *
>>>>    * The nop instructions allow us to insert one or more instructions =
to flush the
>>>>    * L1-D cache when returning to userspace or a guest.
>>>> + *
>>>> + * powerpc relies on return from interrupt/syscall being context sync=
hronising
>>>> + * (which hrfid, rfid, and rfscv are) to support ARCH_HAS_MEMBARRIER_=
SYNC_CORE
>>>> + * without additional additional synchronisation instructions.
>>>=20
>>> This file is dedicated to BOOK3S/64. What about other ones ?
>>>=20
>>> On 32 bits, this is also valid as 'rfi' is also context synchronising,
>>> but then why just add some comment in exception-64s.h and only there ?
>>=20
>> Yeah you're right, I basically wanted to keep a note there just in case,
>> because it's possible we would get a less synchronising return (maybe
>> unlikely with meltdown) or even return from a kernel interrupt using a
>> something faster (e.g., bctar if we don't use tar register in the kernel
>> anywhere).
>>=20
>> So I wonder where to add the note, entry_32.S and 64e.h as well?
>>=20
>=20
> For 64-bit powerpc, I would be tempted to either place the comment in the=
 header
> implementing the RFI_TO_USER and RFI_TO_USER_OR_KERNEL macros or the .S f=
iles
> using them, e.g. either:
>=20
> arch/powerpc/include/asm/exception-64e.h
> arch/powerpc/include/asm/exception-64s.h
>=20
> or
>=20
> arch/powerpc/kernel/exceptions-64s.S
> arch/powerpc/kernel/entry_64.S
>=20
> And for 32-bit powerpc, AFAIU
>=20
> arch/powerpc/kernel/entry_32.S
>=20
> uses SYNC + RFI to return to user-space. RFI is defined in
>=20
> arch/powerpc/include/asm/ppc_asm.h
>=20
> So a comment either near the RFI define and its uses should work.
>=20
>> I should actually change the comment for 64-bit because soft masked
>> interrupt replay is an interesting case. I thought it was okay (because
>> the IPI would cause a hard interrupt which does do the rfi) but that
>> should at least be written.
>=20
> Yes.
>=20
>> The context synchronisation happens before
>> the Linux IPI function is called, but for the purpose of membarrier I
>> think that is okay (the membarrier just needs to have caused a memory
>> barrier + context synchronistaion by the time it has done).
>=20
> Can you point me to the code implementing this logic ?

It's mostly in arch/powerpc/kernel/exception-64s.S and=20
powerpc/kernel/irq.c, but a lot of asm so easier to explain.

When any Linux code does local_irq_disable(), we set interrupts as=20
software-masked in a per-cpu flag. When interrupts (including IPIs) come
in, the first thing we do is check that flag and if we are masked, then
record that the interrupt needs to be "replayed" in another per-cpu=20
flag. The interrupt handler then exits back using RFI (which is context=20
synchronising the CPU). Later, when the kernel code does=20
local_irq_enable(), it checks the replay flag to see if anything needs=20
to be done. At that point we basically just call the interrupt handler=20
code like a normal function, and when that returns there is no context
synchronising instruction.

So membarrier IPI will always cause target CPUs to perform a context
synchronising instruction, but sometimes it happens before the IPI=20
handler function runs.

Thanks,
Nick
