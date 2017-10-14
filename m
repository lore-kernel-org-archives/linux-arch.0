From: Yury Norov <ynorov@caviumnetworks.com>
Subject: [PATCH resend] asm-generic: don't #include <linux/atomic.h> in qspinlock_types.h
Date: Sat, 14 Oct 2017 03:06:35 +0300
Message-ID: <20171014000635.7080-1-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bn3nam01on0083.outbound.protection.outlook.com ([104.47.33.83]:60192
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753089AbdJNAGt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 13 Oct 2017 20:06:49 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Yury Norov <ynorov@caviumnetworks.com>, Adam Wallis <awallis@codeaurora.org>, Andrew Pinski <Andrew.Pinski@cavium.com>, Catalin Marinas <catalin.marinas@arm.com>, Ingo Molnar <mingo@redhat.com>, Jan Glauber <jglauber@cavium.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>

The "qspinlock_types.h" doesn't need linux/atomic.h directly. So
because of this, and because including of it requires the protection
against recursive inclusion, it looks reasonable to move the
inclusion exactly where it is needed. This change affects the x86_64
arch, as the only user of qspinlocks at now. I have build-tested the
change on x86_64 with CONFIG_PARAVIRT enabled and disabled.

Rebased on next-20171012

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 include/asm-generic/qspinlock.h       | 1 +
 include/asm-generic/qspinlock_types.h | 8 --------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qspinlock.h
index b37b4ad7eb94..0ae1e1692b9e 100644
--- a/include/asm-generic/qspinlock.h
+++ b/include/asm-generic/qspinlock.h
@@ -20,6 +20,7 @@
 #define __ASM_GENERIC_QSPINLOCK_H
 
 #include <asm-generic/qspinlock_types.h>
+#include <linux/atomic.h>
 
 /**
  * queued_spin_is_locked - is the spinlock locked?
diff --git a/include/asm-generic/qspinlock_types.h b/include/asm-generic/qspinlock_types.h
index 034acd0c4956..a13cc90c87fc 100644
--- a/include/asm-generic/qspinlock_types.h
+++ b/include/asm-generic/qspinlock_types.h
@@ -18,15 +18,7 @@
 #ifndef __ASM_GENERIC_QSPINLOCK_TYPES_H
 #define __ASM_GENERIC_QSPINLOCK_TYPES_H
 
-/*
- * Including atomic.h with PARAVIRT on will cause compilation errors because
- * of recursive header file incluson via paravirt_types.h. So don't include
- * it if PARAVIRT is on.
- */
-#ifndef CONFIG_PARAVIRT
 #include <linux/types.h>
-#include <linux/atomic.h>
-#endif
 
 typedef struct qspinlock {
 	atomic_t	val;
-- 
2.11.0
