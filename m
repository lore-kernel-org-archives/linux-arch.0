Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:56712 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753263Ab1IUJcZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 21 Sep 2011 05:32:25 -0400
From: Yong Zhang <yong.zhang0@gmail.com>
Subject: [PATCH 22/57] xtensa: irq: Remove IRQF_DISABLED
Date: Wed, 21 Sep 2011 17:28:23 +0800
Message-ID: <1316597339-29861-23-git-send-email-yong.zhang0@gmail.com>
In-Reply-To: <1316597339-29861-1-git-send-email-yong.zhang0@gmail.com>
References: <1316597339-29861-1-git-send-email-yong.zhang0@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, yong.zhang0@gmail.com, Chris Zankel <chris@zankel.net>, Torben Hohn <torbenh@gmx.de>
Message-ID: <20110921092823.T4OmG_Ry9TBegJYRjP97g10Dpukap-A9Fr-VjsT4GyE@z>

Since commit [c58543c8: genirq: Run irq handlers with interrupts disabled],
We run all interrupt handlers with interrupts disabled
and we even check and yell when an interrupt handler
returns with interrupts enabled (see commit [b738a50a:
genirq: Warn when handler enables interrupts]).

So now this flag is a NOOP and can be removed.

Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
---
 arch/xtensa/kernel/time.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/xtensa/kernel/time.c b/arch/xtensa/kernel/time.c
index f3e5eb4..2370229 100644
--- a/arch/xtensa/kernel/time.c
+++ b/arch/xtensa/kernel/time.c
@@ -54,7 +54,6 @@ static struct clocksource ccount_clocksource = {
 static irqreturn_t timer_interrupt(int irq, void *dev_id);
 static struct irqaction timer_irqaction = {
 	.handler =	timer_interrupt,
-	.flags =	IRQF_DISABLED,
 	.name =		"timer",
 };
 
-- 
1.7.4.1

