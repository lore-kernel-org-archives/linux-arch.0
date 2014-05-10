Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from g6t1525.atlanta.hp.com ([15.193.200.68]:56400 "EHLO
	g6t1525.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757281AbaEJBGb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 9 May 2014 21:06:31 -0400
Message-ID: <536D7B80.7080301@hp.com>
Date: Fri, 09 May 2014 21:06:08 -0400
From: Waiman Long <waiman.long@hp.com>
MIME-Version: 1.0
Subject: Re: [PATCH v10 07/19] qspinlock: Use a simple write to grab the lock,
 if applicable
References: <1399474907-22206-1-git-send-email-Waiman.Long@hp.com> <1399474907-22206-8-git-send-email-Waiman.Long@hp.com> <20140508190203.GP2844@laptop.programming.kicks-ass.net>
In-Reply-To: <20140508190203.GP2844@laptop.programming.kicks-ass.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, David Vrabel <david.vrabel@citrix.com>, Oleg Nesterov <oleg@redhat.com>, Gleb Natapov <gleb@redhat.com>, Scott J Norton <scott.norton@hp.com>, Chegu Vinod <chegu_vinod@hp.com>
Message-ID: <20140510010608.nwTAjSdr8l49CgLASnusL-vMbUVVhC63jWwLuWDmpRc@z>

On 05/08/2014 03:02 PM, Peter Zijlstra wrote:
> On Wed, May 07, 2014 at 11:01:35AM -0400, Waiman Long wrote:
>>   /**
>> + * get_qlock - Set the lock bit and own the lock
>> + * @lock: Pointer to queue spinlock structure
>> + *
>> + * This routine should only be called when the caller is the only one
>> + * entitled to acquire the lock.
>> + */
>> +static __always_inline void get_qlock(struct qspinlock *lock)
> set_locked()
>
>> +{
>> +	struct __qspinlock *l = (void *)lock;
>> +
>> +	barrier();
>> +	ACCESS_ONCE(l->locked) = _Q_LOCKED_VAL;
>> +	barrier();
>> +}
> get_qlock() is just horrible. The function doesn't actually _get_
> anything, and qlock is not in line with the rest of the naming.

Sure, I will make the change.

-Longman
