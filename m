From: Waiman Long <waiman.long@hp.com>
Subject: Re: [Xen-devel] [PATCH v15 12/15] pvqspinlock, x86: Enable PV qspinlock
 for Xen
Date: Wed, 08 Apr 2015 13:42:49 -0400
Message-ID: <55256899.4040603@hp.com>
References: <1428375350-9213-1-git-send-email-Waiman.Long@hp.com> <1428375350-9213-13-git-send-email-Waiman.Long@hp.com> <552518A0.10205@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g4t3427.houston.hp.com ([15.201.208.55]:38179 "EHLO
	g4t3427.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753088AbbDHRnA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 Apr 2015 13:43:00 -0400
In-Reply-To: <552518A0.10205@citrix.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Vrabel <david.vrabel@citrix.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, kvm@vger.kernel.org, Daniel J Blueman <daniel@numascale.com>, x86@kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Scott J Norton <scott.norton@hp.com>, Oleg Nesterov <oleg@redhat.com>, xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Douglas Hatch <doug.hatch@hp.com>

On 04/08/2015 08:01 AM, David Vrabel wrote:
> On 07/04/15 03:55, Waiman Long wrote:
>> This patch adds the necessary Xen specific code to allow Xen to
>> support the CPU halting and kicking operations needed by the queue
>> spinlock PV code.
> This basically looks the same as the version I wrote, except I think you
> broke it.
>
>> +static void xen_qlock_wait(u8 *byte, u8 val)
>> +{
>> +	int irq = __this_cpu_read(lock_kicker_irq);
>> +
>> +	/* If kicker interrupts not initialized yet, just spin */
>> +	if (irq == -1)
>> +		return;
>> +
>> +	/* clear pending */
>> +	xen_clear_irq_pending(irq);
>> +
>> +	/*
>> +	 * We check the byte value after clearing pending IRQ to make sure
>> +	 * that we won't miss a wakeup event because of the clearing.
> My version had a barrier() here to ensure this.  The documentation of
> READ_ONCE() suggests that it is not sufficient to meet this requirement
> (and a READ_ONCE() here is not required anyway).

I have the misconception that a READ_ONCE/WRITE_ONCE() implies a 
compiler barrier. You are right that it may not be the case. I will add 
back the missing barrier when I update the patch and add you as the 
author of this patch if you don't mind.

Cheers,
Longman
