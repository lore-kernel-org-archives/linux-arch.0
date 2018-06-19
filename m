From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH -tip v6 27/27] kprobes: Remove jprobe stub API
Date: Wed, 20 Jun 2018 01:17:15 +0900
Message-ID: <152942503572.15209.1652552217914694917.stgit@devbox>
References: <152942424698.15209.15245996287444292393.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <152942424698.15209.15245996287444292393.stgit@devbox>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Remove jprobe stub APIs from linux/kprobes.h since
the jprobe implementation was completely gone.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 include/linux/kprobes.h |   50 -----------------------------------------------
 1 file changed, 50 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index b520baa65682..e909413e4e38 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -63,7 +63,6 @@ struct pt_regs;
 struct kretprobe;
 struct kretprobe_instance;
 typedef int (*kprobe_pre_handler_t) (struct kprobe *, struct pt_regs *);
-typedef int (*kprobe_break_handler_t) (struct kprobe *, struct pt_regs *);
 typedef void (*kprobe_post_handler_t) (struct kprobe *, struct pt_regs *,
 				       unsigned long flags);
 typedef int (*kprobe_fault_handler_t) (struct kprobe *, struct pt_regs *,
@@ -101,12 +100,6 @@ struct kprobe {
 	 */
 	kprobe_fault_handler_t fault_handler;
 
-	/*
-	 * ... called if breakpoint trap occurs in probe handler.
-	 * Return 1 if it handled break, otherwise kernel will see it.
-	 */
-	kprobe_break_handler_t break_handler;
-
 	/* Saved opcode (which has been replaced with breakpoint) */
 	kprobe_opcode_t opcode;
 
@@ -155,24 +148,6 @@ static inline int kprobe_ftrace(struct kprobe *p)
 }
 
 /*
- * Special probe type that uses setjmp-longjmp type tricks to resume
- * execution at a specified entry with a matching prototype corresponding
- * to the probed function - a trick to enable arguments to become
- * accessible seamlessly by probe handling logic.
- * Note:
- * Because of the way compilers allocate stack space for local variables
- * etc upfront, regardless of sub-scopes within a function, this mirroring
- * principle currently works only for probes placed on function entry points.
- */
-struct jprobe {
-	struct kprobe kp;
-	void *entry;	/* probe handling code to jump to */
-};
-
-/* For backward compatibility with old code using JPROBE_ENTRY() */
-#define JPROBE_ENTRY(handler)	(handler)
-
-/*
  * Function-return probe -
  * Note:
  * User needs to provide a handler function, and initialize maxactive.
@@ -436,9 +411,6 @@ static inline void unregister_kprobe(struct kprobe *p)
 static inline void unregister_kprobes(struct kprobe **kps, int num)
 {
 }
-static inline void jprobe_return(void)
-{
-}
 static inline int register_kretprobe(struct kretprobe *rp)
 {
 	return -ENOSYS;
@@ -465,20 +437,6 @@ static inline int enable_kprobe(struct kprobe *kp)
 	return -ENOSYS;
 }
 #endif /* CONFIG_KPROBES */
-static inline int register_jprobe(struct jprobe *p)
-{
-	return -ENOSYS;
-}
-static inline int register_jprobes(struct jprobe **jps, int num)
-{
-	return -ENOSYS;
-}
-static inline void unregister_jprobe(struct jprobe *p)
-{
-}
-static inline void unregister_jprobes(struct jprobe **jps, int num)
-{
-}
 static inline int disable_kretprobe(struct kretprobe *rp)
 {
 	return disable_kprobe(&rp->kp);
@@ -487,14 +445,6 @@ static inline int enable_kretprobe(struct kretprobe *rp)
 {
 	return enable_kprobe(&rp->kp);
 }
-static inline int disable_jprobe(struct jprobe *jp)
-{
-	return -ENOSYS;
-}
-static inline int enable_jprobe(struct jprobe *jp)
-{
-	return -ENOSYS;
-}
 
 #ifndef CONFIG_KPROBES
 static inline bool is_kprobe_insn_slot(unsigned long addr)
