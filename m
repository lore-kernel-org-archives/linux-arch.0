From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH 18/28] ARC: add smp barriers around atomics per
 memory-barrriers.txt
Date: Wed, 10 Jun 2015 09:17:16 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075665A4FEA@IN01WEMBXB.internal.synopsys.com>
References: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
 <1433850508-26317-19-git-send-email-vgupta@synopsys.com>
 <20150609123024.GX3644@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:47855 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754006AbbFJJRV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 10 Jun 2015 05:17:21 -0400
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "arc-linux-dev@synopsys.com" <arc-linux-dev@synopsys.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

On Tuesday 09 June 2015 06:00 PM, Peter Zijlstra wrote:
> On Tue, Jun 09, 2015 at 05:18:18PM +0530, Vineet Gupta wrote:
>
> Please try and provide at least _some_ Changelog body.
>
> <snip all atomic ops that return values>

Will do as comments in source as well as commit log in v2.

>> diff --git a/arch/arc/include/asm/spinlock.h b/arch/arc/include/asm/spinlock.h
>> index b6a8c2dfbe6e..8af8eaad4999 100644
>> --- a/arch/arc/include/asm/spinlock.h
>> +++ b/arch/arc/include/asm/spinlock.h
>> @@ -22,24 +22,32 @@ static inline void arch_spin_lock(arch_spinlock_t *lock)
>>  {
>>  	unsigned int tmp = __ARCH_SPIN_LOCK_LOCKED__;
>>  
>> +	smp_mb();
>> +
>>  	__asm__ __volatile__(
>>  	"1:	ex  %0, [%1]		\n"
>>  	"	breq  %0, %2, 1b	\n"
>>  	: "+&r" (tmp)
>>  	: "r"(&(lock->slock)), "ir"(__ARCH_SPIN_LOCK_LOCKED__)
>>  	: "memory");
>> +
>> +	smp_mb();
>>  }
>>  
>>  static inline int arch_spin_trylock(arch_spinlock_t *lock)
>>  {
>>  	unsigned int tmp = __ARCH_SPIN_LOCK_LOCKED__;
>>  
>> +	smp_mb();
>> +
>>  	__asm__ __volatile__(
>>  	"1:	ex  %0, [%1]		\n"
>>  	: "+r" (tmp)
>>  	: "r"(&(lock->slock))
>>  	: "memory");
>>  
>> +	smp_mb();
>> +
>>  	return (tmp == __ARCH_SPIN_LOCK_UNLOCKED__);
>>  }
>>  
> Both these are only required to provide an ACQUIRE barrier, if all you
> have is smp_mb(), the second is sufficient.

Essentially ARCv2 is weakly ordered with explicit ordering provided by DMB
instructions with semantics load/load, store/store, all/all.

I wanted to clarify a couple of things
(1) ACQUIRE barrier implies store/{store,load} while RELEASE implies
{load,store}/store and given what DMB provides for ARCv2, smp_mb() is the only fit ?
(2) Do we need smp_mb() on both sides of spin lock/unlock - doesn't ACQUIRE imply
we have a smp_mb() after lock but before any subsequent critical section - so the
top hunk is not necessarily needed. Similarly RELEASE requires a smp_mb() before
the memory operation for lock, but not after.

> Also note that a failed trylock is not required to provide _any_ barrier
> at all.

But that means wrapping the barrier in a branch etc, I'd rather keep them uniform
for now - unless we see performance hits due to that. I suppose all of that is
more relevant for heavy metal 4k cpu stuff ?

>
>> @@ -47,6 +55,8 @@ static inline void arch_spin_unlock(arch_spinlock_t *lock)
>>  {
>>  	unsigned int tmp = __ARCH_SPIN_LOCK_UNLOCKED__;
>>  
>> +	smp_mb();
>> +
>>  	__asm__ __volatile__(
>>  	"	ex  %0, [%1]		\n"
>>  	: "+r" (tmp)
> This requires a RELEASE barrier, again, if all you have is smp_mb(),
> this is indeed correct.

Ok, actually we already had a smp_mb() in the end of this function - but depending
on what ur reply is to #2 above we can remove that (as a seperate commit)

>
> Describing some of this would make for a fine Changelog body :-)

I will spin a v2 after your response, with more informative changelog.

Thx for the review.

-Vineet
