From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH RFC v5 7/8] pvqspinlock,
	x86: Add qspinlock para-virtualization support
Date: Thu, 27 Feb 2014 16:50:31 +0100
Message-ID: <530F5EC7.4060603@redhat.com>
References: <1393427668-60228-1-git-send-email-Waiman.Long@hp.com>
	<1393427668-60228-8-git-send-email-Waiman.Long@hp.com>
	<530F2B8F.1010401@citrix.com> <530F3967.6030805@redhat.com>
	<530F4949.4050706@citrix.com> <530F4F98.2080308@redhat.com>
	<530F5851.1090809@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <530F5851.1090809@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, David Vrabel <david.vrabel@citrix.com>, Waiman Long <Waiman.Long@hp.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Michel Lespinasse <walken@google.com>, Alok Kataria <akataria@vmware.com>, linux-arch@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, Scott J Norton <scott.norton@hp.com>, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Alexander Fyodorov <halcy@yandex.ru>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Daniel J Blueman <daniel@numascale.com>, Oleg Nesterov <oleg@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, George Spelvin <linux@horizon.com>, Thomas Gleixner <tglx@linutronix.de>, Aswin Chandramouleeswaran <aswin@hp.com>, Chegu
List-Id: linux-arch.vger.kernel.org

Il 27/02/2014 16:22, Raghavendra K T ha scritto:
> On 02/27/2014 08:15 PM, Paolo Bonzini wrote:
> [...]
>>> But neither of the VCPUs being kicked here are halted -- they're either
>>> running or runnable (descheduled by the hypervisor).
>>
>> /me actually looks at Waiman's code...
>>
>> Right, this is really different from pvticketlocks, where the *unlock*
>> primitive wakes up a sleeping VCPU.  It is more similar to PLE
>> (pause-loop exiting).
>
> Adding to the discussion, I see there are two possibilities here,
> considering that in undercommit cases we should not exceed
> HEAD_SPIN_THRESHOLD,
>
> 1. the looping vcpu in pv_head_spin_check() should do halt()
> considering that we have done enough spinning (more than typical
> lock-hold time), and hence we are in potential overcommit.
>
> 2. multiplex kick_cpu to do directed yield in qspinlock case.
> But this may result in some ping ponging?

Actually, I think the qspinlock can work roughly the same as the 
pvticketlock, using the same lock_spinning and unlock_lock hooks.

The x86-specific codepath can use bit 1 in the ->wait byte as "I have 
halted, please kick me".

	value = _QSPINLOCK_WAITING;
	i = 0;
	do
		cpu_relax();
	while (ACCESS_ONCE(slock->lock) && i++ < BUSY_WAIT);
	if (ACCESS_ONCE(slock->lock)) {
		value |= _QSPINLOCK_HALTED;
		xchg(&slock->wait, value >> 8);
		if (ACCESS_ONCE(slock->lock)) {
			... call lock_spinning hook ...
		}
	}

	/*
	 * Set the lock bit & clear the halted+waiting bits
	 */
	if (cmpxchg(&slock->lock_wait, value,
		    _QSPINLOCK_LOCKED) == value)
		return -1;	/* Got the lock */
	__atomic_and(&slock->lock_wait, ~QSPINLOCK_HALTED);

The lock_spinning/unlock_lock code can probably be much simpler, because 
you do not need to keep a list of all spinning locks.  Unlock_lock can 
just use the CPU number to wake up the right CPU.

Paolo
