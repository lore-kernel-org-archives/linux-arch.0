From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc: select ARCH_HAS_MEMBARRIER_SYNC_CORE
Date: Tue, 7 Jul 2020 14:03:38 +0200
Message-ID: <23cf2781-104c-24ec-a53d-59e2a24d95c1@csgroup.eu>
References: <20200706021822.1515189-1-npiggin@gmail.com>
 <cf10b0bc-de79-1b2b-8355-fc7bbeec47c3@csgroup.eu>
 <1594098302.nadnq2txti.astroid@bobo.none>
 <638683144.970.1594121101349.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from pegase1.c-s.fr ([93.17.236.30]:64070 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbgGGMDw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 7 Jul 2020 08:03:52 -0400
In-Reply-To: <638683144.970.1594121101349.JavaMail.zimbra@efficios.com>
Content-Language: fr
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-arch <linux-arch@vger.kernel.org>



Le 07/07/2020 à 13:25, Mathieu Desnoyers a écrit :
> ----- On Jul 7, 2020, at 1:50 AM, Nicholas Piggin npiggin@gmail.com wrote:
> 
>> Excerpts from Christophe Leroy's message of July 6, 2020 7:53 pm:
>>>
>>>
>>> Le 06/07/2020 à 04:18, Nicholas Piggin a écrit :
>>>> diff --git a/arch/powerpc/include/asm/exception-64s.h
>>>> b/arch/powerpc/include/asm/exception-64s.h
>>>> index 47bd4ea0837d..b88cb3a989b6 100644
>>>> --- a/arch/powerpc/include/asm/exception-64s.h
>>>> +++ b/arch/powerpc/include/asm/exception-64s.h
>>>> @@ -68,6 +68,10 @@
>>>>     *
>>>>     * The nop instructions allow us to insert one or more instructions to flush the
>>>>     * L1-D cache when returning to userspace or a guest.
>>>> + *
>>>> + * powerpc relies on return from interrupt/syscall being context synchronising
>>>> + * (which hrfid, rfid, and rfscv are) to support ARCH_HAS_MEMBARRIER_SYNC_CORE
>>>> + * without additional additional synchronisation instructions.
>>>
>>> This file is dedicated to BOOK3S/64. What about other ones ?
>>>
>>> On 32 bits, this is also valid as 'rfi' is also context synchronising,
>>> but then why just add some comment in exception-64s.h and only there ?
>>
>> Yeah you're right, I basically wanted to keep a note there just in case,
>> because it's possible we would get a less synchronising return (maybe
>> unlikely with meltdown) or even return from a kernel interrupt using a
>> something faster (e.g., bctar if we don't use tar register in the kernel
>> anywhere).
>>
>> So I wonder where to add the note, entry_32.S and 64e.h as well?
>>
> 
> For 64-bit powerpc, I would be tempted to either place the comment in the header
> implementing the RFI_TO_USER and RFI_TO_USER_OR_KERNEL macros or the .S files
> using them, e.g. either:
> 
> arch/powerpc/include/asm/exception-64e.h
> arch/powerpc/include/asm/exception-64s.h
> 
> or
> 
> arch/powerpc/kernel/exceptions-64s.S
> arch/powerpc/kernel/entry_64.S
> 
> And for 32-bit powerpc, AFAIU
> 
> arch/powerpc/kernel/entry_32.S
> 
> uses SYNC + RFI to return to user-space. RFI is defined in
> 
> arch/powerpc/include/asm/ppc_asm.h
> 
> So a comment either near the RFI define and its uses should work.
> 


For 32-bit, RFI is likely to go away the day 40x goes away, so I 
wouldn't put it there.
Places like head_8xx.S use rfi not RFI.

And the SYNC is about to go when we decide to retire 601 SYNC FIX.

So it would be probably better to put it somewhere in entry_32.S

Christophe
