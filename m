From: Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v6] x86/hyperv: Suspend/resume the hypercall page for hibernation
Date: Tue, 19 Nov 2019 23:09:02 -0800
Message-ID: <1574233742-47794-1-git-send-email-decui@microsoft.com>
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

This patch is part of the v5 patchset:
  https://lkml.org/lkml/2019/9/5/1158
  https://lkml.org/lkml/2019/9/5/1159 

  The change is: I set 'hv_hypercall_pg' to NULL in hv_suspend(), and
restore it in hv_resume(). This is suggested by Vitaly Kuznetsov.

  There is no other change, compared to v1 (v2~v5 were posted with the other
patches).

  Please pick up this patch onto the tip.git tree's branch x86/hyperv.

 arch/x86/hyperv/hv_init.c | 48 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 426dc8b78193..c170653da589 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -20,11 +20,15 @@
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
 
@@ -245,6 +249,46 @@ static int __init hv_pci_init(void)
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
@@ -329,6 +373,8 @@ void __init hyperv_init(void)
 
 	x86_init.pci.arch_init = hv_pci_init;
 
+	register_syscore_ops(&hv_syscore_ops);
+
 	return;
 
 remove_cpuhp_state:
@@ -348,6 +394,8 @@ void hyperv_cleanup(void)
 {
 	union hv_x64_msr_hypercall_contents hypercall_msr;
 
+	unregister_syscore_ops(&hv_syscore_ops);
+
 	/* Reset our OS id */
 	wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
 
-- 
2.19.1
