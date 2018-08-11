Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp17.cstnet.cn ([159.226.251.17]:38084 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727304AbeHKQBi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 11 Aug 2018 12:01:38 -0400
From: Pu Wen <puwen@hygon.cn>
Subject: [PATCH v3 05/17] x86/perfctr: return perf counter and event selection bit offset
Date: Sat, 11 Aug 2018 21:27:07 +0800
Message-ID: <3c687a337c87923884eb4ba11cf55cbe0203b878.1533989492.git.puwen@hygon.cn>
In-Reply-To: <cover.1533989492.git.puwen@hygon.cn>
References: <cover.1533989492.git.puwen@hygon.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, bp@alien8.de, pbonzini@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Pu Wen <puwen@hygon.cn>
Message-ID: <20180811132707.mZoYXERnVOFBcI2HLHGjLJyIlNOXnTrMzdOsxjt7LfQ@z>

Hygon Dhyana shares similar perfctr arch with AMD family 17h.
It returns the bit offset of the performance counter register and the
event selection register for Hygon CPU in the similar way as AMD does.

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 arch/x86/kernel/cpu/perfctr-watchdog.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/perfctr-watchdog.c b/arch/x86/kernel/cpu/perfctr-watchdog.c
index d389083..9556930 100644
--- a/arch/x86/kernel/cpu/perfctr-watchdog.c
+++ b/arch/x86/kernel/cpu/perfctr-watchdog.c
@@ -46,6 +46,7 @@ static inline unsigned int nmi_perfctr_msr_to_bit(unsigned int msr)
 {
 	/* returns the bit offset of the performance counter register */
 	switch (boot_cpu_data.x86_vendor) {
+	case X86_VENDOR_HYGON:
 	case X86_VENDOR_AMD:
 		if (msr >= MSR_F15H_PERF_CTR)
 			return (msr - MSR_F15H_PERF_CTR) >> 1;
@@ -74,6 +75,7 @@ static inline unsigned int nmi_evntsel_msr_to_bit(unsigned int msr)
 {
 	/* returns the bit offset of the event selection register */
 	switch (boot_cpu_data.x86_vendor) {
+	case X86_VENDOR_HYGON:
 	case X86_VENDOR_AMD:
 		if (msr >= MSR_F15H_PERF_CTL)
 			return (msr - MSR_F15H_PERF_CTL) >> 1;
-- 
2.7.4
