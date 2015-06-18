From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v3 2/2] locking/qrwlock: Don't contend with readers when
 setting _QW_WAITING
Date: Wed, 17 Jun 2015 21:33:56 -0400
Message-ID: <55822004.8060605@hp.com>
References: <1434407043-18741-1-git-send-email-Waiman.Long@hp.com> <1434407043-18741-3-git-send-email-Waiman.Long@hp.com> <20150616180227.GA2401@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g9t5009.houston.hp.com ([15.240.92.67]:50729 "EHLO
	g9t5009.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754591AbbFRBeC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 17 Jun 2015 21:34:02 -0400
In-Reply-To: <20150616180227.GA2401@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>

On 06/16/2015 02:02 PM, Will Deacon wrote:
> On Mon, Jun 15, 2015 at 11:24:03PM +0100, Waiman Long wrote:
>> The current cmpxchg() loop in setting the _QW_WAITING flag for writers
>> in queue_write_lock_slowpath() will contend with incoming readers
>> causing possibly extra cmpxchg() operations that are wasteful. This
>> patch changes the code to do a byte cmpxchg() to eliminate contention
>> with new readers.
>>
>> A multithreaded microbenchmark running 5M read_lock/write_lock loop
>> on a 8-socket 80-core Westmere-EX machine running 4.0 based kernel
>> with the qspinlock patch have the following execution times (in ms)
>> with and without the patch:
>>
>> With R:W ratio = 5:1
>>
>> 	Threads	   w/o patch	with patch	% change
>> 	-------	   ---------	----------	--------
>> 	   2	     990 	    895		  -9.6%
>> 	   3	    2136 	   1912		 -10.5%
>> 	   4	    3166	   2830		 -10.6%
>> 	   5	    3953	   3629		  -8.2%
>> 	   6	    4628	   4405		  -4.8%
>> 	   7	    5344	   5197		  -2.8%
>> 	   8	    6065	   6004		  -1.0%
>> 	   9	    6826	   6811		  -0.2%
>> 	  10	    7599	   7599		   0.0%
>> 	  15	    9757	   9766		  +0.1%
>> 	  20	   13767	  13817		  +0.4%
>>
>> With small number of contending threads, this patch can improve
>> locking performance by up to 10%. With more contending threads,
>> however, the gain diminishes.
>>
>> Signed-off-by: Waiman Long<Waiman.Long@hp.com>
>> ---
>>   kernel/locking/qrwlock.c |   28 ++++++++++++++++++++++++----
>>   1 files changed, 24 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
>> index d7d7557..559198a 100644
>> --- a/kernel/locking/qrwlock.c
>> +++ b/kernel/locking/qrwlock.c
>> @@ -22,6 +22,26 @@
>>   #include<linux/hardirq.h>
>>   #include<asm/qrwlock.h>
>>
>> +/*
>> + * This internal data structure is used for optimizing access to some of
>> + * the subfields within the atomic_t cnts.
>> + */
>> +struct __qrwlock {
>> +	union {
>> +		atomic_t cnts;
>> +		struct {
>> +#ifdef __LITTLE_ENDIAN
>> +			u8 wmode;	/* Writer mode   */
>> +			u8 rcnts[3];	/* Reader counts */
>> +#else
>> +			u8 rcnts[3];	/* Reader counts */
>> +			u8 wmode;	/* Writer mode   */
>> +#endif
>> +		};
>> +	};
>> +	arch_spinlock_t	lock;
>> +};
>> +
>>   /**
>>    * rspin_until_writer_unlock - inc reader count&  spin until writer is gone
>>    * @lock  : Pointer to queue rwlock structure
>> @@ -109,10 +129,10 @@ void queue_write_lock_slowpath(struct qrwlock *lock)
>>   	 * or wait for a previous writer to go away.
>>   	 */
>>   	for (;;) {
>> -		cnts = atomic_read(&lock->cnts);
>> -		if (!(cnts&  _QW_WMASK)&&
>> -		    (atomic_cmpxchg(&lock->cnts, cnts,
>> -				    cnts | _QW_WAITING) == cnts))
>> +		struct __qrwlock *l = (struct __qrwlock *)lock;
>> +
>> +		if (!READ_ONCE(l->wmode)&&
>> +		   (cmpxchg(&l->wmode, 0, _QW_WAITING) == 0))
>>   			break;
> Maybe you could also update the x86 implementation of queue_write_unlock
> to write the wmode field instead of casting to u8 *?
>
> Will

The queue_write_unlock() function is in the header file. I don't want to 
expose the internal structure to other files.

Cheers,
Longman
