From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH RFC v5 4/8] pvqspinlock, x86: Allow unfair spinlock in
	a real PV environment
Date: Fri, 28 Feb 2014 12:06:39 -0500
Message-ID: <5310C21F.7000809@hp.com>
References: <1393427668-60228-1-git-send-email-Waiman.Long@hp.com>
	<1393427668-60228-5-git-send-email-Waiman.Long@hp.com>
	<20140226170734.GB20775@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140226170734.GB20775@phenom.dumpdata.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Michel Lespinasse <walken@google.com>, Alok Kataria <akataria@vmware.com>, linux-arch@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, Scott J Norton <scott.norton@hp.com>, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Alexander Fyodorov <halcy@yandex.ru>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Daniel J Blueman <daniel@numascale.com>, Oleg Nesterov <oleg@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, George Spelvin <linux@horizon.com>, Thomas Gleixner <tglx@linutronix.de>, Aswin Chandramouleeswaran <aswin@hp.com>, Cheg
List-Id: linux-arch.vger.kernel.org

On 02/26/2014 12:07 PM, Konrad Rzeszutek Wilk wrote:
> On Wed, Feb 26, 2014 at 10:14:24AM -0500, Waiman Long wrote:
>> Locking is always an issue in a virtualized environment as the virtual
>> CPU that is waiting on a lock may get scheduled out and hence block
>> any progress in lock acquisition even when the lock has been freed.
>>
>> One solution to this problem is to allow unfair lock in a
>> para-virtualized environment. In this case, a new lock acquirer can
>> come and steal the lock if the next-in-line CPU to get the lock is
>> scheduled out. Unfair lock in a native environment is generally not a
> Hmm, how do you know if the 'next-in-line CPU' is scheduled out? As
> in the hypervisor knows - but you as a guest might have no idea
> of it.

I use a heart-beat counter to see if the other side responses within a 
certain time limit. If not, I assume it has been scheduled out probably 
due to PLE.

>> good idea as there is a possibility of lock starvation for a heavily
>> contended lock.
> Should this then detect whether it is running under a virtualization
> and only then activate itself? And when run under baremetal don't enable?

Yes, unfair lock should only be enabled if it is running under a 
para-virtualized guest. A jump label (static key) is used for this 
purpose and will be enabled by the appropriate KVM or Xen code.

>> This patch add a new configuration option for the x86
>> architecture to enable the use of unfair queue spinlock
>> (PARAVIRT_UNFAIR_LOCKS) in a real para-virtualized guest. A jump label
>> (paravirt_unfairlocks_enabled) is used to switch between a fair and
>> an unfair version of the spinlock code. This jump label will only be
>> enabled in a real PV guest.
> As opposed to fake PV guest :-) I think you can remove the 'real'.

Yes, you are right. I will remove that in the next series.

>
>> Enabling this configuration feature decreases the performance of an
>> uncontended lock-unlock operation by about 1-2%.
> Presumarily on baremetal right?

Enabling unfair lock will add additional code which has a slight 
performance penalty of 1-2% on both bare-metal and virtualized.

>> +/**
>> + * arch_spin_lock - acquire a queue spinlock
>> + * @lock: Pointer to queue spinlock structure
>> + */
>> +static inline void arch_spin_lock(struct qspinlock *lock)
>> +{
>> +	if (static_key_false(&paravirt_unfairlocks_enabled)) {
>> +		queue_spin_lock_unfair(lock);
>> +		return;
>> +	}
>> +	queue_spin_lock(lock);
> What happens when you are booting and you are in the middle of using a
> ticketlock (say you are waiting for it and your are in the slow-path)
>   and suddenly the unfairlocks_enabled is turned on.

The static key will only be changed only in the early boot period which 
I presumably doesn't need to use spinlock. This static key is 
initialized in the same way as the PV ticketlock's static key which has 
the same problem that you mentioned.

-Longman
