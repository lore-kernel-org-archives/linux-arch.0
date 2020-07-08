Return-Path: <SRS0=HA2T=AT=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59572 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726117AbgGHX6s (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Jul 2020 19:58:48 -0400
Subject: Re: [PATCH v3 0/6] powerpc: queued spinlocks and rwlocks
From: Waiman Long <longman@redhat.com>
References: <20200706043540.1563616-1-npiggin@gmail.com>
 <24f75d2c-60cd-2766-4aab-1a3b1c80646e@redhat.com>
 <1594101082.hfq9x5yact.astroid@bobo.none>
 <de3ead58-7f81-8ebd-754d-244f6be24af4@redhat.com>
 <1594184204.ncuq7vstsz.astroid@bobo.none>
 <62fa6343-e084-75c3-01c9-349a4617e67c@redhat.com>
Message-ID: <808a262d-8863-5986-082d-1088b66714df@redhat.com>
Date: Wed, 8 Jul 2020 19:58:40 -0400
MIME-Version: 1.0
In-Reply-To: <62fa6343-e084-75c3-01c9-349a4617e67c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Anton Blanchard <anton@ozlabs.org>, Boqun Feng <boqun.feng@gmail.com>, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, Will Deacon <will@kernel.org>
Message-ID: <20200708235840.ZRTCmD6fmNte3o6jZZdgLAMu7u_GxCVd5lN1u6sfdU8@z>

On 7/8/20 7:50 PM, Waiman Long wrote:
> On 7/8/20 1:10 AM, Nicholas Piggin wrote:
>> Excerpts from Waiman Long's message of July 8, 2020 1:33 pm:
>>> On 7/7/20 1:57 AM, Nicholas Piggin wrote:
>>>> Yes, powerpc could certainly get more performance out of the slow
>>>> paths, and then there are a few parameters to tune.
>>>>
>>>> We don't have a good alternate patching for function calls yet, but
>>>> that would be something to do for native vs pv.
>>>>
>>>> And then there seem to be one or two tunable parameters we could
>>>> experiment with.
>>>>
>>>> The paravirt locks may need a bit more tuning. Some simple testing
>>>> under KVM shows we might be a bit slower in some cases. Whether this
>>>> is fairness or something else I'm not sure. The current simple pv
>>>> spinlock code can do a directed yield to the lock holder CPU, whereas
>>>> the pv qspl here just does a general yield. I think we might actually
>>>> be able to change that to also support directed yield. Though I'm
>>>> not sure if this is actually the cause of the slowdown yet.
>>> Regarding the paravirt lock, I have taken a further look into the
>>> current PPC spinlock code. There is an equivalent of pv_wait() but no
>>> pv_kick(). Maybe PPC doesn't really need that.
>> So powerpc has two types of wait, either undirected "all processors" or
>> directed to a specific processor which has been preempted by the
>> hypervisor.
>>
>> The simple spinlock code does a directed wait, because it knows the CPU
>> which is holding the lock. In this case, there is a sequence that is
>> used to ensure we don't wait if the condition has become true, and the
>> target CPU does not need to kick the waiter it will happen automatically
>> (see splpar_spin_yield). This is preferable because we only wait as
>> needed and don't require the kick operation.
> Thanks for the explanation.
>>
>> The pv spinlock code I did uses the undirected wait, because we don't
>> know the CPU number which we are waiting on. This is undesirable because
>> it's higher overhead and the wait is not so accurate.
>>
>> I think perhaps we could change things so we wait on the correct CPU
>> when queued, which might be good enough (we could also put the lock
>> owner CPU in the spinlock word, if we add another format).
>
> The LS byte of the lock word is used to indicate locking status. If we 
> have less than 255 cpus, we can put the (cpu_nr + 1) into the lock 
> byte. The special 0xff value can be used to indicate a cpu number >= 
> 255 for indirect yield. The required change to the qspinlock code will 
> be minimal, I think. 

BTW, we can also keep track of the previous cpu in the waiting queue. 
Due to lock stealing, that may not be the cpu that is holding the lock. 
Maybe we can use this, if available, in case the cpu number is >= 255.

Regards,
Longman
