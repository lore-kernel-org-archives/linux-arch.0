From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 20/22] arm64: mte: Allow user control of the excluded tags via
 prctl()
Date: Wed, 11 Dec 2019 18:40:25 +0000
Message-ID: <20191211184027.20130-21-catalin.marinas@arm.com>
References: <20191211184027.20130-1-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191211184027.20130-1-catalin.marinas@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-arch@vger.kernel.org, Richard Earnshaw <Richard.Earnshaw@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Marc Zyngier <maz@kernel.org>, Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org, Andrey Konovalov <andreyknvl@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Will Deacon <will@kernel.org>
List-Id: linux-arch.vger.kernel.org

The IRG, ADDG and SUBG instructions insert a random tag in the resulting
address. Certain tags can be excluded via the GCR_EL1.Exclude bitmap
when, for example, the user wants a certain colour for freed buffers.
Since the GCR_EL1 register is not accessible at EL0, extend the
prctl(PR_SET_TAGGED_ADDR_CTRL) interface to include a 16-bit field in
the first argument for controlling the excluded tags. This setting is
pre-thread.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/processor.h |  1 +
 arch/arm64/include/asm/sysreg.h    |  7 +++++++
 arch/arm64/kernel/process.c        | 27 +++++++++++++++++++++++----
 include/uapi/linux/prctl.h         |  3 +++
 4 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 91aa270afc7d..5b6988035334 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -150,6 +150,7 @@ struct thread_struct {
 #endif
 #ifdef CONFIG_ARM64_MTE
 	u64			sctlr_tcf0;
+	u64			gcr_excl;
 #endif
 };
 
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 9e5753272f4b..b6bb6d31f1cd 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -901,6 +901,13 @@
 		write_sysreg(__scs_new, sysreg);			\
 } while (0)
 
+#define sysreg_clear_set_s(sysreg, clear, set) do {			\
+	u64 __scs_val = read_sysreg_s(sysreg);				\
+	u64 __scs_new = (__scs_val & ~(u64)(clear)) | (set);		\
+	if (__scs_new != __scs_val)					\
+		write_sysreg_s(__scs_new, sysreg);			\
+} while (0)
+
 #endif
 
 #endif	/* __ASM_SYSREG_H */
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 47ce98f47253..5ec6889795fc 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -502,6 +502,15 @@ static void update_sctlr_el1_tcf0(u64 tcf0)
 	sysreg_clear_set(sctlr_el1, SCTLR_EL1_TCF0_MASK, tcf0);
 }
 
+static void update_gcr_el1_excl(u64 excl)
+{
+	/*
+	 * No need for ISB since this only affects EL0 currently, implicit
+	 * with ERET.
+	 */
+	sysreg_clear_set_s(SYS_GCR_EL1, SYS_GCR_EL1_EXCL_MASK, excl);
+}
+
 /* Handle MTE thread switch */
 static void mte_thread_switch(struct task_struct *next)
 {
@@ -511,6 +520,7 @@ static void mte_thread_switch(struct task_struct *next)
 	/* avoid expensive SCTLR_EL1 accesses if no change */
 	if (current->thread.sctlr_tcf0 != next->thread.sctlr_tcf0)
 		update_sctlr_el1_tcf0(next->thread.sctlr_tcf0);
+	update_gcr_el1_excl(next->thread.gcr_excl);
 }
 #else
 static void mte_thread_switch(struct task_struct *next)
@@ -641,22 +651,31 @@ static long set_mte_ctrl(unsigned long arg)
 	update_sctlr_el1_tcf0(tcf0);
 	preempt_enable();
 
+	current->thread.gcr_excl = (arg & PR_MTE_EXCL_MASK) >> PR_MTE_EXCL_SHIFT;
+	update_gcr_el1_excl(current->thread.gcr_excl);
+
 	return 0;
 }
 
 static long get_mte_ctrl(void)
 {
+	unsigned long ret;
+
 	if (!system_supports_mte())
 		return 0;
 
+	ret = current->thread.gcr_excl << PR_MTE_EXCL_SHIFT;
+
 	switch (current->thread.sctlr_tcf0) {
 	case SCTLR_EL1_TCF0_SYNC:
-		return PR_MTE_TCF_SYNC;
+		ret |= PR_MTE_TCF_SYNC;
+		break;
 	case SCTLR_EL1_TCF0_ASYNC:
-		return PR_MTE_TCF_ASYNC;
+		ret |= PR_MTE_TCF_ASYNC;
+		break;
 	}
 
-	return 0;
+	return ret;
 }
 #else
 static long set_mte_ctrl(unsigned long arg)
@@ -684,7 +703,7 @@ long set_tagged_addr_ctrl(unsigned long arg)
 		return -EINVAL;
 
 	if (system_supports_mte())
-		valid_mask |= PR_MTE_TCF_MASK;
+		valid_mask |= PR_MTE_TCF_MASK | PR_MTE_EXCL_MASK;
 
 	if (arg & ~valid_mask)
 		return -EINVAL;
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 5e9323e66a38..749de5ab4f9f 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -239,5 +239,8 @@ struct prctl_mm_map {
 # define PR_MTE_TCF_SYNC		(1UL << PR_MTE_TCF_SHIFT)
 # define PR_MTE_TCF_ASYNC		(2UL << PR_MTE_TCF_SHIFT)
 # define PR_MTE_TCF_MASK		(3UL << PR_MTE_TCF_SHIFT)
+/* MTE tag exclusion mask */
+# define PR_MTE_EXCL_SHIFT		3
+# define PR_MTE_EXCL_MASK		(0xffffUL << PR_MTE_EXCL_SHIFT)
 
 #endif /* _LINUX_PRCTL_H */
