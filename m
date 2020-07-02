From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 2/8] powerpc/pseries: use smp_rmb() in H_CONFER spin yield
Date: Thu,  2 Jul 2020 17:48:33 +1000
Message-ID: <20200702074839.1057733-3-npiggin@gmail.com>
References: <20200702074839.1057733-1-npiggin@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <kvm-ppc-owner@vger.kernel.org>
In-Reply-To: <20200702074839.1057733-1-npiggin@gmail.com>
Sender: kvm-ppc-owner@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>, Anton Blanchard <anton@ozlabs.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

There is no need for rmb(), this allows faster lwsync here.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/lib/locks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/lib/locks.c b/arch/powerpc/lib/locks.c
index 6440d5943c00..47a530de733e 100644
--- a/arch/powerpc/lib/locks.c
+++ b/arch/powerpc/lib/locks.c
@@ -30,7 +30,7 @@ void splpar_spin_yield(arch_spinlock_t *lock)
 	yield_count = be32_to_cpu(lppaca_of(holder_cpu).yield_count);
 	if ((yield_count & 1) == 0)
 		return;		/* virtual cpu is currently running */
-	rmb();
+	smp_rmb();
 	if (lock->slock != lock_value)
 		return;		/* something has changed */
 	plpar_hcall_norets(H_CONFER,
@@ -56,7 +56,7 @@ void splpar_rw_yield(arch_rwlock_t *rw)
 	yield_count = be32_to_cpu(lppaca_of(holder_cpu).yield_count);
 	if ((yield_count & 1) == 0)
 		return;		/* virtual cpu is currently running */
-	rmb();
+	smp_rmb();
 	if (rw->lock != lock_value)
 		return;		/* something has changed */
 	plpar_hcall_norets(H_CONFER,
-- 
2.23.0
