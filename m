From: Waiman Long <longman@redhat.com>
Subject: [PATCH 4/5] locking/qspinlock_stat: Allow QUEUED_LOCK_STAT for all archs
Date: Sun, 20 Jan 2019 21:49:53 -0500
Message-ID: <1548038994-30073-5-git-send-email-longman@redhat.com>
References: <1548038994-30073-1-git-send-email-longman@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1548038994-30073-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, Zhenzhong Duan <zhenzhong.duan@oracle.com>, James Morse <james.morse@arm.com>, SRINIVAS <srinivas.eeda@oracle.com>, Waiman Long <longman@redhat.com>
List-Id: linux-arch.vger.kernel.org

The QUEUED_LOCK_STAT option to report queued spinlocks statistics was
previously allowed only on x86 architecture. Now queued spinlocks are
used in multiple architectures, we now allow QUEUED_LOCK_STAT to be
enabled for all those architectures that use queued spinlocks. This
option is listed as part of the general architecture-dependent options.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 arch/Kconfig     | 7 +++++++
 arch/x86/Kconfig | 8 --------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 4cfb6de..c82e32f 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -885,6 +885,13 @@ config HAVE_ARCH_PREL32_RELOCATIONS
 	  architectures, and don't require runtime relocation on relocatable
 	  kernels.
 
+config QUEUED_LOCK_STAT
+	bool "Queued spinlock statistics"
+	depends on QUEUED_SPINLOCKS && DEBUG_FS
+	---help---
+	  Enable the collection of statistical data on the slowpath
+	  behavior of queued spinlocks and report them on debugfs.
+
 source "kernel/gcov/Kconfig"
 
 source "scripts/gcc-plugins/Kconfig"
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4b4a7f3..872e681 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -784,14 +784,6 @@ config PARAVIRT_SPINLOCKS
 
 	  If you are unsure how to answer this question, answer Y.
 
-config QUEUED_LOCK_STAT
-	bool "Paravirt queued spinlock statistics"
-	depends on PARAVIRT_SPINLOCKS && DEBUG_FS
-	---help---
-	  Enable the collection of statistical data on the slowpath
-	  behavior of paravirtualized queued spinlocks and report
-	  them on debugfs.
-
 source "arch/x86/xen/Kconfig"
 
 config KVM_GUEST
-- 
1.8.3.1
