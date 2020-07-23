From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v3 5/6] powerpc/pseries: implement paravirt qspinlocks for
 SPLPAR
Date: Thu, 23 Jul 2020 17:58:43 -0400
Message-ID: <4fbe47a5-dbc9-427a-5b21-b31b37bc751a@redhat.com>
References: <20200706043540.1563616-1-npiggin@gmail.com>
 <20200706043540.1563616-6-npiggin@gmail.com>
 <874kqhvu1v.fsf@mpe.ellerman.id.au>
 <8265d782-4e50-a9b2-a908-0cb588ffa09c@redhat.com>
 <20200723140011.GR5523@worktop.programming.kicks-ass.net>
 <845de183-56f5-2958-3159-faa131d46401@redhat.com>
 <20200723184759.GS119549@hirez.programming.kicks-ass.net>
 <6d6279ad-7432-63c1-14c3-18c4cff30bf8@redhat.com>
 <20200723195855.GU119549@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27587 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726368AbgGWV6v (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jul 2020 17:58:51 -0400
In-Reply-To: <20200723195855.GU119549@hirez.programming.kicks-ass.net>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: peterz@infradead.org
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>, Anton Blanchard <anton@ozlabs.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org

On 7/23/20 3:58 PM, peterz@infradead.org wrote:
> On Thu, Jul 23, 2020 at 03:04:13PM -0400, Waiman Long wrote:
>> On 7/23/20 2:47 PM, peterz@infradead.org wrote:
>>> On Thu, Jul 23, 2020 at 02:32:36PM -0400, Waiman Long wrote:
>>>> BTW, do you have any comment on my v2 lock holder cpu info qspinlock patch?
>>>> I will have to update the patch to fix the reported 0-day test problem, but
>>>> I want to collect other feedback before sending out v3.
>>> I want to say I hate it all, it adds instructions to a path we spend an
>>> aweful lot of time optimizing without really getting anything back for
>>> it.
>> It does add some extra instruction that may slow it down slightly, but I
>> don't agree that it gives nothing back. The cpu lock holder information can
>> be useful in analyzing crash dumps and in some debugging situation. I think
>> it can be useful in RHEL for this readon. How about an x86 config option to
>> allow distros to decide if they want to have it enabled? I will make sure
>> that it will have no performance degradation if the option is not enabled.
> Config knobs suck too; they create a maintenance burden (we get to make
> sure all the permutations works/build/etc..) and effectively nobody uses
> them, since world+dog uses what distros pick.
>
> Anyway, instead of adding a second per-cpu variable, can you see how
> horrible something like this is:
>
> unsigned char adds(unsigned char var, unsigned char val)
> {
> 	unsigned short sat = 0xff, tmp = var;
>
> 	asm ("addb	%[val], %b[var];"
> 	     "cmovc	%[sat], %[var];"
> 	     : [var] "+r" (tmp)
> 	     : [val] "ir" (val), [sat] "r" (sat)
> 	     );
>
> 	return tmp;
> }
>
> Another thing to try is, instead of threading that lockval throughout
> the thing, simply:
>
> #define _Q_LOCKED_VAL	this_cpu_read_stable(cpu_sat)
>
> or combined with the above
>
> #define _Q_LOCKED_VAL	adds(this_cpu_read_stable(cpu_number), 2)
>
> and see if the compiler really makes a mess of things.
>
Thanks for the suggestion. I will try that out.

Cheers,
Longman
