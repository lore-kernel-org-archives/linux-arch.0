From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v4 4/7] kprobes: Replace %p with other pointer types
Date: Sat, 28 Apr 2018 21:36:33 +0900
Message-ID: <152491899284.9916.5350534544808158621.stgit@devbox>
References: <152491886943.9916.18051658590418236184.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <152491886943.9916.18051658590418236184.stgit@devbox>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>, Jon Medhurst <tixy@linaro.org>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "Tobin C . Harding" <me@tobin.cc>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Richter <tmricht@linux.ibm.com>, akpm@linux-foundation.org, acme@kernel.org, rostedt@goodmis.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, stable@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Replace %p with %pS or just remove it if unneeded.
And use WARN_ONCE() if it is a single bug.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: stable@vger.kernel.org
---
 Changes in v4:
  - Use WARN_ONCE() for single bug.
 Changes in v3:
  - Do not use %px in any case.
 Changes in v2:
  - Rebased on linux-next
---
 kernel/kprobes.c |   22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 548903deaee5..bb70658acb97 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -710,9 +710,7 @@ static void reuse_unused_kprobe(struct kprobe *ap)
 	 * there is still a relative jump) and disabled.
 	 */
 	op = container_of(ap, struct optimized_kprobe, kp);
-	if (unlikely(list_empty(&op->list)))
-		printk(KERN_WARNING "Warning: found a stray unused "
-			"aggrprobe@%p\n", ap->addr);
+	WARN_ON_ONCE(list_empty(&op->list));
 	/* Enable the probe again */
 	ap->flags &= ~KPROBE_FLAG_DISABLED;
 	/* Optimize it again (remove from op->list) */
@@ -985,7 +983,8 @@ static int arm_kprobe_ftrace(struct kprobe *p)
 	ret = ftrace_set_filter_ip(&kprobe_ftrace_ops,
 				   (unsigned long)p->addr, 0, 0);
 	if (ret) {
-		pr_debug("Failed to arm kprobe-ftrace at %p (%d)\n", p->addr, ret);
+		pr_debug("Failed to arm kprobe-ftrace at %pS (%d)\n",
+			 p->addr, ret);
 		return ret;
 	}
 
@@ -1025,7 +1024,8 @@ static int disarm_kprobe_ftrace(struct kprobe *p)
 
 	ret = ftrace_set_filter_ip(&kprobe_ftrace_ops,
 			   (unsigned long)p->addr, 1, 0);
-	WARN(ret < 0, "Failed to disarm kprobe-ftrace at %p (%d)\n", p->addr, ret);
+	WARN_ONCE(ret < 0, "Failed to disarm kprobe-ftrace at %pS (%d)\n",
+		  p->addr, ret);
 	return ret;
 }
 #else	/* !CONFIG_KPROBES_ON_FTRACE */
@@ -2169,11 +2169,12 @@ int enable_kprobe(struct kprobe *kp)
 }
 EXPORT_SYMBOL_GPL(enable_kprobe);
 
+/* Caller must NOT call this in usual path. This is only for critical case */
 void dump_kprobe(struct kprobe *kp)
 {
-	printk(KERN_WARNING "Dumping kprobe:\n");
-	printk(KERN_WARNING "Name: %s\nAddress: %p\nOffset: %x\n",
-	       kp->symbol_name, kp->addr, kp->offset);
+	pr_err("Dumping kprobe:\n");
+	pr_err("Name: %s\nOffset: %x\nAddress: %pS\n",
+	       kp->symbol_name, kp->offset, kp->addr);
 }
 NOKPROBE_SYMBOL(dump_kprobe);
 
@@ -2196,11 +2197,8 @@ static int __init populate_kprobe_blacklist(unsigned long *start,
 		entry = arch_deref_entry_point((void *)*iter);
 
 		if (!kernel_text_address(entry) ||
-		    !kallsyms_lookup_size_offset(entry, &size, &offset)) {
-			pr_err("Failed to find blacklist at %p\n",
-				(void *)entry);
+		    !kallsyms_lookup_size_offset(entry, &size, &offset))
 			continue;
-		}
 
 		ent = kmalloc(sizeof(*ent), GFP_KERNEL);
 		if (!ent)
