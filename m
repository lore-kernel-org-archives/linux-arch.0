From: Peter Zijlstra <peterz@infradead.org>
Subject: [RFC][PATCH 01/31] locking: Flip arguments to atomic_fetch_or
Date: Fri, 22 Apr 2016 11:04:14 +0200
Message-ID: <20160422093923.095484070@infradead.org>
References: <20160422090413.393652501@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=peterz-atomic-fetch_or-flip-args.patch
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de, will.deacon@arm.com, paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com, waiman.long@hpe.com, fweisbec@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, egtvedt@samfundet.no, realmz6@gmail.com, ysato@users.sourceforge.jp, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, dhowells@redhat.com, jejb@parisc-linux.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, dalias@libc.org, davem@davemloft.net, cmetcalf@mellanox.com, jcmvbkbc@gmail.com, arnd@arndb.de, peterz@infradead.org, dbueso@suse.de, fengguang.wu@intel.com
List-Id: linux-arch.vger.kernel.org

All the atomic operations have their arguments the wrong way around;
make atomic_fetch_or() consistent and flip them.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/atomic.h   |    4 ++--
 kernel/time/tick-sched.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -560,11 +560,11 @@ static inline int atomic_dec_if_positive
 
 /**
  * atomic_fetch_or - perform *p |= mask and return old value of *p
- * @p: pointer to atomic_t
  * @mask: mask to OR on the atomic_t
+ * @p: pointer to atomic_t
  */
 #ifndef atomic_fetch_or
-static inline int atomic_fetch_or(atomic_t *p, int mask)
+static inline int atomic_fetch_or(int mask, atomic_t *p)
 {
 	int old, val = atomic_read(p);
 
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -262,7 +262,7 @@ static void tick_nohz_dep_set_all(atomic
 {
 	int prev;
 
-	prev = atomic_fetch_or(dep, BIT(bit));
+	prev = atomic_fetch_or(BIT(bit), dep);
 	if (!prev)
 		tick_nohz_full_kick_all();
 }
@@ -292,7 +292,7 @@ void tick_nohz_dep_set_cpu(int cpu, enum
 
 	ts = per_cpu_ptr(&tick_cpu_sched, cpu);
 
-	prev = atomic_fetch_or(&ts->tick_dep_mask, BIT(bit));
+	prev = atomic_fetch_or(BIT(bit), &ts->tick_dep_mask);
 	if (!prev) {
 		preempt_disable();
 		/* Perf needs local kick that is NMI safe */
