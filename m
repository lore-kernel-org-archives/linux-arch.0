Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53076 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754861AbbL3NY2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 30 Dec 2015 08:24:28 -0500
Date: Wed, 30 Dec 2015 15:24:23 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 03/34] ia64: rename nop->iosapic_nop
Message-ID: <1451473761-30019-4-git-send-email-mst@redhat.com>
References: <1451473761-30019-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1451473761-30019-1-git-send-email-mst@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Rusty Russell <rusty@rustcorp.com.au>, Jiang Liu <jiang.liu@linux.intel.com>, linux-ia64@vger.kernel.org
Message-ID: <20151230132423.Hhgz3WLWETHo3dkSMzhngk9gv_LOh6KEI6lNQVy8jO8@z>

asm-generic/barrier.h defines a nop() macro.
To be able to use this header on ia64, we shouldn't
call local functions/variables nop().

There's one instance where this breaks on ia64:
rename the function to iosapic_nop to avoid the conflict.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/ia64/kernel/iosapic.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/ia64/kernel/iosapic.c b/arch/ia64/kernel/iosapic.c
index d2fae05..90fde5b 100644
--- a/arch/ia64/kernel/iosapic.c
+++ b/arch/ia64/kernel/iosapic.c
@@ -256,7 +256,7 @@ set_rte (unsigned int gsi, unsigned int irq, unsigned int dest, int mask)
 }
 
 static void
-nop (struct irq_data *data)
+iosapic_nop (struct irq_data *data)
 {
 	/* do nothing... */
 }
@@ -415,7 +415,7 @@ iosapic_unmask_level_irq (struct irq_data *data)
 #define iosapic_shutdown_level_irq	mask_irq
 #define iosapic_enable_level_irq	unmask_irq
 #define iosapic_disable_level_irq	mask_irq
-#define iosapic_ack_level_irq		nop
+#define iosapic_ack_level_irq		iosapic_nop
 
 static struct irq_chip irq_type_iosapic_level = {
 	.name =			"IO-SAPIC-level",
@@ -453,7 +453,7 @@ iosapic_ack_edge_irq (struct irq_data *data)
 }
 
 #define iosapic_enable_edge_irq		unmask_irq
-#define iosapic_disable_edge_irq	nop
+#define iosapic_disable_edge_irq	iosapic_nop
 
 static struct irq_chip irq_type_iosapic_edge = {
 	.name =			"IO-SAPIC-edge",
-- 
MST

