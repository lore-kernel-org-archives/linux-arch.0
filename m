Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:43655 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757018Ab0I3XT2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 30 Sep 2010 19:19:28 -0400
Message-ID: <20100930221742.514911056@linutronix.de>
Date: Thu, 30 Sep 2010 23:18:03 -0000
From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 41/47] arm: davinci: Cleanup irq_desc access
References: <20100930221351.682772535@linutronix.de>
Content-Disposition: inline; filename=arm-davinci-cleanup-irq-desc-access.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-arch@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mundt <lethal@linux-sh.org>, Russell King <linux@arm.linux.org.uk>, David Woodhouse <dwmw2@infradead.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Yinghai Lu <yinghai@kernel.org>, Grant Likely <grant.likely@secretlab.ca>, "Eric W. Biederman" <ebiederm@xmission.com>
Message-ID: <20100930231803.VJ4sKtN5lFEwdTORHMb-NCqzDnSgIQmtJ1YLwsRuy78@z>

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/arm/mach-davinci/gpio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6-tip/arch/arm/mach-davinci/gpio.c
===================================================================
--- linux-2.6-tip.orig/arch/arm/mach-davinci/gpio.c
+++ linux-2.6-tip/arch/arm/mach-davinci/gpio.c
@@ -395,7 +395,7 @@ static int __init davinci_gpio_irq_setup
 
 		/* AINTC handles mask/unmask; GPIO handles triggering */
 		irq = bank_irq;
-		gpio_irqchip_unbanked = *get_irq_desc_chip(irq_to_desc(irq));
+		gpio_irqchip_unbanked = *irq_get_irq_data(irq)->chip;
 		gpio_irqchip_unbanked.name = "GPIO-AINTC";
 		gpio_irqchip_unbanked.set_type = gpio_irq_type_unbanked;
 


