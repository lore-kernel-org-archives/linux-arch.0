From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH 7/7] lazy tlb: shoot lazies, a non-refcounting lazy
 tlb option
Date: Tue, 14 Jul 2020 16:31:20 +1000
Message-ID: <1594708054.04iuyxuyb5.astroid@bobo.none>
References: <1594658283.qabzoxga67.astroid@bobo.none>
        <010054C3-7FFF-4FB5-BDA8-D2B80F7B1A5D@amacapital.net>
        <1594701900.gcgdq8p13l.astroid@bobo.none>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgGNGba (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jul 2020 02:31:30 -0400
In-Reply-To: <1594701900.gcgdq8p13l.astroid@bobo.none>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Anton Blanchard <anton@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Andy Lutomirski <luto@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>

Excerpts from Nicholas Piggin's message of July 14, 2020 3:04 pm:
> Excerpts from Andy Lutomirski's message of July 14, 2020 4:18 am:
>>=20
>>> On Jul 13, 2020, at 9:48 AM, Nicholas Piggin <npiggin@gmail.com> wrote:
>>>=20
>>> =EF=BB=BFExcerpts from Andy Lutomirski's message of July 14, 2020 1:59 =
am:
>>>>> On Thu, Jul 9, 2020 at 6:57 PM Nicholas Piggin <npiggin@gmail.com> wr=
ote:
>>>>>=20
>>>>> On big systems, the mm refcount can become highly contented when doin=
g
>>>>> a lot of context switching with threaded applications (particularly
>>>>> switching between the idle thread and an application thread).
>>>>>=20
>>>>> Abandoning lazy tlb slows switching down quite a bit in the important
>>>>> user->idle->user cases, so so instead implement a non-refcounted sche=
me
>>>>> that causes __mmdrop() to IPI all CPUs in the mm_cpumask and shoot do=
wn
>>>>> any remaining lazy ones.
>>>>>=20
>>>>> On a 16-socket 192-core POWER8 system, a context switching benchmark
>>>>> with as many software threads as CPUs (so each switch will go in and
>>>>> out of idle), upstream can achieve a rate of about 1 million context
>>>>> switches per second. After this patch it goes up to 118 million.
>>>>>=20
>>>>=20
>>>> I read the patch a couple of times, and I have a suggestion that could
>>>> be nonsense.  You are, effectively, using mm_cpumask() as a sort of
>>>> refcount.  You're saying "hey, this mm has no more references, but it
>>>> still has nonempty mm_cpumask(), so let's send an IPI and shoot down
>>>> those references too."  I'm wondering whether you actually need the
>>>> IPI.  What if, instead, you actually treated mm_cpumask as a refcount
>>>> for real?  Roughly, in __mmdrop(), you would only free the page tables
>>>> if mm_cpumask() is empty.  And, in the code that removes a CPU from
>>>> mm_cpumask(), you would check if mm_users =3D=3D 0 and, if so, check i=
f
>>>> you just removed the last bit from mm_cpumask and potentially free the
>>>> mm.
>>>>=20
>>>> Getting the locking right here could be a bit tricky -- you need to
>>>> avoid two CPUs simultaneously exiting lazy TLB and thinking they
>>>> should free the mm, and you also need to avoid an mm with mm_users
>>>> hitting zero concurrently with the last remote CPU using it lazily
>>>> exiting lazy TLB.  Perhaps this could be resolved by having mm_count
>>>> =3D=3D 1 mean "mm_cpumask() is might contain bits and, if so, it owns =
the
>>>> mm" and mm_count =3D=3D 0 meaning "now it's dead" and using some caref=
ul
>>>> cmpxchg or dec_return to make sure that only one CPU frees it.
>>>>=20
>>>> Or maybe you'd need a lock or RCU for this, but the idea would be to
>>>> only ever take the lock after mm_users goes to zero.
>>>=20
>>> I don't think it's nonsense, it could be a good way to avoid IPIs.
>>>=20
>>> I haven't seen much problem here that made me too concerned about IPIs=20
>>> yet, so I think the simple patch may be good enough to start with
>>> for powerpc. I'm looking at avoiding/reducing the IPIs by combining the
>>> unlazying with the exit TLB flush without doing anything fancy with
>>> ref counting, but we'll see.
>>=20
>> I would be cautious with benchmarking here. I would expect that the
>> nasty cases may affect power consumption more than performance =E2=80=94=
 the=20
>> specific issue is IPIs hitting idle cores, and the main effects are to=20
>> slow down exit() a bit but also to kick the idle core out of idle.=20
>> Although, if the idle core is in a deep sleep, that IPI could be=20
>> *very* slow.
>=20
> It will tend to be self-limiting to some degree (deeper idle cores
> would tend to have less chance of IPI) but we have bigger issues on
> powerpc with that, like broadcast IPIs to the mm cpumask for THP
> management. Power hasn't really shown up as an issue but powerpc
> CPUs may have their own requirements and issues there, shall we say.
>=20
>> So I think it=E2=80=99s worth at least giving this a try.
>=20
> To be clear it's not a complete solution itself. The problem is of=20
> course that mm cpumask gives you false negatives, so the bits
> won't always clean up after themselves as CPUs switch away from their
> lazy tlb mms.

^^

False positives: CPU is in the mm_cpumask, but is not using the mm
as a lazy tlb. So there can be bits left and never freed.

If you closed the false positives, you're back to a shared mm cache
line on lazy mm context switches.

Thanks,
Nick
