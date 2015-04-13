From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v15 09/15] pvqspinlock: Implement simple paravirt support
 for the qspinlock
Date: Mon, 13 Apr 2015 17:09:34 +0200
Message-ID: <20150413150934.GI5029@twins.programming.kicks-ass.net>
References: <1428375350-9213-1-git-send-email-Waiman.Long@hp.com>
 <1428375350-9213-10-git-send-email-Waiman.Long@hp.com>
 <20150409181327.GY5029@twins.programming.kicks-ass.net>
 <5526F218.2070909@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:36923 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932108AbbDMPKD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 13 Apr 2015 11:10:03 -0400
Content-Disposition: inline
In-Reply-To: <5526F218.2070909@hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <waiman.long@hp.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, David Vrabel <david.vrabel@citrix.com>, Oleg Nesterov <oleg@redhat.com>, Daniel J Blueman <daniel@numascale.com>, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>

On Thu, Apr 09, 2015 at 05:41:44PM -0400, Waiman Long wrote:
> >>+__visible void __pv_queue_spin_unlock(struct qspinlock *lock)
> >>+{
> >>+	struct __qspinlock *l = (void *)lock;
> >>+	struct pv_node *node;
> >>+
> >>+	if (likely(cmpxchg(&l->locked, _Q_LOCKED_VAL, 0) == _Q_LOCKED_VAL))
> >>+		return;
> >>+
> >>+	/*
> >>+	 * The queue head has been halted. Need to locate it and wake it up.
> >>+	 */
> >>+	node = pv_hash_find(lock);
> >>+	smp_store_release(&l->locked, 0);
> >Ah yes, clever that.
> >
> >>+	/*
> >>+	 * At this point the memory pointed at by lock can be freed/reused,
> >>+	 * however we can still use the PV node to kick the CPU.
> >>+	 */
> >>+	if (READ_ONCE(node->state) == vcpu_halted)
> >>+		pv_kick(node->cpu);
> >>+}
> >>+PV_CALLEE_SAVE_REGS_THUNK(__pv_queue_spin_unlock);
> >However I feel the PV_CALLEE_SAVE_REGS_THUNK thing belongs in the x86
> >code.
> 
> That is why I originally put my version of the qspinlock_paravirt.h header
> file under arch/x86/include/asm. Maybe we should move it back there. Putting
> the thunk in arch/x86/kernel/kvm.c didn't work when you consider that the
> Xen code also need that.

Well the function is 'generic' and belong here I think. Its just the
PV_CALLEE_SAVE_REGS_THUNK thing that arch specific. Should have live in
arch/x86/kernel/paravirt-spinlocks.c instead?
