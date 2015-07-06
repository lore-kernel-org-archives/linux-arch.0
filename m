Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from g4t3426.houston.hp.com ([15.201.208.54]:43683 "EHLO
	g4t3426.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754469AbbGFTth (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 6 Jul 2015 15:49:37 -0400
Message-ID: <559ADBCD.6020803@hp.com>
Date: Mon, 06 Jul 2015 15:49:33 -0400
From: Waiman Long <waiman.long@hp.com>
MIME-Version: 1.0
Subject: Re: [PATCH 2/4] locking/qrwlock: Reduce reader/writer to reader lock
 transfer latency
References: <1436197386-58635-1-git-send-email-Waiman.Long@hp.com> <1436197386-58635-3-git-send-email-Waiman.Long@hp.com> <20150706182353.GC1607@arm.com>
In-Reply-To: <20150706182353.GC1607@arm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>
Message-ID: <20150706194933.vvUA3N0X5v5h2TamFYYh1lkeHjNqmMNyUqQk_uUGH8c@z>

On 07/06/2015 02:23 PM, Will Deacon wrote:
> Hi Waiman,
>
> On Mon, Jul 06, 2015 at 04:43:04PM +0100, Waiman Long wrote:
>> Currently, a reader will check first to make sure that the writer mode
>> byte is cleared before incrementing the reader count. That waiting is
>> not really necessary. It increases the latency in the reader/writer
>> to reader transition and reduces readers performance.
>>
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
>>
>> Signed-off-by: Waiman Long<Waiman.Long@hp.com>
> I've just finished rebasing my arm64 qrwlock stuff, but I think it will
> conflict with these patches. Do you mind if I post them for review anyway,
> so we can at least co-ordinate our efforts?

Yes, sure. I would also like to coordinate my changes with yours to 
minimize conflict. BTW, I just got 2 tip-bot messages about the commits:

    locking/qrwlock:  Better optimization for interrupt context readers
    locking/qrwlock:  Rename functions to queued_*()

So I need to rebase my patches also.

>> ---
>>   kernel/locking/qrwlock.c |   12 ++++--------
>>   1 files changed, 4 insertions(+), 8 deletions(-)
>>
>> diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
>> index 81bae99..ecd2d19 100644
>> --- a/kernel/locking/qrwlock.c
>> +++ b/kernel/locking/qrwlock.c
>> @@ -88,15 +88,11 @@ void queue_read_lock_slowpath(struct qrwlock *lock, u32 cnts)
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
>> +	 * At ths stage, it is not possible for a writer to remain in the
>> +	 * waiting state (_QW_WAITING). So there won't be any deadlock.
>>   	 */
>> -	while (atomic_read(&lock->cnts)&  _QW_WMASK)
>> -		cpu_relax_lowlatency();
> Thinking about it, can we kill _QW_WAITING altogether and set (cmpxchg
> from 0) wmode to _QW_LOCKED in the write_lock slowpath, polling (acquire)
> rmode until it hits zero?

No, this is how we make the lock fair so that an incoming streams of 
later readers won't block a writer from getting the lock.

Cheers,
Longman
