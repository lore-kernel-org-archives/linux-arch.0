Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37834 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932196AbdJaPwQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 31 Oct 2017 11:52:16 -0400
From: Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH v5 23/30] arm64/sve: Add sysctl to set the default vector length for new processes
Date: Tue, 31 Oct 2017 15:51:15 +0000
Message-ID: <1509465082-30427-24-git-send-email-Dave.Martin@arm.com>
In-Reply-To: <1509465082-30427-1-git-send-email-Dave.Martin@arm.com>
References: <1509465082-30427-1-git-send-email-Dave.Martin@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Okamoto Takayuki <tokamoto@jp.fujitsu.com>, kvmarm@lists.cs.columbia.edu, libc-alpha@sourceware.org, linux-arch@vger.kernel.org
Message-ID: <20171031155115.XyJWzJ60HAk6lJq0yD_MjiU6glvtBPfvXCKfIL43QKU@z>

Because of the effect of SVE on the size of the signal frame, the
default vector length used for new processes involves a tradeoff
between performance of SVE-enabled software on the one hand, and
reliability of non-SVE-aware software on the other hand.

For this reason, the best choice depends on the repertoire of
userspace software in use and is thus best left up to distro
maintainers, sysadmins and developers.

If CONFIG_SYSCTL and CONFIG_PROC_SYSCTL are enabled, this patch
exposes the default vector length in
/proc/sys/abi/sve_default_vector_length, where boot scripts or the
adventurous can poke it.

In common with other arm64 ABI sysctls, this control is currently
global: setting it requires CAP_SYS_ADMIN in the root user
namespace, but the value set is effective for subsequent execs in
all namespaces.  The control only affects _new_ processes, however:
changing it does not affect the vector length of any existing
process.

The intended usage model is that if userspace is known to be fully
SVE-tolerant (or a developer is curious to find out) then this
parameter can be cranked up during system startup.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/kernel/fpsimd.c | 62 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index cbb2c63..4da64fc 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -36,6 +36,7 @@
 #include <linux/sched/signal.h>
 #include <linux/signal.h>
 #include <linux/slab.h>
+#include <linux/sysctl.h>
 
 #include <asm/fpsimd.h>
 #include <asm/cputype.h>
@@ -334,6 +335,65 @@ static unsigned int find_supported_vector_length(unsigned int vl)
 	return sve_vl_from_vq(bit_to_vq(bit));
 }
 
+#ifdef CONFIG_SYSCTL
+
+static int sve_proc_do_default_vl(struct ctl_table *table, int write,
+				  void __user *buffer, size_t *lenp,
+				  loff_t *ppos)
+{
+	int ret;
+	int vl = sve_default_vl;
+	struct ctl_table tmp_table = {
+		.data = &vl,
+		.maxlen = sizeof(vl),
+	};
+
+	ret = proc_dointvec(&tmp_table, write, buffer, lenp, ppos);
+	if (ret || !write)
+		return ret;
+
+	/* Writing -1 has the special meaning "set to max": */
+	if (vl == -1) {
+		/* Fail safe if sve_max_vl wasn't initialised */
+		if (WARN_ON(!sve_vl_valid(sve_max_vl)))
+			vl = SVE_VL_MIN;
+		else
+			vl = sve_max_vl;
+
+		goto chosen;
+	}
+
+	if (!sve_vl_valid(vl))
+		return -EINVAL;
+
+	vl = find_supported_vector_length(vl);
+chosen:
+	sve_default_vl = vl;
+	return 0;
+}
+
+static struct ctl_table sve_default_vl_table[] = {
+	{
+		.procname	= "sve_default_vector_length",
+		.mode		= 0644,
+		.proc_handler	= sve_proc_do_default_vl,
+	},
+	{ }
+};
+
+static int __init sve_sysctl_init(void)
+{
+	if (system_supports_sve())
+		if (!register_sysctl("abi", sve_default_vl_table))
+			return -EINVAL;
+
+	return 0;
+}
+
+#else /* ! CONFIG_SYSCTL */
+static int __init sve_sysctl_init(void) { return 0; }
+#endif /* ! CONFIG_SYSCTL */
+
 #define ZREG(sve_state, vq, n) ((char *)(sve_state) +		\
 	(SVE_SIG_ZREG_OFFSET(vq, n) - SVE_SIG_REGS_OFFSET))
 
@@ -1208,6 +1268,6 @@ static int __init fpsimd_init(void)
 	if (!(elf_hwcap & HWCAP_ASIMD))
 		pr_notice("Advanced SIMD is not implemented\n");
 
-	return 0;
+	return sve_sysctl_init();
 }
 core_initcall(fpsimd_init);
-- 
2.1.4
