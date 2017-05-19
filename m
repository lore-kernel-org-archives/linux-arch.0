From: Babu Moger <babu.moger@oracle.com>
Subject: [PATCH 6/6] arch/sparc: Enable queued spinlock support for SPARC
Date: Thu, 18 May 2017 18:36:10 -0600
Message-ID: <1495154170-854693-7-git-send-email-babu.moger@oracle.com>
References: <1495154170-854693-1-git-send-email-babu.moger@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:46441 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755036AbdESAhR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 May 2017 20:37:17 -0400
In-Reply-To: <1495154170-854693-1-git-send-email-babu.moger@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: davem@davemloft.net, peterz@infradead.org, mingo@redhat.com, arnd@arndb.de
Cc: babu.moger@oracle.com, shannon.nelson@oracle.com, haakon.bugge@oracle.com, steven.sistare@oracle.com, vijay.ac.kumar@oracle.com, jane.chu@oracle.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

This patch makes the necessary changes in SPARC architecture to enable
queued spinlock support. Here are some of the earlier discussions about
this feature.
https://lwn.net/Articles/561775/
https://lwn.net/Articles/590243/

Signed-off-by: Babu Moger <babu.moger@oracle.com>
Reviewed-by: Håkon Bugge <haakon.bugge@oracle.com>
Reviewed-by: Jane Chu <jane.chu@oracle.com>
Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
Reviewed-by: Vijay Kumar <vijay.ac.kumar@oracle.com>
---
 arch/sparc/Kconfig                      |    1 +
 arch/sparc/include/asm/qspinlock.h      |    7 +++++++
 arch/sparc/include/asm/spinlock_64.h    |    4 ++++
 arch/sparc/include/asm/spinlock_types.h |    5 +++++
 4 files changed, 17 insertions(+), 0 deletions(-)
 create mode 100644 arch/sparc/include/asm/qspinlock.h

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index caeda1c..785bf3e 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -83,6 +83,7 @@ config SPARC64
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select HAVE_NMI
 	select ARCH_USE_QUEUED_RWLOCKS
+	select ARCH_USE_QUEUED_SPINLOCKS
 
 config ARCH_DEFCONFIG
 	string
diff --git a/arch/sparc/include/asm/qspinlock.h b/arch/sparc/include/asm/qspinlock.h
new file mode 100644
index 0000000..5ae9a28
--- /dev/null
+++ b/arch/sparc/include/asm/qspinlock.h
@@ -0,0 +1,7 @@
+#ifndef _ASM_SPARC_QSPINLOCK_H
+#define _ASM_SPARC_QSPINLOCK_H
+
+#include <asm-generic/qspinlock_types.h>
+#include <asm-generic/qspinlock.h>
+
+#endif /* _ASM_SPARC_QSPINLOCK_H */
diff --git a/arch/sparc/include/asm/spinlock_64.h b/arch/sparc/include/asm/spinlock_64.h
index 562dbd8..e2044e3 100644
--- a/arch/sparc/include/asm/spinlock_64.h
+++ b/arch/sparc/include/asm/spinlock_64.h
@@ -11,6 +11,9 @@
 #include <asm/processor.h>
 #include <asm/barrier.h>
 
+#ifdef CONFIG_QUEUED_SPINLOCKS
+#include <asm/qspinlock.h>
+#else
 /* To get debugging spinlocks which detect and catch
  * deadlock situations, set CONFIG_DEBUG_SPINLOCK
  * and rebuild your kernel.
@@ -93,6 +96,7 @@ static inline void arch_spin_lock_flags(arch_spinlock_t *lock, unsigned long fla
 	: "r"(lock), "r"(flags)
 	: "memory");
 }
+#endif /*ifdef CONFIG_QUEUED_SPINLOCKS */
 
 #ifndef CONFIG_QUEUED_RWLOCKS
 /* Multi-reader locks, these are much saner than the 32-bit Sparc ones... */
diff --git a/arch/sparc/include/asm/spinlock_types.h b/arch/sparc/include/asm/spinlock_types.h
index e052d28..93c8c5a 100644
--- a/arch/sparc/include/asm/spinlock_types.h
+++ b/arch/sparc/include/asm/spinlock_types.h
@@ -5,11 +5,16 @@
 # error "please don't include this file directly"
 #endif
 
+#ifdef CONFIG_QUEUED_SPINLOCKS
+#include <asm-generic/qspinlock_types.h>
+#else
+
 typedef struct {
 	volatile unsigned char lock;
 } arch_spinlock_t;
 
 #define __ARCH_SPIN_LOCK_UNLOCKED	{ 0 }
+#endif /* CONFIG_QUEUED_SPINLOCKS */
 
 #ifdef CONFIG_QUEUED_RWLOCKS
 #include <asm-generic/qrwlock_types.h>
-- 
1.7.1
