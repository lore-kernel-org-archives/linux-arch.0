Return-Path: <SRS0=XOKs=3M=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:42458 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgAWNSA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jan 2020 08:18:00 -0500
Date: Thu, 23 Jan 2020 14:17:37 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v9 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Message-ID: <20200123131737.GV14914@hirez.programming.kicks-ass.net>
References: <20200115035920.54451-1-alex.kogan@oracle.com>
 <20200115035920.54451-4-alex.kogan@oracle.com>
 <20200123092658.GC14879@hirez.programming.kicks-ass.net>
 <20200123100635.GE14946@hirez.programming.kicks-ass.net>
 <20200123101649.GF14946@hirez.programming.kicks-ass.net>
 <20200123112251.GC18991@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123112251.GC18991@willie-the-truck>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Alex Kogan <alex.kogan@oracle.com>, linux-arch@vger.kernel.org, guohanjun@huawei.com, arnd@arndb.de, dave.dice@oracle.com, jglauber@marvell.com, x86@kernel.org, will.deacon@arm.com, linux@armlinux.org.uk, steven.sistare@oracle.com, linux-kernel@vger.kernel.org, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, longman@redhat.com, tglx@linutronix.de, daniel.m.jordan@oracle.com, linux-arm-kernel@lists.infradead.org
Message-ID: <20200123131737.lRoFYY2A7lGOE011FC8CXlrtGICZhYIKJdc5pexPghg@z>

On Thu, Jan 23, 2020 at 11:22:51AM +0000, Will Deacon wrote:

> > Argh, make that:
> > 
> > 	tail_2nd->next = NULL;
> > 
> > 	smp_wmb();
> > 
> > > 	if (!atomic_try_cmpxchg_relaxed(&lock, &val, new)) {
> 
> ... or could you drop the smp_wmb() and make this
> atomic_try_cmpxchg_release()?

My current code has the smp_wmb(), because most _releases end up being
an smp_mb() (except for powerpc where it is of equal cost to wmb and
arm64, where I have no idea of the costs).

> To be honest, I've failed to understand the code prior to your changes
> in this area: it appears to reply on a control-dependency from the two
> cmpxchg_relaxed() calls (which isn't sufficient to order the store parts
> afaict) and I also don't get how we deal with a transiently circular primary
> queue.

Ha!, yes, so this little piece took me a while too. Let me attempt an
explanation.

+ *    cna_node
+ *   +----------+     +--------+         +--------+
+ *   |mcs:next  | --> |mcs:next| --> ... |mcs:next| --> NULL  [Primary queue]
+ *   |mcs:locked| -.  +--------+         +--------+
+ *   +----------+  |
+ *                 `----------------------.
+ *                                        v
+ *                 +--------+         +--------+
+ *                 |mcs:next| --> ... |mcs:next|            [Secondary queue]
+ *                 +--------+         +--------+
+ *                     ^                    |
+ *                     `--------------------'

So @node is the current lock holder, node->next == NULL (primary queue
is empty) and we're going to try and splice the secondary queue to the
head of the primary.

+       tail_2nd = decode_tail(node->locked);
+       head_2nd = tail_2nd->next;

this gets the secondary head and tail, so far so simple

+       new = ((struct cna_node *)tail_2nd)->encoded_tail + _Q_LOCKED_VAL;

this encodes the new primary tail (as kept in lock->val), still simple

+       if (atomic_try_cmpxchg_relaxed(&lock->val, &val, new)) {

if this here succeeds, we've got the primary tail pointing at the
secondary tail. This is safe because only the lock holder (us) ever
modifies the secondary queue.

+               /*
+                * Try to reset @next in tail_2nd to NULL, but no need to check
+                * the result - if failed, a new successor has updated it.
+                */
+               cmpxchg_relaxed(&tail_2nd->next, head_2nd, NULL);

This is (broken, as per the prior argument) breaking the circular link
the secondary queue has. The trick here is that since we're the lock
holder, nothing will actually iterate the primary ->next chain, so a
bogus value in there is of no concern.

_However_ a new waiter might at this point do:

	old = xchg_tail(lock, node);
	if (old) {
		prev = decode_tail(old);
		WRITE_ONCE(prev->next, node);
		...
	}

which then results in conflicting stores to the one ->next variable.

The cmpxchg() is attempting to terminate the list, while the new waiter
is extending the list, it is therefore paramount the new waiter always
wins this. To that end they're employing the cmpxchg, but it very much
relies on the @head_2nd load to have happened before we exposed the
secondary tail as primary tail, otherwise it can have loaded the new
->next pointer and overwriten it.

+               arch_mcs_pass_lock(&head_2nd->locked, 1);
+               return true;
+       }
+
+       return false;


Did that help, or just make it worse?
