Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-eopbgr720114.outbound.protection.outlook.com ([40.107.72.114]:24931
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730937AbfIEWrS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 5 Sep 2019 18:47:18 -0400
From: Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v5 2/3] x86/hyper-v: Implement hv_is_hibernation_supported()
Date: Thu, 5 Sep 2019 22:47:14 +0000
Message-ID: <1567723581-29088-3-git-send-email-decui@microsoft.com>
References: <1567723581-29088-1-git-send-email-decui@microsoft.com>
In-Reply-To: <1567723581-29088-1-git-send-email-decui@microsoft.com>
Reply-To: Dexuan Cui <decui@microsoft.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, Haiyang Zhang <haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>, KY Srinivasan <kys@microsoft.com>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "sashal@kernel.org" <sashal@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>, Michael Kelley <mikelley@microsoft.com>, Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Dexuan Cui <decui@microsoft.com>
Message-ID: <20190905224714.2aB-RIWvneOMxwG6nokKpgTeBzimkwfVEKcxCfki82Y@z>

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
 arch/x86/hyperv/hv_init.c      | 7 +++++++
 include/asm-generic/mshyperv.h | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 037b0f3..9a26071 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -7,6 +7,7 @@
  * Author : K. Y. Srinivasan <kys@microsoft.com>
  */
=20
+#include <linux/acpi.h>
 #include <linux/efi.h>
 #include <linux/types.h>
 #include <asm/apic.h>
@@ -450,3 +451,9 @@ bool hv_is_hyperv_initialized(void)
 	return hypercall_msr.enable;
 }
 EXPORT_SYMBOL_GPL(hv_is_hyperv_initialized);
+
+bool hv_is_hibernation_supported(void)
+{
+	return acpi_sleep_state_supported(ACPI_STATE_S4);
+}
+EXPORT_SYMBOL_GPL(hv_is_hibernation_supported);
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.=
h
index 18d8e2d..b3f1082 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -166,10 +166,12 @@ static inline int cpumask_to_vpset(struct hv_vpset *v=
pset,
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
=20
--=20
1.8.3.1
