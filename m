From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v7 20/29] arm64: mte: Restore the GCR_EL1 register after a suspend
Date: Wed, 15 Jul 2020 18:08:35 +0100
Message-ID: <20200715170844.30064-21-catalin.marinas@arm.com>
References: <20200715170844.30064-1-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726777AbgGORJg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Jul 2020 13:09:36 -0400
In-Reply-To: <20200715170844.30064-1-catalin.marinas@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Dave P Martin <Dave.Martin@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Peter Collingbourne <pcc@google.com>, Andrew Morton <akpm@linux-foundation.org>

The CPU resume/suspend routines only take care of the common system
registers. Restore GCR_EL1 in addition via the __cpu_suspend_exit()
function.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---

Notes:
    New in v3.

 arch/arm64/include/asm/mte.h | 4 ++++
 arch/arm64/kernel/mte.c      | 8 ++++++++
 arch/arm64/kernel/suspend.c  | 4 ++++
 3 files changed, 16 insertions(+)

diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
index df2efbc9f8f1..c93047eff9fe 100644
--- a/arch/arm64/include/asm/mte.h
+++ b/arch/arm64/include/asm/mte.h
@@ -22,6 +22,7 @@ void mte_sync_tags(pte_t *ptep, pte_t pte);
 void mte_copy_page_tags(void *kto, const void *kfrom);
 void flush_mte_state(void);
 void mte_thread_switch(struct task_struct *next);
+void mte_suspend_exit(void);
 long set_mte_ctrl(unsigned long arg);
 long get_mte_ctrl(void);
 
@@ -42,6 +43,9 @@ static inline void flush_mte_state(void)
 static inline void mte_thread_switch(struct task_struct *next)
 {
 }
+static inline void mte_suspend_exit(void)
+{
+}
 static inline long set_mte_ctrl(unsigned long arg)
 {
 	return 0;
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index 07798b8d5039..09cf76fc1090 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -116,6 +116,14 @@ void mte_thread_switch(struct task_struct *next)
 	update_gcr_el1_excl(next->thread.gcr_user_incl);
 }
 
+void mte_suspend_exit(void)
+{
+	if (!system_supports_mte())
+		return;
+
+	update_gcr_el1_excl(current->thread.gcr_user_incl);
+}
+
 long set_mte_ctrl(unsigned long arg)
 {
 	u64 tcf0;
diff --git a/arch/arm64/kernel/suspend.c b/arch/arm64/kernel/suspend.c
index c1dee9066ff9..62c239cd60c2 100644
--- a/arch/arm64/kernel/suspend.c
+++ b/arch/arm64/kernel/suspend.c
@@ -10,6 +10,7 @@
 #include <asm/daifflags.h>
 #include <asm/debug-monitors.h>
 #include <asm/exec.h>
+#include <asm/mte.h>
 #include <asm/memory.h>
 #include <asm/mmu_context.h>
 #include <asm/smp_plat.h>
@@ -74,6 +75,9 @@ void notrace __cpu_suspend_exit(void)
 	 */
 	if (arm64_get_ssbd_state() == ARM64_SSBD_FORCE_DISABLE)
 		arm64_set_ssbd_mitigation(false);
+
+	/* Restore additional MTE-specific configuration */
+	mte_suspend_exit();
 }
 
 /*
