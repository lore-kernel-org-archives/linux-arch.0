From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v3 4/7] kprobes: Replace %p with other pointer types
Date: Fri, 27 Apr 2018 15:41:40 +0900
Message-ID: <152481130062.22588.10747314456340608852.stgit@devbox>
References: <152481117776.22588.1210388093668905564.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <152481117776.22588.1210388093668905564.stgit@devbox>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>, Jon Medhurst <tixy@linaro.org>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "Tobin C . Harding" <me@tobin.cc>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Richter <tmricht@linux.ibm.com>, akpm@linux-foundation.org, acme@kernel.org, rostedt@goodmis.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, stable@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Replace %p with %pS or just remove it if unneeded.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v3:
  - Do not use %px in any case.
 Changes in v2:
  - Rebased on linux-next
---
 kernel/kprobes.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 94af7c99cf81..a72ff4999b11 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -712,7 +712,7 @@ static void reuse_unused_kprobe(struct kprobe *ap)
 	op = container_of(ap, struct optimized_kprobe, kp);
 	if (unlikely(list_empty(&op->list)))
 		printk(KERN_WARNING "Warning: found a stray unused "
-			"aggrprobe@%p\n", ap->addr);
+			"aggrprobe@%pS\n", ap->addr);
 	/* Enable the probe again */
 	ap->flags &= ~KPROBE_FLAG_DISABLED;
 	/* Optimize it again (remove from op->list) */
@@ -985,7 +985,8 @@ static int arm_kprobe_ftrace(struct kprobe *p)
 	ret = ftrace_set_filter_ip(&kprobe_ftrace_ops,
 				   (unsigned long)p->addr, 0, 0);
 	if (ret) {
-		pr_debug("Failed to arm kprobe-ftrace at %p (%d)\n", p->addr, ret);
+		pr_debug("Failed to arm kprobe-ftrace at %pS (%d)\n",
+			 p->addr, ret);
 		return ret;
 	}
 
@@ -1025,7 +1026,8 @@ static int disarm_kprobe_ftrace(struct kprobe *p)
 
 	ret = ftrace_set_filter_ip(&kprobe_ftrace_ops,
 			   (unsigned long)p->addr, 1, 0);
-	WARN(ret < 0, "Failed to disarm kprobe-ftrace at %p (%d)\n", p->addr, ret);
+	WARN(ret < 0, "Failed to disarm kprobe-ftrace at %pS (%d)\n",
+	     p->addr, ret);
 	return ret;
 }
 #else	/* !CONFIG_KPROBES_ON_FTRACE */
@@ -2169,11 +2171,12 @@ int enable_kprobe(struct kprobe *kp)
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
 
@@ -2196,11 +2199,8 @@ static int __init populate_kprobe_blacklist(unsigned long *start,
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
