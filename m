From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v5 3/3] locking/qrwlock: Don't contend with readers when
 setting _QW_WAITING
Date: Mon, 22 Jun 2015 22:57:48 -0400
Message-ID: <5588CB2C.108@hp.com>
References: <1434729002-57724-1-git-send-email-Waiman.Long@hp.com> <1434729002-57724-4-git-send-email-Waiman.Long@hp.com> <20150622162123.GI1583@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g2t2353.austin.hp.com ([15.217.128.52]:20567 "EHLO
	g2t2353.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731AbbFWC5x (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 22 Jun 2015 22:57:53 -0400
In-Reply-To: <20150622162123.GI1583@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>

On 06/22/2015 12:21 PM, Will Deacon wrote:
> Hi Waiman,
>
> On Fri, Jun 19, 2015 at 04:50:02PM +0100, Waiman Long wrote:
>> The current cmpxchg() loop in setting the _QW_WAITING flag for writers
>> in queue_write_lock_slowpath() will contend with incoming readers
>> causing possibly extra cmpxchg() operations that are wasteful. This
>> patch changes the code to do a byte cmpxchg() to eliminate contention
>> with new readers.
> [...]
>
>> diff --git a/arch/x86/include/asm/qrwlock.h b/arch/x86/include/asm/qrwlock.h
>> index a8810bf..5678b0a 100644
>> --- a/arch/x86/include/asm/qrwlock.h
>> +++ b/arch/x86/include/asm/qrwlock.h
>> @@ -7,8 +7,7 @@
>>   #define queued_write_unlock queued_write_unlock
>>   static inline void queued_write_unlock(struct qrwlock *lock)
>>   {
>> -        barrier();
>> -        ACCESS_ONCE(*(u8 *)&lock->cnts) = 0;
>> +	smp_store_release(&lock->wmode, 0);
>>   }
>>   #endif
> I reckon you could actually use this in the asm-generic header and remove
> the x86 arch version altogether. Most architectures support single-copy
> atomic byte access and those that don't (alpha?) can just not use qrwlock
> (or override write_unlock with atomic_sub).
>
> I already have a patch making this change, so I'm happy either way.

Yes, I am aware of that. If you have a patch to make that change, I am 
fine with that too.

Cheers,
Longman
