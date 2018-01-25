From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 3/8] kprobes: Replace %p with other pointer types
Date: Thu, 25 Jan 2018 14:28:02 +0900
Message-ID: <151685808262.3099.402832363414780425.stgit@devbox>
References: <151685799071.3099.10383062804474021403.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750769AbeAYF21 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 25 Jan 2018 00:28:27 -0500
In-Reply-To: <151685799071.3099.10383062804474021403.stgit@devbox>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>, Jon Medhurst <tixy@linaro.org>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "Tobin C . Harding" <me@tobin.cc>, Linus Torvalds <torvalds@linux-foundation.org>

Replace %p with appropriate pointer types (or just remove it)
 - Use %pS if possible
 - Use %px only for the function right before BUG().
 - Remove unneeded error message.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/kprobes.c |   16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index a5f13e379ae1..02887975d445 100644
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
@@ -984,7 +984,7 @@ static void arm_kprobe_ftrace(struct kprobe *p)
 
 	ret = ftrace_set_filter_ip(&kprobe_ftrace_ops,
 				   (unsigned long)p->addr, 0, 0);
-	WARN(ret < 0, "Failed to arm kprobe-ftrace at %p (%d)\n", p->addr, ret);
+	WARN(ret < 0, "Failed to arm kprobe-ftrace at %pS (%d)\n", p->addr, ret);
 	kprobe_ftrace_enabled++;
 	if (kprobe_ftrace_enabled == 1) {
 		ret = register_ftrace_function(&kprobe_ftrace_ops);
@@ -1004,7 +1004,7 @@ static void disarm_kprobe_ftrace(struct kprobe *p)
 	}
 	ret = ftrace_set_filter_ip(&kprobe_ftrace_ops,
 			   (unsigned long)p->addr, 1, 0);
-	WARN(ret < 0, "Failed to disarm kprobe-ftrace at %p (%d)\n", p->addr, ret);
+	WARN(ret < 0, "Failed to disarm kprobe-ftrace at %pS (%d)\n", p->addr, ret);
 }
 #else	/* !CONFIG_KPROBES_ON_FTRACE */
 #define prepare_kprobe(p)	arch_prepare_kprobe(p)
@@ -2124,10 +2124,11 @@ int enable_kprobe(struct kprobe *kp)
 }
 EXPORT_SYMBOL_GPL(enable_kprobe);
 
+/* Caller must NOT call this in usual path. This is only for critical case */
 void dump_kprobe(struct kprobe *kp)
 {
-	printk(KERN_WARNING "Dumping kprobe:\n");
-	printk(KERN_WARNING "Name: %s\nAddress: %p\nOffset: %x\n",
+	pr_err("Dumping kprobe:\n");
+	pr_err("Name: %s\nAddress: %px\nOffset: %x\n",
 	       kp->symbol_name, kp->addr, kp->offset);
 }
 NOKPROBE_SYMBOL(dump_kprobe);
@@ -2151,11 +2152,8 @@ static int __init populate_kprobe_blacklist(unsigned long *start,
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
