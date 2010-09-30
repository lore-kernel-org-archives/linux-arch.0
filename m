From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 45/47] x86: lguest: Use new irq allocator
Date: Thu, 30 Sep 2010 23:18:23 -0000
Message-ID: <20100930221742.917282584@linutronix.de>
References: <20100930221351.682772535@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=x86-lguest-use-new-allocator.patch
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-arch@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mundt <lethal@linux-sh.org>, Russell King <linux@arm.linux.org.uk>, David Woodhouse <dwmw2@infradead.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Yinghai Lu <yinghai@kernel.org>, Grant Likely <grant.likely@secretlab.ca>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-arch.vger.kernel.org

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/lguest/boot.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6-tip/arch/x86/lguest/boot.c
===================================================================
--- linux-2.6-tip.orig/arch/x86/lguest/boot.c
+++ linux-2.6-tip/arch/x86/lguest/boot.c
@@ -835,12 +835,12 @@ static void __init lguest_init_IRQ(void)
  * rather than set them in lguest_init_IRQ we are called here every time an
  * lguest device needs an interrupt.
  *
- * FIXME: irq_to_desc_alloc_node() can fail due to lack of memory, we should
+ * FIXME: irq_alloc_desc_at() can fail due to lack of memory, we should
  * pass that up!
  */
 void lguest_setup_irq(unsigned int irq)
 {
-	irq_to_desc_alloc_node(irq, 0);
+	irq_alloc_desc_at(irq, 0);
 	set_irq_chip_and_handler_name(irq, &lguest_irq_controller,
 				      handle_level_irq, "level");
 }
