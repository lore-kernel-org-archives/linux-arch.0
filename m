Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wy0-f180.google.com ([74.125.82.180]:49741 "EHLO
	mail-wy0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752837Ab1IUJ3x (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 21 Sep 2011 05:29:53 -0400
From: Yong Zhang <yong.zhang0@gmail.com>
Subject: [PATCH 04/57] avr32: irq: Remove IRQF_DISABLED
Date: Wed, 21 Sep 2011 17:28:05 +0800
Message-ID: <1316597339-29861-5-git-send-email-yong.zhang0@gmail.com>
In-Reply-To: <1316597339-29861-1-git-send-email-yong.zhang0@gmail.com>
References: <1316597339-29861-1-git-send-email-yong.zhang0@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, yong.zhang0@gmail.com, Haavard Skinnemoen <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, John Stultz <johnstul@us.ibm.com>
Message-ID: <20110921092805.uYii75Ts5nKyqoZ5JfupN54mPjb9BJ1plMgvmmV1NDg@z>

Since commit [c58543c8: genirq: Run irq handlers with interrupts disabled],
We run all interrupt handlers with interrupts disabled
and we even check and yell when an interrupt handler
returns with interrupts enabled (see commit [b738a50a:
genirq: Warn when handler enables interrupts]).

So now this flag is a NOOP and can be removed.

Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>
---
 arch/avr32/kernel/time.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/avr32/kernel/time.c b/arch/avr32/kernel/time.c
index 05ad291..cfc9778 100644
--- a/arch/avr32/kernel/time.c
+++ b/arch/avr32/kernel/time.c
@@ -58,7 +58,7 @@ static irqreturn_t timer_interrupt(int irq, void *dev_id)
 static struct irqaction timer_irqaction = {
 	.handler	= timer_interrupt,
 	/* Oprofile uses the same irq as the timer, so allow it to be shared */
-	.flags		= IRQF_TIMER | IRQF_DISABLED | IRQF_SHARED,
+	.flags		= IRQF_TIMER | IRQF_SHARED,
 	.name		= "avr32_comparator",
 };
 
-- 
1.7.4.1

