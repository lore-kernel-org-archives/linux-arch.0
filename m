Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp21.cstnet.cn ([159.226.251.21]:45711 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388100AbeGWOli (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 23 Jul 2018 10:41:38 -0400
From: Pu Wen <puwen@hygon.cn>
Subject: [PATCH v2 12/17] x86/kvm: enable Hygon support to KVM infrastructure
Date: Mon, 23 Jul 2018 21:20:32 +0800
Message-ID: <1532352037-7151-13-git-send-email-puwen@hygon.cn>
In-Reply-To: <1532352037-7151-1-git-send-email-puwen@hygon.cn>
References: <1532352037-7151-1-git-send-email-puwen@hygon.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de, bp@alien8.de, thomas.lendacky@amd.com, mingo@redhat.com, hpa@zytor.com, peterz@infradead.org, tony.luck@intel.com, pbonzini@redhat.com, rkrcmar@redhat.com, boris.ostrovsky@oracle.com, jgross@suse.com, rjw@rjwysocki.net, lenb@kernel.org, viresh.kumar@linaro.org, mchehab@kernel.org, trenn@suse.com, shuah@kernel.org, JBeulich@suse.com, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org
Message-ID: <20180723132032.rYtCP_lcQ3enUjVjAB6p0wWWBMgtJ7j43-Bp7YAr_kU@z>

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
