From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v2 1/2] locking/qrwlock: Reduce reader/writer to reader
 lock transfer latency
Date: Thu, 09 Jul 2015 21:10:04 -0400
Message-ID: <559F1B6C.7040706@hp.com>
References: <1436459543-29126-1-git-send-email-Waiman.Long@hp.com>  <1436459543-29126-2-git-send-email-Waiman.Long@hp.com> <1436475158.12255.119.camel@stgolabs.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g2t2354.austin.hp.com ([15.217.128.53]:44409 "EHLO
	g2t2354.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346AbbGJBKJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2015 21:10:09 -0400
In-Reply-To: <1436475158.12255.119.camel@stgolabs.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>

On 07/09/2015 04:52 PM, Davidlohr Bueso wrote:
> On Thu, 2015-07-09 at 12:32 -0400, Waiman Long wrote:
>> This patch eliminates that waiting. It also has the side effect
>> of reducing the chance of writer lock stealing and improving the
>> fairness of the lock. Using a locking microbenchmark, a 10-threads 5M
>> locking loop of mostly readers (RW ratio = 10,000:1) has the following
>> performance numbers in a Haswell-EX box:
>>
>>          Kernel          Locking Rate (Kops/s)
>>          ------          ---------------------
>>          4.1.1               15,063,081
>>          Patched 4.1.1       17,241,552
> In any case, for such read-mostly scenarios, you'd probably want to be
> using rcu ;-).

Yes, I agree:-)

>> Signed-off-by: Waiman Long<Waiman.Long@hp.com>
>> ---
>>   kernel/locking/qrwlock.c |   12 ++++--------
>>   1 files changed, 4 insertions(+), 8 deletions(-)
>>
>> diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
>> index d9c36c5..6a7a3b8 100644
>> --- a/kernel/locking/qrwlock.c
>> +++ b/kernel/locking/qrwlock.c
>> @@ -88,15 +88,11 @@ void queued_read_lock_slowpath(struct qrwlock *lock, u32 cnts)
>>   	arch_spin_lock(&lock->lock);
>>
>>   	/*
>> -	 * At the head of the wait queue now, wait until the writer state
>> -	 * goes to 0 and then try to increment the reader count and get
>> -	 * the lock. It is possible that an incoming writer may steal the
>> -	 * lock in the interim, so it is necessary to check the writer byte
>> -	 * to make sure that the write lock isn't taken.
>> +	 * At the head of the wait queue now, increment the reader count
>> +	 * and wait until the writer, if it has the lock, has gone away.
>> +	 * At ths
>                  ^^ this
>
>>   stage, it is not possible for a writer to remain in the
>> +	 * waiting state (_QW_WAITING). So there won't be any deadlock.
> Because the writer setting _QW_WAITING is done in the slowpath,
> serialized with the qrwlock->lock, right?

_QW_WAITING can only be set when the writer is at the queue head, and it 
will become _QW_LOCKED when it gets the lock. When a reader becomes 
queue head, the writer byte can either be 0 or _QW_LOCKED, but it can 
never be _QW_WAITING.

>>   	*/
>> -	while (atomic_read(&lock->cnts)&  _QW_WMASK)
>> -		cpu_relax_lowlatency();
>> -
>>   	cnts = atomic_add_return(_QR_BIAS,&lock->cnts) - _QR_BIAS;
> Nit: since 'cnts' is now only the original value of lock->cnts before
> adding _QR_BIAS, could we rename it to 'prev_cnts' (or something)? --
> iirc you removed the need for the variable when in interrupt context.

The subtraction sign is there to simulate an xadd instruction. Without 
that, the generated code will have an additional add instruction. Yes, 
it is kind of a hack. It will be changed later on when other 
architectures start using qrwlock.

Cheers,
Longman
