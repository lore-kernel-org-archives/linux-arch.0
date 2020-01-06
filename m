From: Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v6][RESEND] x86/hyperv: Suspend/resume the hypercall page for hibernation
Date: Mon,  6 Jan 2020 14:42:39 -0800
Message-ID: <1578350559-130275-1-git-send-email-decui@microsoft.com>
Reply-To: decui@microsoft.com
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de, bp@alien8.de, daniel.lezcano@linaro.org, haiyangz@microsoft.com, hpa@zytor.com, kys@microsoft.com, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, sashal@kernel.org, sthemmin@microsoft.com, tglx@linutronix.de, x86@kernel.org, mikelley@microsoft.com, Alexander.Levin@microsoft.com, vkuznets@redhat.com
Cc: linux-arch@vger.kernel.org, Dexuan Cui <decui@microsoft.com>
List-Id: linux-arch.vger.kernel.org

This is needed for hibernation, e.g. when we resume the old kernel, we need
to disable the "current" kernel's hypercall page and then resume the old
kernel's.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---

This is a RESEND of https://lkml.org/lkml/2019/11/20/68 .

Please review.

If it looks good, can you please pick it up through the tip.git tree?


 arch/x86/hyperv/hv_init.c | 48 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index caaf4dce99bf..24a62d33067c 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -21,11 +21,15 @@
 #include <linux/hyperv.h>
 #include <linux/slab.h>
 #include <linux/cpuhotplug.h>
+#include <linux/syscore_ops.h>
 #include <clocksource/hyperv_timer.h>
 
 void *hv_hypercall_pg;
 EXPORT_SYMBOL_GPL(hv_hypercall_pg);
 
+/* Save the hypercall page temporarily for hibernation */
+static void *hv_hypercall_pg_saved;
+
 u32 *hv_vp_index;
 EXPORT_SYMBOL_GPL(hv_vp_index);
 
@@ -246,6 +250,46 @@ static int __init hv_pci_init(void)
 	return 1;
 }
 
+static int hv_suspend(void)
+{
+	union hv_x64_msr_hypercall_contents hypercall_msr;
+
+	/*
+	 * Reset hypercall page reference before reset the page,
+	 * let hypercall operations fail safely rather than
+	 * panic the kernel for using invalid hypercall page
+	 */
+	hv_hypercall_pg_saved = hv_hypercall_pg;
+	hv_hypercall_pg = NULL;
+
+	/* Reset the hypercall page */
+	rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
+	hypercall_msr.enable = 0;
+	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
+
+	return 0;
+}
+
+static void hv_resume(void)
+{
+	union hv_x64_msr_hypercall_contents hypercall_msr;
+
+	/* Re-enable the hypercall page */
+	rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
+	hypercall_msr.enable = 1;
+	hypercall_msr.guest_physical_address =
+		vmalloc_to_pfn(hv_hypercall_pg_saved);
+	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
+
+	hv_hypercall_pg = hv_hypercall_pg_saved;
+	hv_hypercall_pg_saved = NULL;
+}
+
+static struct syscore_ops hv_syscore_ops = {
+	.suspend = hv_suspend,
+	.resume = hv_resume,
+};
+
 /*
  * This function is to be invoked early in the boot sequence after the
  * hypervisor has been detected.
@@ -330,6 +374,8 @@ void __init hyperv_init(void)
 
 	x86_init.pci.arch_init = hv_pci_init;
 
+	register_syscore_ops(&hv_syscore_ops);
+
 	return;
 
 remove_cpuhp_state:
@@ -349,6 +395,8 @@ void hyperv_cleanup(void)
 {
 	union hv_x64_msr_hypercall_contents hypercall_msr;
 
+	unregister_syscore_ops(&hv_syscore_ops);
+
 	/* Reset our OS id */
 	wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
 
-- 
2.19.1
