Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51452 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726033AbeHTTMD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 20 Aug 2018 15:12:03 -0400
Subject: Re: [PATCH] locking: Remove an insn from spin and write locks
References: <20180820150652.29482-1-willy@infradead.org>
 <f24a32be-6a4f-0df8-4289-14adc1046f50@redhat.com>
 <20180820155002.GB25153@bombadil.infradead.org>
From: Waiman Long <longman@redhat.com>
Message-ID: <ecbfa4e4-94d3-4cc7-1e34-7e892ee4bebf@redhat.com>
Date: Mon, 20 Aug 2018 11:55:51 -0400
MIME-Version: 1.0
In-Reply-To: <20180820155002.GB25153@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>
Message-ID: <20180820155551.Cp9T43vGObxutxAByvbIwbiQTPRCQulrDe22dGpFsEk@z>

On 08/20/2018 11:50 AM, Matthew Wilcox wrote:
> On Mon, Aug 20, 2018 at 11:14:04AM -0400, Waiman Long wrote:
>> On 08/20/2018 11:06 AM, Matthew Wilcox wrote:
>>> Both spin locks and write locks currently do:
>>>
>>>  f0 0f b1 17             lock cmpxchg %edx,(%rdi)
>>>  85 c0                   test   %eax,%eax
>>>  75 05                   jne    [slowpath]
>>>
>>> This 'test' insn is superfluous; the cmpxchg insn sets the Z flag
>>> appropriately.  Peter pointed out that using atomic_try_cmpxchg()
>>> will let the compiler know this is true.  Comparing before/after
>>> disassemblies show the only effect is to remove this insn.
> ...
>>>  static __always_inline int queued_spin_trylock(struct qspinlock *lock)
>>>  {
>>> +	u32 val = 0;
>>> +
>>>  	if (!atomic_read(&lock->val) &&
>>> -	   (atomic_cmpxchg_acquire(&lock->val, 0, _Q_LOCKED_VAL) == 0))
>>> +	    (atomic_try_cmpxchg(&lock->val, &val, _Q_LOCKED_VAL)))
>> Should you keep the _acquire suffix?
> I don't know ;-)  Probably.  Peter didn't include it as part of his
> suggested fix, but on reviewing the documentation, it seems likely that
> it should be retained.  I put them back in and (as expected) it changes
> nothing on x86-64.

We will certainly need to keep the _acquire suffix or it will likely
regress performance for arm64.

>> BTW, qspinlock and qrwlock are now also used by AArch64, mips and sparc.
>> Have you tried to see what the effect will be for those architecture?
> Nope!  That's why I cc'd linux-arch, because I don't know who (other
> than arm64 and x86) is using q-locks these days.

I think both Sparc and mips are using qlocks now, though these
architectures are not the ones that I am interested in. I do like to
make sure that there will be no regression for arm64. Will should be
able to answer that.

Cheers,
Longman
