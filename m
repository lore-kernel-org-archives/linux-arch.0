Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp20.cstnet.cn ([159.226.251.20]:54316 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726589AbeHSTZ7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 19 Aug 2018 15:25:59 -0400
From: Pu Wen <puwen@hygon.cn>
Subject: [PATCH v4 11/16] x86/kvm: enable Hygon support to KVM infrastructure
Date: Mon, 20 Aug 2018 00:13:25 +0800
Message-ID: <f7b4fd2b963bf0f4ebadb1091fcf0c4f2015012c.1534599097.git.puwen@hygon.cn>
In-Reply-To: <cover.1534599097.git.puwen@hygon.cn>
References: <cover.1534599097.git.puwen@hygon.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, bp@alien8.de, pbonzini@redhat.com, rkrcmar@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kvm@vger.kernel.org, Pu Wen <puwen@hygon.cn>
Message-ID: <20180819161325.R1IGHCz2sJjdj4wgzLKcxEyXtZTHb47AfO8kK9do35w@z>

Hygon Dhyana CPU has the SVM feature as AMD family 17h does.
Add Hygon support in the KVM infrastructure.

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 arch/x86/include/asm/kvm_emulate.h |  4 ++++
 arch/x86/include/asm/virtext.h     |  5 +++--
 arch/x86/kvm/emulate.c             | 11 ++++++++++-
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/kvm_emulate.h b/arch/x86/include/asm/kvm_emulate.h
index 0f82cd9..93c4bf5 100644
--- a/arch/x86/include/asm/kvm_emulate.h
+++ b/arch/x86/include/asm/kvm_emulate.h
@@ -364,6 +364,10 @@ struct x86_emulate_ctxt {
 #define X86EMUL_CPUID_VENDOR_AMDisbetterI_ecx 0x21726574
 #define X86EMUL_CPUID_VENDOR_AMDisbetterI_edx 0x74656273
 
+#define X86EMUL_CPUID_VENDOR_HygonGenuine_ebx 0x6f677948
+#define X86EMUL_CPUID_VENDOR_HygonGenuine_ecx 0x656e6975
+#define X86EMUL_CPUID_VENDOR_HygonGenuine_edx 0x6e65476e
+
 #define X86EMUL_CPUID_VENDOR_GenuineIntel_ebx 0x756e6547
 #define X86EMUL_CPUID_VENDOR_GenuineIntel_ecx 0x6c65746e
 #define X86EMUL_CPUID_VENDOR_GenuineIntel_edx 0x49656e69
diff --git a/arch/x86/include/asm/virtext.h b/arch/x86/include/asm/virtext.h
index 0116b2e..e05e0d3 100644
--- a/arch/x86/include/asm/virtext.h
+++ b/arch/x86/include/asm/virtext.h
@@ -83,9 +83,10 @@ static inline void cpu_emergency_vmxoff(void)
  */
 static inline int cpu_has_svm(const char **msg)
 {
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD) {
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
+	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON) {
 		if (msg)
-			*msg = "not amd";
+			*msg = "not amd or hygon";
 		return 0;
 	}
 
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 4c4f426..1ab7758 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -2711,7 +2711,16 @@ static bool em_syscall_is_enabled(struct x86_emulate_ctxt *ctxt)
 	    edx == X86EMUL_CPUID_VENDOR_AMDisbetterI_edx)
 		return true;
 
-	/* default: (not Intel, not AMD), apply Intel's stricter rules... */
+	/* Hygon ("HygonGenuine") */
+	if (ebx == X86EMUL_CPUID_VENDOR_HygonGenuine_ebx &&
+	    ecx == X86EMUL_CPUID_VENDOR_HygonGenuine_ecx &&
+	    edx == X86EMUL_CPUID_VENDOR_HygonGenuine_edx)
+		return true;
+
+	/*
+	 * default: (not Intel, not AMD, not Hygon), apply Intel's
+	 * stricter rules...
+	 */
 	return false;
 }
 
-- 
2.7.4
