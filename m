From: Pu Wen <puwen@hygon.cn>
Subject: [PATCH v5 10/16] x86/mce: enable Hygon support to MCE infrastructure
Date: Wed, 29 Aug 2018 20:44:54 +0800
Message-ID: <c1e803bc54984e54ca67278930588e85b65bb26f.1535459013.git.puwen@hygon.cn>
References: <cover.1535459012.git.puwen@hygon.cn>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1535459012.git.puwen@hygon.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, bp@alien8.de, pbonzini@redhat.com, tony.luck@intel.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-edac@vger.kernel.org, Pu Wen <puwen@hygon.cn>
List-Id: linux-arch.vger.kernel.org

Hygon machine check arch is similar to AMD family 17h. To enable the MCE
infrastructure support, add CPU vendor check for Hygon to share the code
path of AMD.

Add hygon mce init function mce_hygon_feature_init() to minimize further
maintenance effort.

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 arch/x86/include/asm/mce.h                |  5 +++++
 arch/x86/kernel/cpu/mcheck/mce-severity.c |  3 ++-
 arch/x86/kernel/cpu/mcheck/mce.c          | 21 +++++++++++++++------
 3 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 3a17107..12357aa 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -214,6 +214,11 @@ static inline void mce_amd_feature_init(struct cpuinfo_x86 *c) { }
 static inline int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr) { return -EINVAL; };
 #endif
 
+static inline void mce_hygon_feature_init(struct cpuinfo_x86 *c)
+{
+	return mce_amd_feature_init(c);
+}
+
 int mce_available(struct cpuinfo_x86 *c);
 bool mce_is_memory_error(struct mce *m);
 
diff --git a/arch/x86/kernel/cpu/mcheck/mce-severity.c b/arch/x86/kernel/cpu/mcheck/mce-severity.c
index f34d89c..44396d5 100644
--- a/arch/x86/kernel/cpu/mcheck/mce-severity.c
+++ b/arch/x86/kernel/cpu/mcheck/mce-severity.c
@@ -336,7 +336,8 @@ int (*mce_severity)(struct mce *m, int tolerant, char **msg, bool is_excp) =
 
 void __init mcheck_vendor_init_severity(void)
 {
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
 		mce_severity = mce_severity_amd;
 }
 
diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index 953b3ce..12408a1 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -270,7 +270,8 @@ static void print_mce(struct mce *m)
 {
 	__print_mce(m);
 
-	if (m->cpuvendor != X86_VENDOR_AMD)
+	if (m->cpuvendor != X86_VENDOR_AMD &&
+	    m->cpuvendor != X86_VENDOR_HYGON)
 		pr_emerg_ratelimited(HW_ERR "Run the above through 'mcelog --ascii'\n");
 }
 
@@ -508,9 +509,9 @@ static int mce_usable_address(struct mce *m)
 
 bool mce_is_memory_error(struct mce *m)
 {
-	if (m->cpuvendor == X86_VENDOR_AMD) {
+	if (m->cpuvendor == X86_VENDOR_AMD ||
+	    m->cpuvendor == X86_VENDOR_HYGON) {
 		return amd_mce_is_memory_error(m);
-
 	} else if (m->cpuvendor == X86_VENDOR_INTEL) {
 		/*
 		 * Intel SDM Volume 3B - 15.9.2 Compound Error Codes
@@ -536,7 +537,9 @@ EXPORT_SYMBOL_GPL(mce_is_memory_error);
 
 static bool mce_is_correctable(struct mce *m)
 {
-	if (m->cpuvendor == X86_VENDOR_AMD && m->status & MCI_STATUS_DEFERRED)
+	if ((m->cpuvendor == X86_VENDOR_AMD ||
+	     m->cpuvendor == X86_VENDOR_HYGON) &&
+	    (m->status & MCI_STATUS_DEFERRED))
 		return false;
 
 	if (m->status & MCI_STATUS_UC)
@@ -1705,7 +1708,8 @@ static int __mcheck_cpu_ancient_init(struct cpuinfo_x86 *c)
  */
 static void __mcheck_cpu_init_early(struct cpuinfo_x86 *c)
 {
-	if (c->x86_vendor == X86_VENDOR_AMD) {
+	if (c->x86_vendor == X86_VENDOR_AMD ||
+	    c->x86_vendor == X86_VENDOR_HYGON) {
 		mce_flags.overflow_recov = !!cpu_has(c, X86_FEATURE_OVERFLOW_RECOV);
 		mce_flags.succor	 = !!cpu_has(c, X86_FEATURE_SUCCOR);
 		mce_flags.smca		 = !!cpu_has(c, X86_FEATURE_SMCA);
@@ -1746,6 +1750,9 @@ static void __mcheck_cpu_init_vendor(struct cpuinfo_x86 *c)
 		mce_amd_feature_init(c);
 		break;
 		}
+	case X86_VENDOR_HYGON:
+		mce_hygon_feature_init(c);
+		break;
 	case X86_VENDOR_CENTAUR:
 		mce_centaur_feature_init(c);
 		break;
@@ -1971,12 +1978,14 @@ static void mce_disable_error_reporting(void)
 static void vendor_disable_error_reporting(void)
 {
 	/*
-	 * Don't clear on Intel or AMD CPUs. Some of these MSRs are socket-wide.
+	 * Don't clear on Intel or AMD or Hygon CPUs. Some of these MSRs
+	 * are socket-wide.
 	 * Disabling them for just a single offlined CPU is bad, since it will
 	 * inhibit reporting for all shared resources on the socket like the
 	 * last level cache (LLC), the integrated memory controller (iMC), etc.
 	 */
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL ||
+	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON ||
 	    boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
 		return;
 
-- 
2.7.4
