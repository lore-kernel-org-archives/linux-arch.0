From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2] locking: add default arch_*_relax definitions for GENERIC_LOCKBREAK
Date: Tue, 23 Jul 2013 18:50:52 +0100
Message-ID: <1374601852-8360-1-git-send-email-will.deacon@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:45942 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933659Ab3GWRvM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 23 Jul 2013 13:51:12 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: akpm@linux-foundation.org, Will Deacon <will.deacon@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>

When running with GENERIC_LOCKBREAK=y, the locking implementations emit
calls to arch_{read,write,spin}_relax when spinning on a contended lock
in order to allow architectures to favour the CPU owning the lock if
possible.

In reality, everybody apart from PowerPC and S390 just does cpu_relax()
here, so make that the default behaviour and allow it to be overridden
if required.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---

Hi guys,

This is v2 of the RFC I sent last month (got tied up with conferences
since then):

http://marc.info/?l=linux-arch&m=137183506819071&w=2

I have corresponding arch/ changes, but I'd like to get the core change
merged first so that I don't inadvertently break things if the arch/
patches are merged out-of-order.

Cheers,

Will

 kernel/spinlock.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/spinlock.c b/kernel/spinlock.c
index 5cdd806..4b082b5 100644
--- a/kernel/spinlock.c
+++ b/kernel/spinlock.c
@@ -34,6 +34,20 @@
 #else
 #define raw_read_can_lock(l)	read_can_lock(l)
 #define raw_write_can_lock(l)	write_can_lock(l)
+
+/*
+ * Some architectures can relax in favour of the CPU owning the lock.
+ */
+#ifndef arch_read_relax
+# define arch_read_relax(l)	cpu_relax()
+#endif
+#ifndef arch_write_relax
+# define arch_write_relax(l)	cpu_relax()
+#endif
+#ifndef arch_spin_relax
+# define arch_spin_relax(l)	cpu_relax()
+#endif
+
 /*
  * We build the __lock_function inlines here. They are too large for
  * inlining all over the place, but here is only one user per function
-- 
1.8.2.2
