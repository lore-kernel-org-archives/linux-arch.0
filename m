Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-eopbgr720114.outbound.protection.outlook.com ([40.107.72.114]:24931
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726073AbfIEWrP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 5 Sep 2019 18:47:15 -0400
From: Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v5 1/3] x86/hyper-v: Suspend/resume the hypercall page for
 hibernation
Date: Thu, 5 Sep 2019 22:47:12 +0000
Message-ID: <1567723581-29088-2-git-send-email-decui@microsoft.com>
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
Message-ID: <20190905224712.2uVrdtoQx2-paSqE-v1l10cSlI3fnUDF_XkkNBZX2yc@z>

This is needed for hibernation, e.g. when we resume the old kernel, we need
to disable the "current" kernel's hypercall page and then resume the old
kernel's.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/x86/hyperv/hv_init.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 866dfb3..037b0f3 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -20,6 +20,7 @@
 #include <linux/hyperv.h>
 #include <linux/slab.h>
 #include <linux/cpuhotplug.h>
+#include <linux/syscore_ops.h>
 #include <clocksource/hyperv_timer.h>
=20
 void *hv_hypercall_pg;
@@ -223,6 +224,34 @@ static int __init hv_pci_init(void)
 	return 1;
 }
=20
+static int hv_suspend(void)
+{
+	union hv_x64_msr_hypercall_contents hypercall_msr;
+
+	/* Reset the hypercall page */
+	rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
+	hypercall_msr.enable =3D 0;
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
+	hypercall_msr.enable =3D 1;
+	hypercall_msr.guest_physical_address =3D vmalloc_to_pfn(hv_hypercall_pg);
+	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
+}
+
+static struct syscore_ops hv_syscore_ops =3D {
+	.suspend =3D hv_suspend,
+	.resume =3D hv_resume,
+};
+
 /*
  * This function is to be invoked early in the boot sequence after the
  * hypervisor has been detected.
@@ -301,6 +330,8 @@ void __init hyperv_init(void)
=20
 	x86_init.pci.arch_init =3D hv_pci_init;
=20
+	register_syscore_ops(&hv_syscore_ops);
+
 	return;
=20
 remove_cpuhp_state:
@@ -320,6 +351,8 @@ void hyperv_cleanup(void)
 {
 	union hv_x64_msr_hypercall_contents hypercall_msr;
=20
+	unregister_syscore_ops(&hv_syscore_ops);
+
 	/* Reset our OS id */
 	wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
=20
--=20
1.8.3.1
