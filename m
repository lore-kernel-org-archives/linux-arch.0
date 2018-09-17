From: Pu Wen <puwen@hygon.cn>
Subject: [PATCH v7 08/16] x86/apic: Add Hygon Dhyana support to APIC
Date: Mon, 17 Sep 2018 21:31:15 +0800
Message-ID: <d429e252efc4e306ac4e9def3779013e034a0cde.1537182523.git.puwen@hygon.cn>
References: <cover.1537182523.git.puwen@hygon.cn>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1537182523.git.puwen@hygon.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Pu Wen <puwen@hygon.cn>
List-Id: linux-arch.vger.kernel.org

Add Hygon Dhyana support to the APIC subsystem as it uses modern APIC.
When running on 32 bit mode, bigsmp should be enabled if there are
more than 8 cores online.

Signed-off-by: Pu Wen <puwen@hygon.cn>
Reviewed-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/apic/apic.c     | 7 +++++++
 arch/x86/kernel/apic/probe_32.c | 1 +
 2 files changed, 8 insertions(+)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 84132ed..ab731ab 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -224,6 +224,11 @@ static int modern_apic(void)
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
 	    boot_cpu_data.x86 >= 0xf)
 		return 1;
+
+	/* Hygon systems use modern APIC */
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
+		return 1;
+
 	return lapic_get_version() >= 0x14;
 }
 
@@ -1912,6 +1917,8 @@ static int __init detect_init_APIC(void)
 		    (boot_cpu_data.x86 >= 15))
 			break;
 		goto no_apic;
+	case X86_VENDOR_HYGON:
+		break;
 	case X86_VENDOR_INTEL:
 		if (boot_cpu_data.x86 == 6 || boot_cpu_data.x86 == 15 ||
 		    (boot_cpu_data.x86 == 5 && boot_cpu_has(X86_FEATURE_APIC)))
diff --git a/arch/x86/kernel/apic/probe_32.c b/arch/x86/kernel/apic/probe_32.c
index 02e8acb..47ff297 100644
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -185,6 +185,7 @@ void __init default_setup_apic_routing(void)
 				break;
 			}
 			/* If P4 and above fall through */
+		case X86_VENDOR_HYGON:
 		case X86_VENDOR_AMD:
 			def_to_bigsmp = 1;
 		}
-- 
2.7.4
