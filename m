Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:33092 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394343AbfHWL6g (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 23 Aug 2019 07:58:36 -0400
From: Cristian Marussi <cristian.marussi@arm.com>
Subject: [RFC PATCH 7/7] arm64: smp: add arch specific cpu parking helper
Date: Fri, 23 Aug 2019 12:57:20 +0100
Message-ID: <20190823115720.605-8-cristian.marussi@arm.com>
In-Reply-To: <20190823115720.605-1-cristian.marussi@arm.com>
References: <20190823115720.605-1-cristian.marussi@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dave.martin@arm.com, james.morse@arm.com, mark.rutland@arm.com, catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de, peterz@infradead.org, takahiro.akashi@linaro.org, hidehiro.kawai.ez@hitachi.com
Message-ID: <20190823115720.LIZWQCP-BsNplXyLdC_LmPHA4bfCcZkEHkHCEZATGcw@z>

Add an arm64 specific helper which parks the cpu in a more architecture
efficient way.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 arch/arm64/kernel/smp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index c7497a885cfd..a3fb22b4c870 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -947,6 +947,12 @@ void tick_broadcast(const struct cpumask *mask)
 }
 #endif
 
+void arch_smp_cpu_park(void)
+{
+	while (1)
+		cpu_park_loop();
+}
+
 void arch_smp_cpus_stop_complete(void)
 {
 	sdei_mask_local_cpu();
-- 
2.17.1
