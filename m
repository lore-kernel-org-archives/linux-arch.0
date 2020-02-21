From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v4 26/27] x86/int3: Inline bsearch()
Date: Fri, 21 Feb 2020 14:34:42 +0100
Message-ID: <20200221134216.803627089@infradead.org>
References: <20200221133416.777099322@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org
Cc: peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org
List-Id: linux-arch.vger.kernel.org

Avoid calling out to bsearch() by inlining it, for normal kernel
configs this was the last external call and poke_int3_handler() is now
fully self sufficient -- no calls to external code.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/alternative.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -979,7 +979,7 @@ static __always_inline void *text_poke_a
 	return _stext + tp->rel_addr;
 }
 
-static int notrace patch_cmp(const void *key, const void *elt)
+static __always_inline int patch_cmp(const void *key, const void *elt)
 {
 	struct text_poke_loc *tp = (struct text_poke_loc *) elt;
 
@@ -989,7 +989,6 @@ static int notrace patch_cmp(const void
 		return 1;
 	return 0;
 }
-NOKPROBE_SYMBOL(patch_cmp);
 
 int notrace poke_int3_handler(struct pt_regs *regs)
 {
@@ -1024,9 +1023,9 @@ int notrace poke_int3_handler(struct pt_
 	 * Skip the binary search if there is a single member in the vector.
 	 */
 	if (unlikely(desc->nr_entries > 1)) {
-		tp = bsearch(ip, desc->vec, desc->nr_entries,
-			     sizeof(struct text_poke_loc),
-			     patch_cmp);
+		tp = __bsearch(ip, desc->vec, desc->nr_entries,
+			       sizeof(struct text_poke_loc),
+			       patch_cmp);
 		if (!tp)
 			goto out_put;
 	} else {
