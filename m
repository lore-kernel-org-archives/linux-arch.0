From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [RFC 0/2] Reenable might_sleep() checks for might_fault() when
 atomic
Date: Wed, 26 Nov 2014 17:51:08 +0100
Message-ID: <547604FC.4030300@de.ibm.com>
References: <1416915806-24757-1-git-send-email-dahi@linux.vnet.ibm.com> <20141126070258.GA25523@redhat.com> <20141126110504.511b733a@thinkpad-w530> <20141126151729.GB9612@redhat.com> <20141126152334.GA9648@redhat.com> <20141126163207.63810fcb@thinkpad-w530> <20141126154717.GB10568@redhat.com> <5475FAB1.1000802@de.ibm.com> <20141126163216.GB10850@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp12.uk.ibm.com ([195.75.94.108]:52263 "EHLO
	e06smtp12.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752754AbaKZQvS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 26 Nov 2014 11:51:18 -0500
Received: from /spool/local
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <borntraeger@de.ibm.com>;
	Wed, 26 Nov 2014 16:51:16 -0000
In-Reply-To: <20141126163216.GB10850@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: David Hildenbrand <dahi@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, benh@kernel.crashing.org, paulus@samba.org, akpm@linux-foundation.org, heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com, mingo@kernel.org

Am 26.11.2014 um 17:32 schrieb Michael S. Tsirkin:
[...]
>>>> This is what happened on our side (very recent kernel):
>>>>
>>>> spin_lock(&lock)
>>>> copy_to_user(...)
>>>> spin_unlock(&lock)
>>>
>>> That's a deadlock even without copy_to_user - it's
>>> enough for the thread to be preempted and another one
>>> to try taking the lock.
>>
>> Huh? With CONFIG_PREEMPT spin_lock will disable preemption. (we had preempt = server anyway).
> 
> Are you sure? Can you point me where it does this please?

spin_lock --> raw_spin_lock --> _raw_spin_lock --> __raw_spin_lock

static inline void __raw_spin_lock(raw_spinlock_t *lock)
{
---->   preempt_disable();   <-----
        spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
        LOCK_CONTENDED(lock, do_raw_spin_trylock, do_raw_spin_lock);
}


Michael, please be serious. The whole kernel would be broken if spin_lock would not disable preemption.


> 
>> But please: One step back. The problem is not the good path. The problem is that we lost a debugging aid for a known to be broken case. In other words: Our code had a bug. Older kernels detected that kind of bug. With your change we no longer saw the sleeping while atomic. Thats it. See my other mail.
>>
>> Christian
> 
> You want to add more debugging tools, fine.

We dont want to add, we want to fix something that used to work

> But this one was > giving users in field false positives.

So lets try to fix those, ok? If we cant, then tough luck. But coming up with wrong statements is not helpful.

> 
> The point is that *_user is safe with preempt off.
> It returns an error gracefully.
> It does not sleep.
> It does not trigger the scheduler in that context.

There are special cases where your statement is true. But its not in general.
copy_to_user might fault and that fault might sleep and reschedule. For example handle_mm_fault might go down to pud_alloc, pmd_alloc etc and all these functions could do an GFP_KERNEL allocation. Which might sleep. Which will schedule.


> 
> 
> David's patch makes it say it does, so it's wrong.
> 
> 
> 
