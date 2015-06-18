From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v3 1/2] locking/qrwlock: Better optimization for interrupt
 context readers
Date: Wed, 17 Jun 2015 21:30:10 -0400
Message-ID: <55821F22.9040902@hp.com>
References: <1434407043-18741-1-git-send-email-Waiman.Long@hp.com> <1434407043-18741-2-git-send-email-Waiman.Long@hp.com> <20150616121742.GB30522@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g4t3427.houston.hp.com ([15.201.208.55]:43153 "EHLO
	g4t3427.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753281AbbFRBaQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 17 Jun 2015 21:30:16 -0400
In-Reply-To: <20150616121742.GB30522@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>

On 06/16/2015 08:17 AM, Will Deacon wrote:
> Hi Waiman,
>
> On Mon, Jun 15, 2015 at 11:24:02PM +0100, Waiman Long wrote:
>> The qrwlock is fair in the process context, but becoming unfair when
>> in the interrupt context to support use cases like the tasklist_lock.
>>
>> The current code isn't that well-documented on what happens when
>> in the interrupt context. The rspin_until_writer_unlock() will only
>> spin if the writer has gotten the lock. If the writer is still in the
>> waiting state, the increment in the reader count will cause the writer
>> to remain in the waiting state and the new interrupt context reader
>> will get the lock and return immediately. The current code, however,
>> do an additional read of the lock value which is not necessary as the
>> information have already been there in the fast path. This may sometime
>> cause an additional cacheline load when the lock is highly contended.
>>
>> This patch passes the lock value information gotten in the fast path
>> to the slow path to eliminate the additional read. It also clarify the
>> action for the interrupt context readers more explicitly.
>>
>> Signed-off-by: Waiman Long<Waiman.Long@hp.com>
>> ---
>>   include/asm-generic/qrwlock.h |    4 ++--
>>   kernel/locking/qrwlock.c      |   14 ++++++++------
>>   2 files changed, 10 insertions(+), 8 deletions(-)
> [...]
>
>> diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
>> index 00c12bb..d7d7557 100644
>> --- a/kernel/locking/qrwlock.c
>> +++ b/kernel/locking/qrwlock.c
>> @@ -43,22 +43,24 @@ rspin_until_writer_unlock(struct qrwlock *lock, u32 cnts)
>>    * queue_read_lock_slowpath - acquire read lock of a queue rwlock
>>    * @lock: Pointer to queue rwlock structure
>>    */
>> -void queue_read_lock_slowpath(struct qrwlock *lock)
>> +void queue_read_lock_slowpath(struct qrwlock *lock, u32 cnts)
>>   {
>> -	u32 cnts;
>> -
>>   	/*
>>   	 * Readers come here when they cannot get the lock without waiting
>>   	 */
>>   	if (unlikely(in_interrupt())) {
>>   		/*
>> -		 * Readers in interrupt context will spin until the lock is
>> -		 * available without waiting in the queue.
>> +		 * Readers in interrupt context will get the lock immediately
>> +		 * if the writer is just waiting (not holding the lock yet)
>> +		 * or they will spin until the lock is available without
>> +		 * waiting in the queue.
>>   		 */
>> -		cnts = smp_load_acquire((u32 *)&lock->cnts);
>> +		if ((cnts&  _QW_WMASK) != _QW_LOCKED)
>> +			return;
> I really doubt the check here is gaining you any performance, given
> rspin_until_write_unlock does the same check immediately and should be
> inlined. Just dropping the acquire and passing cnts through should be
> sufficient.

Yes, you are right. I can just pass the cnt to 
rspin_until_write_unlock() and be done with it.

Cheers,
Longman
