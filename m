From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH RFC v6 09/11] pvqspinlock,
	x86: Add qspinlock para-virtualization support
Date: Thu, 13 Mar 2014 15:05:57 -0400
Message-ID: <53220195.6090108@hp.com>
References: <1394650498-30118-1-git-send-email-Waiman.Long@hp.com>
	<1394650498-30118-10-git-send-email-Waiman.Long@hp.com>
	<5321949F.1010103@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5321949F.1010103@citrix.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Vrabel <david.vrabel@citrix.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Michel Lespinasse <walken@google.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, Gleb Natapov <gleb@redhat.com>, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Scott J Norton <scott.norton@hp.com>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, Oleg Nesterov <oleg@redhat.com>, Alok Kataria <akataria@vmware.com>, Aswin Chandramouleeswaran <aswin@hp.com>, Chegu Vinod <chegu>
List-Id: linux-arch.vger.kernel.org

On 03/13/2014 07:21 AM, David Vrabel wrote:
> On 12/03/14 18:54, Waiman Long wrote:
>> This patch adds para-virtualization support to the queue spinlock in
>> the same way as was done in the PV ticket lock code. In essence, the
>> lock waiters will spin for a specified number of times (QSPIN_THRESHOLD
>> = 2^14) and then halted itself. The queue head waiter will spins
>> 2*QSPIN_THRESHOLD times before halting itself. When it has spinned
>> QSPIN_THRESHOLD times, the queue head will assume that the lock
>> holder may be scheduled out and attempt to kick the lock holder CPU
>> if it has the CPU number on hand.
> I don't really understand the reasoning for kicking the lock holder.  It
> will either be: running, runnable, or halted because it's in a slow path
> wait for another lock.  In any of these states I do not see how a kick
> is useful.

You may be right. I can certainly take this part out of the patch if 
people don't think that is useful.

>> Enabling the PV code does have a performance impact on spinlock
>> acquisitions and releases. The following table shows the execution
>> time (in ms) of a spinlock micro-benchmark that does lock/unlock
>> operations 5M times for each task versus the number of contending
>> tasks on a Westmere-EX system.
>>
>>    # of        Ticket lock	     Queue lock
>>    tasks   PV off/PV on/%Change 	  PV off/PV on/%Change
>>    ------  --------------------   ---------------------
>>      1	     135/  179/+33%	     137/  169/+23%
>>      2	    1045/ 1103/ +6%	    1120/ 1536/+37%
>>      3	    1827/ 2683/+47%	    2313/ 2425/ +5%
>>      4       2689/ 4191/+56%	    2914/ 3128/ +7%
>>      5       3736/ 5830/+56%	    3715/ 3762/ +1%
>>      6       4942/ 7609/+54%	    4504/ 4558/ +2%
>>      7       6304/ 9570/+52%	    5292/ 5351/ +1%
>>      8       7736/11323/+46%	    6037/ 6097/ +1%
> Do you have measurements from tests when VCPUs are overcommitted?

I don't have a measurement with overcommitted guests yet. I will set up 
such an environment and do some tests on it.

>> +#ifdef CONFIG_PARAVIRT_SPINLOCKS
>> +/**
>> + * queue_spin_unlock_slowpath - kick up the CPU of the queue head
>> + * @lock : Pointer to queue spinlock structure
>> + *
>> + * The lock is released after finding the queue head to avoid racing
>> + * condition between the queue head and the lock holder.
>> + */
>> +void queue_spin_unlock_slowpath(struct qspinlock *lock)
>> +{
>> +	struct qnode *node, *prev;
>> +	u32 qcode = (u32)queue_get_qcode(lock);
>> +
>> +	/*
>> +	 * Get the queue tail node
>> +	 */
>> +	node = xlate_qcode(qcode);
>> +
>> +	/*
>> +	 * Locate the queue head node by following the prev pointer from
>> +	 * tail to head.
>> +	 * It is assumed that the PV guests won't have that many CPUs so
>> +	 * that it won't take a long time to follow the pointers.
> This isn't a valid assumption, but this isn't that different from the
> search done in the ticket slow unlock path so I guess it's ok.
>
> David

I will change that to say that in most cases, the queue length will be 
short.

-Longman
