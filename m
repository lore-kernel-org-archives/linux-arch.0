Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from omx2-ext.sgi.com ([192.48.171.19]:4244 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030190AbWJPEsy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 16 Oct 2006 00:48:54 -0400
From: Keith Owens <kaos@sgi.com>
Subject: [patch 2.6.19-rc1] Clean up DIE_* entries
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 16 Oct 2006 14:49:16 +1000
Message-ID: <6915.1160974156@kao2.melbourne.sgi.com>
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: prasanna@in.ibm.com, ananth@in.ibm.com, anil.s.keshavamurthy@intel.com
List-ID: <linux-arch.vger.kernel.org>

include/asm-*/kdebug.h has been blindly copied from one architecture to
another and all of them contain unused DIE_* enums.  Some DIE_* values
are only used in a couple of architectures, some are not used in _any_
architecture.  Delete the unused DIE_* enums.

There is no need for the first enum to be 1.  Some architectures do
this, others do not.  Remove it from all architectures.

Some kprobes arch specific code refers to DIE_* enums which are never
notified by that architecture.  Delete the spurious kprobes code.

Signed-off-by: Keith Owens <kaos@sgi.com>

Compile tested on i386, x86_64, ia64.  Source level checked on avr32,
powerpc, s390, sparc64.

---
 arch/avr32/kernel/kprobes.c  |    5 -----
 arch/s390/kernel/kprobes.c   |    4 ----
 include/asm-avr32/kdebug.h   |    1 -
 include/asm-i386/kdebug.h    |    6 +-----
 include/asm-ia64/kdebug.h    |    4 +---
 include/asm-powerpc/kdebug.h |    1 -
 include/asm-s390/kdebug.h    |   10 ----------
 include/asm-sparc64/kdebug.h |    3 +--
 include/asm-x86_64/kdebug.h  |    7 +------
 9 files changed, 4 insertions(+), 37 deletions(-)

Index: linux/arch/avr32/kernel/kprobes.c
===================================================================
--- linux.orig/arch/avr32/kernel/kprobes.c
+++ linux/arch/avr32/kernel/kprobes.c
@@ -215,11 +215,6 @@ int __kprobes kprobe_exceptions_notify(s
 		if (post_kprobe_handler(args->regs))
 			ret = NOTIFY_STOP;
 		break;
-	case DIE_FAULT:
-		if (kprobe_running()
-		    && kprobe_fault_handler(args->regs, args->trapnr))
-			ret = NOTIFY_STOP;
-		break;
 	default:
 		break;
 	}
Index: linux/arch/s390/kernel/kprobes.c
===================================================================
--- linux.orig/arch/s390/kernel/kprobes.c
+++ linux/arch/s390/kernel/kprobes.c
@@ -581,10 +581,6 @@ int __kprobes kprobe_exceptions_notify(s
 	int ret = NOTIFY_DONE;
 
 	switch (val) {
-	case DIE_BPT:
-		if (kprobe_handler(args->regs))
-			ret = NOTIFY_STOP;
-		break;
 	case DIE_SSTEP:
 		if (post_kprobe_handler(args->regs))
 			ret = NOTIFY_STOP;
Index: linux/include/asm-avr32/kdebug.h
===================================================================
--- linux.orig/include/asm-avr32/kdebug.h
+++ linux/include/asm-avr32/kdebug.h
@@ -18,7 +18,6 @@ extern struct atomic_notifier_head avr32
 
 /* Grossly misnamed. */
 enum die_val {
-	DIE_FAULT,
 	DIE_BREAKPOINT,
 	DIE_SSTEP,
 	DIE_PAGE_FAULT,
Index: linux/include/asm-i386/kdebug.h
===================================================================
--- linux.orig/include/asm-i386/kdebug.h
+++ linux/include/asm-i386/kdebug.h
@@ -26,17 +26,13 @@ extern struct atomic_notifier_head i386d
 
 /* Grossly misnamed. */
 enum die_val {
-	DIE_OOPS = 1,
+	DIE_OOPS,
 	DIE_INT3,
 	DIE_DEBUG,
-	DIE_PANIC,
 	DIE_NMI,
-	DIE_DIE,
 	DIE_NMIWATCHDOG,
-	DIE_KERNELDEBUG,
 	DIE_TRAP,
 	DIE_GPF,
-	DIE_CALL,
 	DIE_NMI_IPI,
 	DIE_PAGE_FAULT,
 };
Index: linux/include/asm-ia64/kdebug.h
===================================================================
--- linux.orig/include/asm-ia64/kdebug.h
+++ linux/include/asm-ia64/kdebug.h
@@ -45,7 +45,7 @@ extern int unregister_page_fault_notifie
 extern struct atomic_notifier_head ia64die_chain;
 
 enum die_val {
-	DIE_BREAK = 1,
+	DIE_BREAK,
 	DIE_FAULT,
 	DIE_OOPS,
 	DIE_PAGE_FAULT,
@@ -70,8 +70,6 @@ enum die_val {
 	DIE_INIT_SLAVE_LEAVE,
 	DIE_KDEBUG_ENTER,
 	DIE_KDEBUG_LEAVE,
-	DIE_KDUMP_ENTER,
-	DIE_KDUMP_LEAVE,
 };
 
 static inline int notify_die(enum die_val val, char *str, struct pt_regs *regs,
Index: linux/include/asm-powerpc/kdebug.h
===================================================================
--- linux.orig/include/asm-powerpc/kdebug.h
+++ linux/include/asm-powerpc/kdebug.h
@@ -24,7 +24,6 @@ extern struct atomic_notifier_head power
 
 /* Grossly misnamed. */
 enum die_val {
-	DIE_OOPS = 1,
 	DIE_IABR_MATCH,
 	DIE_DABR_MATCH,
 	DIE_BPT,
Index: linux/include/asm-s390/kdebug.h
===================================================================
--- linux.orig/include/asm-s390/kdebug.h
+++ linux/include/asm-s390/kdebug.h
@@ -28,18 +28,8 @@ extern struct atomic_notifier_head s390d
 
 
 enum die_val {
-	DIE_OOPS = 1,
-	DIE_BPT,
 	DIE_SSTEP,
-	DIE_PANIC,
-	DIE_NMI,
-	DIE_DIE,
-	DIE_NMIWATCHDOG,
-	DIE_KERNELDEBUG,
 	DIE_TRAP,
-	DIE_GPF,
-	DIE_CALL,
-	DIE_NMI_IPI,
 	DIE_PAGE_FAULT,
 };
 
Index: linux/include/asm-sparc64/kdebug.h
===================================================================
--- linux.orig/include/asm-sparc64/kdebug.h
+++ linux/include/asm-sparc64/kdebug.h
@@ -25,10 +25,9 @@ extern void bad_trap(struct pt_regs *, l
 
 /* Grossly misnamed. */
 enum die_val {
-	DIE_OOPS = 1,
+	DIE_OOPS,
 	DIE_DEBUG,	/* ta 0x70 */
 	DIE_DEBUG_2,	/* ta 0x71 */
-	DIE_DIE,
 	DIE_TRAP,
 	DIE_TRAP_TL1,
 	DIE_GPF,
Index: linux/include/asm-x86_64/kdebug.h
===================================================================
--- linux.orig/include/asm-x86_64/kdebug.h
+++ linux/include/asm-x86_64/kdebug.h
@@ -21,17 +21,12 @@ extern struct atomic_notifier_head die_c
 
 /* Grossly misnamed. */
 enum die_val {
-	DIE_OOPS = 1,
+	DIE_OOPS,
 	DIE_INT3,
 	DIE_DEBUG,
-	DIE_PANIC,
 	DIE_NMI,
-	DIE_DIE,
-	DIE_NMIWATCHDOG,
-	DIE_KERNELDEBUG,
 	DIE_TRAP,
 	DIE_GPF,
-	DIE_CALL,
 	DIE_NMI_IPI,
 	DIE_PAGE_FAULT,
 };

