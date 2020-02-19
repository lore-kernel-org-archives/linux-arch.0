From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 21/22] x86/int3: Avoid atomic instrumentation
Date: Wed, 19 Feb 2020 15:47:45 +0100
Message-ID: <20200219150745.593809490@infradead.org>
References: <20200219144724.800607165@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org
Cc: peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org
List-Id: linux-arch.vger.kernel.org

Use arch_atomic_*() and READ_ONCE_NOCHECK() to ensure nothing untoward
creeps in and ruins things.

That is; this is the INT3 text poke handler, strictly limit the code
that runs in it, lest we inadvertenly hit yet another INT3.

Reported-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/alternative.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -960,9 +960,9 @@ static struct bp_patching_desc *bp_desc;
 static __always_inline
 struct bp_patching_desc *try_get_desc(struct bp_patching_desc **descp)
 {
-	struct bp_patching_desc *desc = READ_ONCE(*descp); /* rcu_dereference */
+	struct bp_patching_desc *desc = READ_ONCE_NOCHECK(*descp); /* rcu_dereference */
 
-	if (!desc || !atomic_inc_not_zero(&desc->refs))
+	if (!desc || !arch_atomic_inc_not_zero(&desc->refs))
 		return NULL;
 
 	return desc;
@@ -971,7 +971,7 @@ struct bp_patching_desc *try_get_desc(st
 static __always_inline void put_desc(struct bp_patching_desc *desc)
 {
 	smp_mb__before_atomic();
-	atomic_dec(&desc->refs);
+	arch_atomic_dec(&desc->refs);
 }
 
 static __always_inline void *text_poke_addr(struct text_poke_loc *tp)
