From: Will Deacon <will.deacon@arm.com>
Subject: spin_lock() ordering on ia64
Date: Wed, 18 Nov 2015 13:11:06 +0000
Message-ID: <20151118131106.GE1588@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:34585 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754900AbbKRNLJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 18 Nov 2015 08:11:09 -0500
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tony.luck@intel.com
Cc: peterz@infradead.org, linux-arch@vger.kernel.org

Hi Tony,

I recently took a look at the ia64 spinlock implementation in hope of
some inspiration regarding spin_unlock_wait, but I'm actually having
trouble understanding how spin_lock() guarantees ordering between taking
the lock and reads of some shared data in the critical section.

In particular, the loop where the locker spins awaiting its turn in the
queue:


for (;;) {
	asm volatile ("ld4.c.nc %0=[%1]" : "=r"(serve) : "r"(p) : "memory");

	if (!(((serve >> TICKET_SHIFT) ^ ticket) & TICKET_MASK))
		return;
	cpu_relax();
}


AFAIU, ld4.c.nc doesn't provide any ordering semantics, so a load to an
unrelated address from within the following critical section could be
speculated before we've actually acquired the lock.

What am I missing? Does the ALAT provide guarantees against other loads
somehow or does ld4.c.nc provide ordering guarantees that I didn't spot
in the manuals?

Cheers,

Will
