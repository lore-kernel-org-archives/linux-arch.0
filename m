Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:51861 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753748AbbFILwQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2015 07:52:16 -0400
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 05/28] ARCv2: STAR 9000814690: Really Re-enable interrupts to avoid deadlocks
Date: Tue, 9 Jun 2015 17:18:05 +0530
Message-ID: <1433850508-26317-6-git-send-email-vgupta@synopsys.com>
In-Reply-To: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
References: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, arc-linux-dev@synopsys.com, Vineet Gupta <Vineet.Gupta1@synopsys.com>
Message-ID: <20150609114805._FshaVAHlgYYip_gIIjrmind473oYFcXQpombP8UXMs@z>

The issue was, on HS when interrupt is taken, IRQ_ACT is set and that is
NOT cleared unless we do RTIE (or manually clear it). Linux interrupt
handling has top and bottom halves. Latter lead to softirqs (which can
reschedule) AND expect interrupts to be REALLY re-enabled which was NOT
happening for us since we only SETI, dont clear IRQ_ACT

So we can have a state when both cores have taken interrupt (IRQ_ACT set),
get rescheduled, both send IPI and wait in CSD lock which will never be
cleared as cores can't take the pending IPI IRQ due to existing IRQ_ACT
set.

So local_irq_enable() now drops the IRQ_ACT.act bit to re-enable IRQs.

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/include/asm/irqflags-arcv2.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arc/include/asm/irqflags-arcv2.h b/arch/arc/include/asm/irqflags-arcv2.h
index 1eb41b00aac5..ad481c24070d 100644
--- a/arch/arc/include/asm/irqflags-arcv2.h
+++ b/arch/arc/include/asm/irqflags-arcv2.h
@@ -64,6 +64,11 @@ static inline void arch_local_irq_restore(unsigned long flags)
  */
 static inline void arch_local_irq_enable(void)
 {
+	unsigned int irqact = read_aux_reg(AUX_IRQ_ACT);
+
+	if (irqact & 0xffff)
+		write_aux_reg(AUX_IRQ_ACT, irqact & ~0xffff);
+
 	__asm__ __volatile__("	seti	\n" : : : "memory");
 }
 
-- 
1.9.1

