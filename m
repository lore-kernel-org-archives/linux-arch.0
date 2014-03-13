Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ee0-f49.google.com ([74.125.83.49]:60827 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752752AbaCMN5w (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 13 Mar 2014 09:57:52 -0400
Message-ID: <5321B959.5050305@redhat.com>
Date: Thu, 13 Mar 2014 14:57:45 +0100
From: Paolo Bonzini <pbonzini@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH RFC v6 09/11] pvqspinlock, x86: Add qspinlock para-virtualization
 support
References: <1394650498-30118-1-git-send-email-Waiman.Long@hp.com>	<1394650498-30118-10-git-send-email-Waiman.Long@hp.com> <5321949F.1010103@citrix.com>
In-Reply-To: <5321949F.1010103@citrix.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Vrabel <david.vrabel@citrix.com>, Waiman Long <Waiman.Long@hp.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Michel Lespinasse <walken@google.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, Gleb Natapov <gleb@redhat.com>, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Scott J Norton <scott.norton@hp.com>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, Oleg Nesterov <oleg@redhat.com>, Alok Kataria <akataria@vmware.com>, Aswin Chandramouleeswaran <aswin@hp.com>, Chegu Vinod <chegu_vinod@hp.com>
Message-ID: <20140313135745.CHep7WReUo-bIS5vIKMMkb0rHOYa3dgLlbhnf6lp4Eo@z>

Il 13/03/2014 12:21, David Vrabel ha scritto:
> On 12/03/14 18:54, Waiman Long wrote:
>> This patch adds para-virtualization support to the queue spinlock in
>> the same way as was done in the PV ticket lock code. In essence, the
>> lock waiters will spin for a specified number of times (QSPIN_THRESHOLD
>> = 2^14) and then halted itself. The queue head waiter will spins
>> 2*QSPIN_THRESHOLD times before halting itself. When it has spinned
>> QSPIN_THRESHOLD times, the queue head will assume that the lock
>> holder may be scheduled out and attempt to kick the lock holder CPU
>> if it has the CPU number on hand.
>
> I don't really understand the reasoning for kicking the lock holder.

I agree.  If the lock holder isn't running, there's probably a good 
reason for that and going to sleep will not necessarily convince the 
scheduler to give more CPU to the lock holder.  I think there are two 
choices:

1) use yield_to to donate part of the waiter's quantum to the lock 
holder?    For this we probably need a new, separate hypercall 
interface.  For KVM it would be the same as hlt in the guest but with an 
additional yield_to in the host.

2) do nothing, just go to sleep.

Could you get (or do you have) numbers for (2)?

More important, I think a barrier is missing:

	Lock holder ---------------------------------------

	// queue_spin_unlock
	barrier();
	ACCESS_ONCE(qlock->lock) = 0;
	barrier();

	// pv_kick_node:
	if (pv->cpustate != PV_CPU_HALTED)
		return;
	ACCESS_ONCE(pv->cpustate) = PV_CPU_KICKED;
	__queue_kick_cpu(pv->mycpu, PV_KICK_QUEUE_HEAD);

		Waiter -------------------------------------------

		// pv_head_spin_check
		ACCESS_ONCE(pv->cpustate) = PV_CPU_HALTED;
		lockval = cmpxchg(&qlock->lock,
				  _QSPINLOCK_LOCKED,
				  _QSPINLOCK_LOCKED_SLOWPATH);
		if (lockval == 0) {
			/*
			 * Can exit now as the lock is free
			 */
			ACCESS_ONCE(pv->cpustate) = PV_CPU_ACTIVE;
			*count = 0;
			return;
		}
		__queue_hibernate();

Nothing protects from writing qlock->lock before pv->cpustate is read, 
leading to this:

	Lock holder			Waiter
	---------------------------------------------------------------
	read pv->cpustate
		(it is PV_CPU_ACTIVE)
					pv->cpustate = PV_CPU_HALTED
					lockval = cmpxchg(...)
					hibernate()
	qlock->lock = 0
	if (pv->cpustate != PV_CPU_HALTED)
		return;

I think you need this:

-	if (pv->cpustate != PV_CPU_HALTED)
-		return;
-	ACCESS_ONCE(pv->cpustate) = PV_CPU_KICKED;
+	if (cmpxchg(pv->cpustate, PV_CPU_HALTED, PV_CPU_KICKED)
+			!= PV_CPU_HALTED)
+		return;

Paolo
