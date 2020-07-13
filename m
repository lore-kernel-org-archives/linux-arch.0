From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH 7/7] lazy tlb: shoot lazies, a non-refcounting lazy
 tlb option
Date: Mon, 13 Jul 2020 14:58:16 +1000
Message-ID: <1594615574.lowminiy4u.astroid@bobo.none>
References: <20200710015646.2020871-1-npiggin@gmail.com>
        <20200710015646.2020871-8-npiggin@gmail.com>
        <20200710093556.GY4800@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgGME6W (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jul 2020 00:58:22 -0400
In-Reply-To: <20200710093556.GY4800@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Anton Blanchard <anton@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org

Excerpts from Peter Zijlstra's message of July 10, 2020 7:35 pm:
> On Fri, Jul 10, 2020 at 11:56:46AM +1000, Nicholas Piggin wrote:
>> On big systems, the mm refcount can become highly contented when doing
>> a lot of context switching with threaded applications (particularly
>> switching between the idle thread and an application thread).
>>=20
>> Abandoning lazy tlb slows switching down quite a bit in the important
>> user->idle->user cases, so so instead implement a non-refcounted scheme
>> that causes __mmdrop() to IPI all CPUs in the mm_cpumask and shoot down
>> any remaining lazy ones.
>>=20
>> On a 16-socket 192-core POWER8 system, a context switching benchmark
>> with as many software threads as CPUs (so each switch will go in and
>> out of idle), upstream can achieve a rate of about 1 million context
>> switches per second. After this patch it goes up to 118 million.
>=20
> That's mighty impressive, however:

Well, it's the usual case of "find a bouncing line and scale up the
machine size until you achieve your desired improvements" :) But we
are looking at some fundamental scalabilities and seeing if we can
improve a few things.

>=20
>> +static void shoot_lazy_tlbs(struct mm_struct *mm)
>> +{
>> +	if (IS_ENABLED(CONFIG_MMU_LAZY_TLB_SHOOTDOWN)) {
>> +		smp_call_function_many(mm_cpumask(mm), do_shoot_lazy_tlb, (void *)mm,=
 1);
>> +		do_shoot_lazy_tlb(mm);
>> +	}
>> +}
>=20
> IIRC you (power) never clear a CPU from that mask, so for other
> workloads I can see this resulting in massive amounts of IPIs.
>=20
> For instance, take as many processes as you have CPUs. For each,
> manually walk the task across all CPUs and exit. Again.
>=20
> Clearly, that's an extreme, but still...

We do have some issues with that, it does tend to be very self-limiting
though, short lived tasks that can drive lots of exits won't get to run
on a lot of cores.

It's worth keeping an eye on, it may not be too hard to mitigate the IPIs
doing something dumb like collecting a queue of mms before killing a
batch of them.

Thanks,
Nick
