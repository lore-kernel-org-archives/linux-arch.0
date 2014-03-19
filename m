From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 20/31] arch,openrisc: Convert smp_mb__*
Date: Wed, 19 Mar 2014 07:47:49 +0100
Message-ID: <20140319065204.852399868@infradead.org>
References: <20140319064729.660482086@infradead.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:52974 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756155AbaCSG42 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 19 Mar 2014 02:56:28 -0400
Content-Disposition: inline; filename=peterz-openrisc-smp_mb__atomic.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org, mingo@kernel.org, will.deacon@arm.com, paulmck@linux.vnet.ibm.com, Peter Zijlstra <peterz@infradead.org>

Openrisc fully relies on asm-generic/barrier.h and therefore its
smp_mb() is barrier().

Signed-off-by: Peter Zijlstra <peterz@infradead.org>
---
 arch/openrisc/include/asm/bitops.h |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

--- a/arch/openrisc/include/asm/bitops.h
+++ b/arch/openrisc/include/asm/bitops.h
@@ -27,14 +27,7 @@
 
 #include <linux/irqflags.h>
 #include <linux/compiler.h>
-
-/*
- * clear_bit may not imply a memory barrier
- */
-#ifndef smp_mb__before_clear_bit
-#define smp_mb__before_clear_bit()	smp_mb()
-#define smp_mb__after_clear_bit()	smp_mb()
-#endif
+#include <asm/barrier.h>
 
 #include <asm/bitops/__ffs.h>
 #include <asm-generic/bitops/ffz.h>
