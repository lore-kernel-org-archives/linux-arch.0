From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v15 13/15] pvqspinlock: Only kick CPU at unlock time
Date: Thu, 09 Apr 2015 18:06:01 -0400
Message-ID: <5526F7C9.1020600@hp.com>
References: <1428375350-9213-1-git-send-email-Waiman.Long@hp.com> <1428375350-9213-14-git-send-email-Waiman.Long@hp.com> <20150409195721.GA5029@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g1t5425.austin.hp.com ([15.216.225.55]:39348 "EHLO
	g1t5425.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876AbbDIWGK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Apr 2015 18:06:10 -0400
In-Reply-To: <20150409195721.GA5029@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, David Vrabel <david.vrabel@citrix.com>, Oleg Nesterov <oleg@redhat.com>, Daniel J Blueman <daniel@numascale.com>, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>

On 04/09/2015 03:57 PM, Peter Zijlstra wrote:
> On Mon, Apr 06, 2015 at 10:55:48PM -0400, Waiman Long wrote:
>
>> @@ -219,24 +236,30 @@ static void pv_wait_node(struct mcs_spinlock *node)
>>   }
>>
>>   /*
>> + * Called after setting next->locked = 1&  lock acquired.
>> + * Check if the the CPU has been halted. If so, set the _Q_SLOW_VAL flag
>> + * and put an entry into the lock hash table to be waken up at unlock time.
>>    */
>> -static void pv_kick_node(struct mcs_spinlock *node)
>> +static void pv_scan_next(struct qspinlock *lock, struct mcs_spinlock *node)
> I'm not too sure about that name change..

It is because the function will no longer kick the cpu. So I change the 
name to reflect that. I am not good at naming. Please let me know if you 
have a better name.

Cheers,
Longman
