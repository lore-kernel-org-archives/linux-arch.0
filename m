Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp21.cstnet.cn ([159.226.251.21]:52042 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388097AbeGWO3e (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 23 Jul 2018 10:29:34 -0400
From: Pu Wen <puwen@hygon.cn>
Subject: [PATCH v2 05/17] x86/perfctr: return perf counter and event selection bit offset
Date: Mon, 23 Jul 2018 21:20:25 +0800
Message-ID: <1532352037-7151-6-git-send-email-puwen@hygon.cn>
In-Reply-To: <1532352037-7151-1-git-send-email-puwen@hygon.cn>
References: <1532352037-7151-1-git-send-email-puwen@hygon.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de, bp@alien8.de, thomas.lendacky@amd.com, mingo@redhat.com, hpa@zytor.com, peterz@infradead.org, tony.luck@intel.com, pbonzini@redhat.com, rkrcmar@redhat.com, boris.ostrovsky@oracle.com, jgross@suse.com, rjw@rjwysocki.net, lenb@kernel.org, viresh.kumar@linaro.org, mchehab@kernel.org, trenn@suse.com, shuah@kernel.org, JBeulich@suse.com, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org
Message-ID: <20180723132025.apduTrKw4cKA_wjWrwaTL4nGdXPA8A2hRHNY2Q8g968@z>

Hygon Dhyana shares similar perfctr arch with AMD family 17h.
It returns the bit offset of the performance counter register and the
event selection register for Hygon CPU in the similar way as AMD does.

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 arch/x86/kernel/cpu/perfctr-watchdog.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/cpu/perfctr-watchdog.c b/arch/x86/kernel/cpu/perfctr-watchdog.c
index d389083..df46708 100644
--- a/arch/x86/kernel/cpu/perfctr-watchdog.c
+++ b/arch/x86/kernel/cpu/perfctr-watchdog.c
@@ -50,6 +50,10 @@ static inline unsigned int nmi_perfctr_msr_to_bit(unsigned int msr)
 		if (msr >= MSR_F15H_PERF_CTR)
 			return (msr - MSR_F15H_PERF_CTR) >> 1;
 		return msr - MSR_K7_PERFCTR0;
+	case X86_VENDOR_HYGON:
+		if (msr >= MSR_F15H_PERF_CTR)
+			return (msr - MSR_F15H_PERF_CTR) >> 1;
+		return msr - MSR_K7_PERFCTR0;
 	case X86_VENDOR_INTEL:
 		if (cpu_has(&boot_cpu_data, X86_FEATURE_ARCH_PERFMON))
 			return msr - MSR_ARCH_PERFMON_PERFCTR0;
@@ -78,6 +82,10 @@ static inline unsigned int nmi_evntsel_msr_to_bit(unsigned int msr)
 		if (msr >= MSR_F15H_PERF_CTL)
 			return (msr - MSR_F15H_PERF_CTL) >> 1;
 		return msr - MSR_K7_EVNTSEL0;
+	case X86_VENDOR_HYGON:
+		if (msr >= MSR_F15H_PERF_CTL)
+			return (msr - MSR_F15H_PERF_CTL) >> 1;
+		return msr - MSR_K7_EVNTSEL0;
 	case X86_VENDOR_INTEL:
 		if (cpu_has(&boot_cpu_data, X86_FEATURE_ARCH_PERFMON))
 			return msr - MSR_ARCH_PERFMON_EVENTSEL0;
-- 
2.7.4
