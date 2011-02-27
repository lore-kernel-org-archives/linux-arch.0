From: Guan Xuetao <epip@hera.kernel.org>
Subject: [PATCH 07/17] unicore32: remove unused lines in arch/unicore32/include/asm/irq.h
Date: Sun, 27 Feb 2011 15:59:35 +0000
Message-ID: <2205620026b05c58580b437968981b3e20935aa3.1298821856.git.epip@hera.kernel.org>
References: <cover.1298821856.git.epip@hera.kernel.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58546 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752543Ab1B0QBo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 27 Feb 2011 11:01:44 -0500
In-Reply-To: <cover.1298821856.git.epip@hera.kernel.org>
In-Reply-To: <cover.1298821856.git.epip@hera.kernel.org>
References: <cover.1298821856.git.epip@hera.kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de
Cc: GuanXuetao <gxt@mprc.pku.edu.cn>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, greg@kroah.com

From: GuanXuetao <gxt@mprc.pku.edu.cn>

Signed-off-by: Guan Xuetao <gxt@mprc.pku.edu.cn>
---
 arch/unicore32/include/asm/irq.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/unicore32/include/asm/irq.h b/arch/unicore32/include/asm/irq.h
index ade8bb8..baea93e 100644
--- a/arch/unicore32/include/asm/irq.h
+++ b/arch/unicore32/include/asm/irq.h
@@ -95,9 +95,7 @@
 #define IRQ_SD_CD               IRQ_GPIO6 /* falling or rising trigger */
 
 #ifndef __ASSEMBLY__
-struct irqaction;
 struct pt_regs;
-extern void migrate_irqs(void);
 
 extern void asm_do_IRQ(unsigned int, struct pt_regs *);
 
-- 
1.7.4.1
