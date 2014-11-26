From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [RFC 0/2] Reenable might_sleep() checks for might_fault() when
 atomic
Date: Wed, 26 Nov 2014 17:02:35 +0100
Message-ID: <5475F99B.3090307@de.ibm.com>
References: <1416915806-24757-1-git-send-email-dahi@linux.vnet.ibm.com> <20141126070258.GA25523@redhat.com> <20141126110504.511b733a@thinkpad-w530> <20141126151729.GB9612@redhat.com> <5475F218.4050207@de.ibm.com> <20141126153732.GA10568@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141126153732.GA10568@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: David Hildenbrand <dahi@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, benh@kernel.crashing.org, paulus@samba.org, akpm@linux-foundation.org, heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com, mingo@kernel.org
List-Id: linux-arch.vger.kernel.org

Am 26.11.2014 um 16:37 schrieb Michael S. Tsirkin:
> On Wed, Nov 26, 2014 at 04:30:32PM +0100, Christian Borntraeger wrote:
>> Am 26.11.2014 um 16:17 schrieb Michael S. Tsirkin:
>>> On Wed, Nov 26, 2014 at 11:05:04AM +0100, David Hildenbrand wrote:
>>>>> What's the path you are trying to debug?
>>>>
>>>> Well, we had a problem where we held a spin_lock and called
>>>> copy_(from|to)_user(). We experienced very random deadlocks that took some guy
>>>> almost a week to debug. The simple might_sleep() check would have showed this
>>>> error immediately.
>>>
>>
>>> This must have been a very old kernel.
>>> A modern kernel will return an error from copy_to_user.
>>
>> I disagree. copy_to_user will not return while holding a spinlock, because it does not know! How should it?
>> See: spin_lock will call preempt_disable, but thats a no-op for a non-preempt kernel. So the mere fact that we hold a spin_lock is not known by any user access function. (or others). No?
>>
>> Christian
>>
>>
> 
> Well might_sleep() merely checks preempt count and irqs_disabled too.
> If you want debugging things to trigger, you need to enable
> a bunch of config options.  That's not new.

You miss the point of the whole thread: The problem is that even with debug options enabled, holding a spinlock would not trigger a bug on copy_to_user. So the problem is not the good path, the problem is that a debugging aid for detecting a broken case was lost. Even with all kernel debugging enabled.

That is because CONFIG_DEBUG_ATOMIC_SLEEP selects PREEMPT_COUNT. That means: spin_lock will then be considered as in_atomic and no message comes. Without CONFIG_DEBUG_ATOMIC_SLEEP spin_lock will not touch the preempt_count but we also dont see a message because might_fault is now a nop

I understand that you dont like Davids changes due to other side effects that you have mentioned. So lets focus on how we can fix the debug option. Ok?

Christian
