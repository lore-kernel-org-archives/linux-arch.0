Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:48594 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752237AbcEaKaC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 31 May 2016 06:30:02 -0400
Message-ID: <20160531102643.520565711@infradead.org>
Date: Tue, 31 May 2016 12:19:58 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH -v2 33/33] locking,rwsem: Employ atomic_long_fetch_add()
References: <20160531101925.702692792@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-locking-rwsem-fetch-add.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de, will.deacon@arm.com, paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com, waiman.long@hpe.com, fweisbec@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, egtvedt@samfundet.no, realmz6@gmail.com, ysato@users.sourceforge.jp, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, dhowells@redhat.com, jejb@parisc-linux.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, dalias@libc.org, davem@davemloft.net, cmetcalf@mellanox.com, jcmvbkbc@gmail.com, arnd@arndb.de, peterz@infradead.org, dbueso@suse.de, fengguang.wu@intel.com, Jason Low <jason.low2@hpe.com>
Message-ID: <20160531101958.Lxq_0jil7OpGUs6l7LUG2Jq7mk_Z6eVxw2tzYEU-G1M@z>

Now that we have fetch_add() we can stop using add_return() - val.

Cc: Jason Low <jason.low2@hpe.com>
Cc: Waiman Long <waiman.long@hpe.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/locking/rwsem-xadd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -153,7 +153,7 @@ __rwsem_mark_wake(struct rw_semaphore *s
 	if (wake_type != RWSEM_WAKE_READ_OWNED) {
 		adjustment = RWSEM_ACTIVE_READ_BIAS;
  try_reader_grant:
-		oldcount = atomic_long_add_return(adjustment, &sem->count) - adjustment;
+		oldcount = atomic_long_fetch_add(adjustment, &sem->count);
 
 		if (unlikely(oldcount < RWSEM_WAITING_BIAS)) {
 			/*


