From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/sched/membarrier 4/5] membarrier: Remove unused code for architectures without membarrier hooks
Date: Fri, 13 Oct 2017 09:12:24 -0700
Message-ID: <1507911145-4134-4-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20171012170051.GA27468@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171012170051.GA27468@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, mathieu.desnoyers@efficios.com, peterz@infradead.org, boqun.feng@gmail.com, ahh@google.com, maged.michael@gmail.com, gromer@google.com, avi@scylladb.com, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, davejwatson@fb.com, stern@rowland.harvard.edu, will.deacon@arm.com, luto@kernel.org, viro@zeniv.linux.org.uk, piggin@gmail.com, linux-arch@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@redhat.com>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org

From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Architectures without membarrier hooks don't need to emit the
empty membarrier_arch_switch_mm() static inline when
CONFIG_MEMBARRIER=y.

Adapt the CONFIG_MEMBARRIER=n counterpart to only emit the empty
membarrier_arch_switch_mm() for architectures with membarrier hooks.

Reported-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
CC: Boqun Feng <boqun.feng@gmail.com>
CC: Andrew Hunter <ahh@google.com>
CC: Maged Michael <maged.michael@gmail.com>
CC: gromer@google.com
CC: Avi Kivity <avi@scylladb.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Paul Mackerras <paulus@samba.org>
CC: Michael Ellerman <mpe@ellerman.id.au>
CC: Dave Watson <davejwatson@fb.com>
CC: Alan Stern <stern@rowland.harvard.edu>
CC: Will Deacon <will.deacon@arm.com>
CC: Andy Lutomirski <luto@kernel.org>
CC: Ingo Molnar <mingo@redhat.com>
CC: Alexander Viro <viro@zeniv.linux.org.uk>
CC: linuxppc-dev@lists.ozlabs.org
CC: linux-arch@vger.kernel.org
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 include/linux/sched/mm.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index e4955d293687..40379edac388 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -221,10 +221,6 @@ static inline void memalloc_noreclaim_restore(unsigned int flags)
 #ifdef CONFIG_ARCH_HAS_MEMBARRIER_HOOKS
 #include <asm/membarrier.h>
 #else
-static inline void membarrier_arch_switch_mm(struct mm_struct *prev,
-		struct mm_struct *next, struct task_struct *tsk)
-{
-}
 static inline void membarrier_arch_fork(struct task_struct *t,
 		unsigned long clone_flags)
 {
@@ -253,10 +249,12 @@ static inline void membarrier_execve(struct task_struct *t)
 	membarrier_arch_execve(t);
 }
 #else
+#ifdef CONFIG_ARCH_HAS_MEMBARRIER_HOOKS
 static inline void membarrier_arch_switch_mm(struct mm_struct *prev,
 		struct mm_struct *next, struct task_struct *tsk)
 {
 }
+#endif
 static inline void membarrier_fork(struct task_struct *t,
 		unsigned long clone_flags)
 {
-- 
2.5.2
