Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jA93B7nO009323
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linux-arch@vger.kernel.org>; Tue, 8 Nov 2005 19:11:08 -0800
Received: from bix (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id jA93B7gI003676
	for <linux-arch@vger.kernel.org>; Tue, 8 Nov 2005 19:11:07 -0800
Date: Tue, 8 Nov 2005 19:10:57 -0800
From: Andrew Morton <akpm@osdl.org>
Subject: irq-type-flags.patch
Message-Id: <20051108191057.09f57114.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


Is everyone OK with this?


From: Russell King <rmk+lkml@arm.linux.org.uk>

Some ARM platforms have the ability to program the interrupt controller to
detect various interrupt edges and/or levels.  For some platforms, this is
critical to setup correctly, particularly those which the setting is
dependent on the device.

Currently, ARM drivers do (eg) the following:

	err = request_irq(irq, ...);

	set_irq_type(irq, IRQT_RISING);

However, if the interrupt has previously been programmed to be level
sensitive (for whatever reason) then this will cause an interrupt storm.

Hence, if we combine set_irq_type() with request_irq(), we can then safely
set the type prior to unmasking the interrupt.  The unfortunate problem is
that in order to support this, these flags need to be visible outside of
the ARM architecture - drivers such as smc91x need these flags and they're
cross-architecture.

Finally, the SA_TRIGGER_* flag passed to request_irq() should reflect the
property that the device would like.  The IRQ controller code should do its
best to select the most appropriate supported mode.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/arm/kernel/irq.c  |   16 ++++++++++++++--
 include/linux/signal.h |    8 ++++++++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff -puN arch/arm/kernel/irq.c~irq-type-flags arch/arm/kernel/irq.c
--- devel/arch/arm/kernel/irq.c~irq-type-flags	2005-11-06 00:55:46.000000000 -0800
+++ devel-akpm/arch/arm/kernel/irq.c	2005-11-06 00:55:46.000000000 -0800
@@ -681,10 +681,16 @@ int setup_irq(unsigned int irq, struct i
 	 */
 	desc = irq_desc + irq;
 	spin_lock_irqsave(&irq_controller_lock, flags);
+#define SA_TRIGGER	(SA_TRIGGER_HIGH|SA_TRIGGER_LOW|\
+			 SA_TRIGGER_RISING|SA_TRIGGER_FALLING)
 	p = &desc->action;
 	if ((old = *p) != NULL) {
-		/* Can't share interrupts unless both agree to */
-		if (!(old->flags & new->flags & SA_SHIRQ)) {
+		/*
+		 * Can't share interrupts unless both agree to and are
+		 * the same type.
+		 */
+		if (!(old->flags & new->flags & SA_SHIRQ) ||
+		    (~old->flags & new->flags) & SA_TRIGGER) {
 			spin_unlock_irqrestore(&irq_controller_lock, flags);
 			return -EBUSY;
 		}
@@ -704,6 +710,12 @@ int setup_irq(unsigned int irq, struct i
 		desc->running = 0;
 		desc->pending = 0;
 		desc->disable_depth = 1;
+
+		if (new->flags & SA_TRIGGER) {
+			unsigned int type = new->flags & SA_TRIGGER;
+			desc->chip->set_type(irq, type);
+		}
+
 		if (!desc->noautoenable) {
 			desc->disable_depth = 0;
 			desc->chip->unmask(irq);
diff -puN include/linux/signal.h~irq-type-flags include/linux/signal.h
--- devel/include/linux/signal.h~irq-type-flags	2005-11-06 00:55:46.000000000 -0800
+++ devel-akpm/include/linux/signal.h	2005-11-06 00:55:46.000000000 -0800
@@ -18,6 +18,14 @@
 #define SA_PROBE		SA_ONESHOT
 #define SA_SAMPLE_RANDOM	SA_RESTART
 #define SA_SHIRQ		0x04000000
+/*
+ * As above, these correspond to the __IRQT defines in asm-arm/irq.h
+ * to select the interrupt line behaviour.
+ */
+#define SA_TRIGGER_HIGH		0x00000008
+#define SA_TRIGGER_LOW		0x00000004
+#define SA_TRIGGER_RISING	0x00000002
+#define SA_TRIGGER_FALLING	0x00000001
 
 /*
  * Real Time signals may be queued.
_
