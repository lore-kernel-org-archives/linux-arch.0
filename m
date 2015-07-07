From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH 2/4] locking/qrwlock: Reduce reader/writer to reader lock
 transfer latency
Date: Tue, 07 Jul 2015 17:29:50 -0400
Message-ID: <559C44CE.7070701@hp.com>
References: <1436197386-58635-1-git-send-email-Waiman.Long@hp.com> <1436197386-58635-3-git-send-email-Waiman.Long@hp.com> <20150706182353.GC1607@arm.com> <559ADBCD.6020803@hp.com> <20150707091711.GA23879@arm.com> <20150707111731.GQ3644@twins.programming.kicks-ass.net> <20150707114918.GG23879@arm.com> <559BE27E.6060901@hp.com> <20150707172718.GJ23879@arm.com> <20150707181002.GK23879@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g9t5008.houston.hp.com ([15.240.92.66]:33512 "EHLO
	g9t5008.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754468AbbGGV3y (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 7 Jul 2015 17:29:54 -0400
In-Reply-To: <20150707181002.GK23879@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>

On 07/07/2015 02:10 PM, Will Deacon wrote:
> On Tue, Jul 07, 2015 at 06:27:18PM +0100, Will Deacon wrote:
>> On Tue, Jul 07, 2015 at 03:30:22PM +0100, Waiman Long wrote:
>>> On 07/07/2015 07:49 AM, Will Deacon wrote:
>>>> On Tue, Jul 07, 2015 at 12:17:31PM +0100, Peter Zijlstra wrote:
>>>>> On Tue, Jul 07, 2015 at 10:17:11AM +0100, Will Deacon wrote:
>>>>>>>> Thinking about it, can we kill _QW_WAITING altogether and set (cmpxchg
>>>>>>>> from 0) wmode to _QW_LOCKED in the write_lock slowpath, polling (acquire)
>>>>>>>> rmode until it hits zero?
>>>>>>> No, this is how we make the lock fair so that an incoming streams of
>>>>>>> later readers won't block a writer from getting the lock.
>>>>>> But won't those readers effectively see that the lock is held for write
>>>>>> (because we set wmode to _QW_LOCKED before the existing reader had drained)
>>>>>> and therefore fall down the slow-path and get held up on the spinlock?
>>>>> Yes, that's the entire point. Once there's a writer pending, new readers
>>>>> should queue too.
>>>> Agreed. My point was that we can achieve the same result without
>>>> a separate _QW_WAITING flag afaict.
>>> _QW_WAITING and _QW_LOCKED has different semantics and are necessary for
>>> the proper handshake between readers and writer. We set _QW_WAITING when
>>> readers own the lock and the writer is waiting for the readers to go
>>> away. The _QW_WAITING flag will force new readers to go to queuing while
>>> the writer is waiting. We set _QW_LOCKED when a writer own the lock and
>>> it can only be set atomically when no reader is present. Without the
>>> intermediate _QW_WAITING step, a continuous stream of incoming readers
>>> (which make the reader count never 0) could deny a writer from getting
>>> the lock indefinitely.
>> It's probably best if I try to implement something and we can either pick
>> holes in the patch or I'll realise why I'm wrong in the process :)
> Hmm, wasn't very enlightening. What's wrong with the following?
>
> Will
>
> --->8
>
> diff --git a/include/asm-generic/qrwlock.h b/include/asm-generic/qrwlock.h
> index deb9e8b0eb9e..be8dc5c6fdbd 100644
> --- a/include/asm-generic/qrwlock.h
> +++ b/include/asm-generic/qrwlock.h
> @@ -27,7 +27,6 @@
>   /*
>    * Writer states&  reader shift and bias
>    */
> -#define        _QW_WAITING     1               /* A writer is waiting     */
>   #define        _QW_LOCKED      0xff            /* A writer holds the lock */
>   #define        _QW_WMASK       0xff            /* Writer mask             */
>   #define        _QR_SHIFT       8               /* Reader count shift      */
> diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
> index 9f644933f6d4..4006aa1fbd0b 100644
> --- a/kernel/locking/qrwlock.c
> +++ b/kernel/locking/qrwlock.c
> @@ -127,28 +127,23 @@ void queued_write_lock_slowpath(struct qrwlock *lock)
>          }
>
>          /*
> -        * Set the waiting flag to notify readers that a writer is pending,
> -        * or wait for a previous writer to go away.
> +        * Wait for a previous writer to go away, then set the locked
> +        * flag to notify future readers/writers that we are pending.
>           */
>          for (;;) {
>                  struct __qrwlock *l = (struct __qrwlock *)lock;
>
>                  if (!READ_ONCE(l->wmode)&&
> -                  (cmpxchg(&l->wmode, 0, _QW_WAITING) == 0))
> +                  (cmpxchg(&l->wmode, 0, _QW_LOCKED) == 0))
>                          break;
>
>                  cpu_relax_lowlatency();
>          }
>
> -       /* When no more readers, set the locked flag */
> -       for (;;) {
> -               if ((atomic_read(&lock->cnts) == _QW_WAITING)&&
> -                   (atomic_cmpxchg(&lock->cnts, _QW_WAITING,
> -                                   _QW_LOCKED) == _QW_WAITING))
> -                       break;
> -
> +       /* Wait for the readers to drain */
> +       while (smp_load_acquire((u32 *)&lock->cnts)&  ~_QW_WMASK)
>                  cpu_relax_lowlatency();
> -       }
> +
>   unlock:
>          arch_spin_unlock(&lock->lock);
>   }

That changes the handshaking protocol. In this case, the readers will 
have to decrement its reader count to enable the writer to continue. The 
interrupt context reader code has to be changed. This gives preference 
to writer and reader will be in a disadvantage. I prefer the current 
setting as you won't know if the writer has the lock or not when you 
take a snapshot of the value of the lock. You need the whole time 
sequence in this case to figure it out and so will be more prone to error.

Cheers,
Longman
