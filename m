From: David Howells <dhowells@redhat.com>
Subject: [PATCH 13/22] MIPS: Fix IRQ flags handling
Date: Fri, 27 Aug 2010 03:00:12 +0100
Message-ID: <20100827020012.27277.65923.stgit@warthog.procyon.org.uk>
References: <20100827015905.27277.39167.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100827015905.27277.39167.stgit@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


---

 arch/mips/include/asm/irqflags.h |   53 +++++++++++++++++++++-----------------
 1 files changed, 29 insertions(+), 24 deletions(-)

diff --git a/arch/mips/include/asm/irqflags.h b/arch/mips/include/asm/irqflags.h
index 701ec0b..9ef3b0d 100644
--- a/arch/mips/include/asm/irqflags.h
+++ b/arch/mips/include/asm/irqflags.h
@@ -17,7 +17,7 @@
 #include <asm/hazards.h>
 
 __asm__(
-	"	.macro	raw_local_irq_enable				\n"
+	"	.macro	arch_local_irq_enable				\n"
 	"	.set	push						\n"
 	"	.set	reorder						\n"
 	"	.set	noat						\n"
@@ -40,7 +40,7 @@ __asm__(
 
 extern void smtc_ipi_replay(void);
 
-static inline void raw_local_irq_enable(void)
+static inline void arch_local_irq_enable(void)
 {
 #ifdef CONFIG_MIPS_MT_SMTC
 	/*
@@ -50,7 +50,7 @@ static inline void raw_local_irq_enable(void)
 	smtc_ipi_replay();
 #endif
 	__asm__ __volatile__(
-		"raw_local_irq_enable"
+		"arch_local_irq_enable"
 		: /* no outputs */
 		: /* no inputs */
 		: "memory");
@@ -76,7 +76,7 @@ static inline void raw_local_irq_enable(void)
  * Workaround: mask EXL bit of the result or place a nop before mfc0.
  */
 __asm__(
-	"	.macro	raw_local_irq_disable\n"
+	"	.macro	arch_local_irq_disable\n"
 	"	.set	push						\n"
 	"	.set	noat						\n"
 #ifdef CONFIG_MIPS_MT_SMTC
@@ -97,17 +97,17 @@ __asm__(
 	"	.set	pop						\n"
 	"	.endm							\n");
 
-static inline void raw_local_irq_disable(void)
+static inline void arch_local_irq_disable(void)
 {
 	__asm__ __volatile__(
-		"raw_local_irq_disable"
+		"arch_local_irq_disable"
 		: /* no outputs */
 		: /* no inputs */
 		: "memory");
 }
 
 __asm__(
-	"	.macro	raw_local_save_flags flags			\n"
+	"	.macro	arch_local_save_flags flags			\n"
 	"	.set	push						\n"
 	"	.set	reorder						\n"
 #ifdef CONFIG_MIPS_MT_SMTC
@@ -118,13 +118,15 @@ __asm__(
 	"	.set	pop						\n"
 	"	.endm							\n");
 
-#define raw_local_save_flags(x)						\
-__asm__ __volatile__(							\
-	"raw_local_save_flags %0"					\
-	: "=r" (x))
+static inline unsigned long arch_local_save_flags(void)
+{
+	unsigned long flags;
+	asm volatile("arch_local_save_flags %0" : "=r" (flags));
+	return flags;
+}
 
 __asm__(
-	"	.macro	raw_local_irq_save result			\n"
+	"	.macro	arch_local_irq_save result			\n"
 	"	.set	push						\n"
 	"	.set	reorder						\n"
 	"	.set	noat						\n"
@@ -148,15 +150,18 @@ __asm__(
 	"	.set	pop						\n"
 	"	.endm							\n");
 
-#define raw_local_irq_save(x)						\
-__asm__ __volatile__(							\
-	"raw_local_irq_save\t%0"					\
-	: "=r" (x)							\
-	: /* no inputs */						\
-	: "memory")
+static inline unsigned long arch_local_irq_save(void)
+{
+	unsigned long flags;
+	asm volatile("arch_local_irq_save\t%0"
+		     : "=r" (flags)
+		     : /* no inputs */
+		     : "memory");
+	return flags;
+}
 
 __asm__(
-	"	.macro	raw_local_irq_restore flags			\n"
+	"	.macro	arch_local_irq_restore flags			\n"
 	"	.set	push						\n"
 	"	.set	noreorder					\n"
 	"	.set	noat						\n"
@@ -196,7 +201,7 @@ __asm__(
 	"	.endm							\n");
 
 
-static inline void raw_local_irq_restore(unsigned long flags)
+static inline void arch_local_irq_restore(unsigned long flags)
 {
 	unsigned long __tmp1;
 
@@ -211,24 +216,24 @@ static inline void raw_local_irq_restore(unsigned long flags)
 #endif
 
 	__asm__ __volatile__(
-		"raw_local_irq_restore\t%0"
+		"arch_local_irq_restore\t%0"
 		: "=r" (__tmp1)
 		: "0" (flags)
 		: "memory");
 }
 
-static inline void __raw_local_irq_restore(unsigned long flags)
+static inline void __arch_local_irq_restore(unsigned long flags)
 {
 	unsigned long __tmp1;
 
 	__asm__ __volatile__(
-		"raw_local_irq_restore\t%0"
+		"arch_local_irq_restore\t%0"
 		: "=r" (__tmp1)
 		: "0" (flags)
 		: "memory");
 }
 
-static inline int raw_irqs_disabled_flags(unsigned long flags)
+static inline int arch_irqs_disabled_flags(unsigned long flags)
 {
 #ifdef CONFIG_MIPS_MT_SMTC
 	/*
