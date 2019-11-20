Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-eopbgr730138.outbound.protection.outlook.com ([40.107.73.138]:20640
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725854AbfKTHQk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 20 Nov 2019 02:16:40 -0500
From: Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v2 1/2] x86/hyperv: Implement hv_is_hibernation_supported()
Date: Tue, 19 Nov 2019 23:16:04 -0800
Message-ID: <1574234165-49066-2-git-send-email-decui@microsoft.com>
In-Reply-To: <1574234165-49066-1-git-send-email-decui@microsoft.com>
References: <1574234165-49066-1-git-send-email-decui@microsoft.com>
Reply-To: decui@microsoft.com
Content-Type: text/plain
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com, sashal@kernel.org, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, mikelley@microsoft.com, david@redhat.com, arnd@arndb.de, bp@alien8.de, daniel.lezcano@linaro.org, hpa@zytor.com, mingo@redhat.com, tglx@linutronix.de, x86@kernel.org, Alexander.Levin@microsoft.com, vkuznets@redhat.com
Cc: linux-arch@vger.kernel.org, Dexuan Cui <decui@microsoft.com>
Message-ID: <20191120071604.yedsoMyXZI7O9AG1-dZo5uIui1oxPxEhhsPABvyBrqQ@z>

The API will be used by the hv_balloon and hv_vmbus drivers.

Balloon up/down and hot-add of memory must not be active if the user
wants the Linux VM to support hibernation, because they are incompatible
with hibernation according to Hyper-V team, e.g. upon suspend the
balloon VSP doesn't save any info about the ballooned-out pages (if any);
so, after Linux resumes, Linux balloon VSC expects that the VSP will
return the pages if Linux is under memory pressure, but the VSP will
never do that, since the VSP thinks it never stole the pages from the VM.

So, if the user wants Linux VM to support hibernation, Linux must forbid
balloon up/down and hot-add, and the only functionality of the balloon VSC
driver is reporting the VM's memory pressure to the host.

Ideally, when Linux detects that the user wants it to support hibernation,
the balloon VSC should tell the VSP that it does not support ballooning
and hot-add. However, the current version of the VSP requires the VSC
should support these capabilities, otherwise the capability negotiation
fails and the VSC can not load at all, so with the later changes to the
VSC driver, Linux VM still reports to the VSP that the VSC supports these
capabilities, but the VSC ignores the VSP's requests of balloon up/down
and hot add, and reports an error to the VSP, when applicable. BTW, in
the future the balloon VSP driver will allow the VSC to not support the
capabilities of balloon up/down and hot add.

The ACPI S4 state is not a must for hibernation to work, because Linux is
able to hibernate as long as the system can shut down. However in practice
we decide to artificially use the presence of the virtual ACPI S4 state as
an indicator of the user's intent of using hibernation, because Linux VM
must find a way to know if the user wants to use the hibernation feature
or not.

By default, Hyper-V does not enable the virtual ACPI S4 state; on recent
Hyper-V hosts (e.g. RS5, 19H1), the administrator is able to enable the
state for a VM by WMI commands.

Once all the vmbus and VSC patches for the hibernation feature are
accepted, an extra patch will be submitted to forbid hibernation if the
virtual ACPI S4 state is absent, i.e. hv_is_hibernation_supported() is
false.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---

v2 is actually the same as v1. This is just a resend.

I suggest this patch should go through the Hyper-V tree:
https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/log/?h=hyperv-next
because it's needed by
[PATCH v2 2/2] hv_balloon: Add the support of hibernation
and some upcoming patches.

This patch doesn't conflict with any patch in the tip.git tree.

 arch/x86/hyperv/hv_init.c      | 7 +++++++
 include/asm-generic/mshyperv.h | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index c170653da589..24a62d33067c 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -7,6 +7,7 @@
  * Author : K. Y. Srinivasan <kys@microsoft.com>
  */
 
+#include <linux/acpi.h>
 #include <linux/efi.h>
 #include <linux/types.h>
 #include <asm/apic.h>
@@ -493,3 +494,9 @@ bool hv_is_hyperv_initialized(void)
 	return hypercall_msr.enable;
 }
 EXPORT_SYMBOL_GPL(hv_is_hyperv_initialized);
+
+bool hv_is_hibernation_supported(void)
+{
+	return acpi_sleep_state_supported(ACPI_STATE_S4);
+}
+EXPORT_SYMBOL_GPL(hv_is_hibernation_supported);
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 18d8e2d8210f..b3f1082cc435 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -166,10 +166,12 @@ static inline int cpumask_to_vpset(struct hv_vpset *vpset,
 void hyperv_report_panic(struct pt_regs *regs, long err);
 void hyperv_report_panic_msg(phys_addr_t pa, size_t size);
 bool hv_is_hyperv_initialized(void);
+bool hv_is_hibernation_supported(void);
 void hyperv_cleanup(void);
 void hv_setup_sched_clock(void *sched_clock);
 #else /* CONFIG_HYPERV */
 static inline bool hv_is_hyperv_initialized(void) { return false; }
+static inline bool hv_is_hibernation_supported(void) { return false; }
 static inline void hyperv_cleanup(void) {}
 #endif /* CONFIG_HYPERV */
 
-- 
2.19.1
