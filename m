From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tools/memory-model 05/17] arm64: Remove smp_mb() from arch_spin_is_locked()
Date: Mon, 16 Apr 2018 09:12:33 -0700
Message-ID: <1523895165-17576-5-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20180416161209.GA6895@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180416161209.GA6895@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, Andrea Parri <andrea.parri@amarulasolutions.com>, Catalin Marinas <catalin.marinas@arm.com>, Ingo Molnar <mingo@redhat.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

From: Andrea Parri <andrea.parri@amarulasolutions.com>

Commit 38b850a73034f ("arm64: spinlock: order spin_{is_locked,unlock_wait}
against local locks") added an smp_mb() to arch_spin_is_locked(), in order
"to ensure that the lock value is always loaded after any other locks have
been taken by the current CPU", and reported one example (the "insane case"
in ipc/sem.c) relying on such guarantee.

It is however understood that spin_is_locked() is not required to provide
such an ordering guarantee (a guarantee that is currently not provided by
all the implementations/archs), and that callers relying on such ordering
should instead insert suitable memory barriers before acting on the result
of spin_is_locked().

Following a recent auditing [1] of the callers of {,raw_}spin_is_locked(),
revealing that none of them are relying on the ordering guarantee anymore,
this commit removes the leading smp_mb() from the primitive thus reverting
38b850a73034f.

[1] https://marc.info/?l=linux-kernel&m=151981440005264&w=2
    https://marc.info/?l=linux-kernel&m=152042843808540&w=2
    https://marc.info/?l=linux-kernel&m=152043346110262&w=2

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 arch/arm64/include/asm/spinlock.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm64/include/asm/spinlock.h b/arch/arm64/include/asm/spinlock.h
index ebdae15d665d..26c5bd7d88d8 100644
--- a/arch/arm64/include/asm/spinlock.h
+++ b/arch/arm64/include/asm/spinlock.h
@@ -122,11 +122,6 @@ static inline int arch_spin_value_unlocked(arch_spinlock_t lock)
 
 static inline int arch_spin_is_locked(arch_spinlock_t *lock)
 {
-	/*
-	 * Ensure prior spin_lock operations to other locks have completed
-	 * on this CPU before we test whether "lock" is locked.
-	 */
-	smp_mb(); /* ^^^ */
 	return !arch_spin_value_unlocked(READ_ONCE(*lock));
 }
 
-- 
2.5.2
