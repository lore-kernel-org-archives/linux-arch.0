Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbfEJGKz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 10 May 2019 02:10:55 -0400
From: guoren@kernel.org
Subject: [PATCH] csky: Select intc & timer drivers
Date: Fri, 10 May 2019 14:10:39 +0800
Message-ID: <1557468639-21021-1-git-send-email-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arnd.de, guoren@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, ren_guo@c-sky.com
Message-ID: <20190510061039.LhSi9YdPof5FOwD3W90XVC6-5P-ivfPQTvZ7pYBqxAw@z>

From: Guo Ren <ren_guo@c-sky.com>

Let arch help to select interrupt controller's and timer's drivers
instead of people using menuconfig to select. This help the mini system
boot up.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Arnd Bergmann <arnd@arnd.de>
---
 arch/csky/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index ce07990..5e2cfc2 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -9,6 +9,9 @@ config CSKY
 	select COMMON_CLK
 	select CLKSRC_MMIO
 	select CLKSRC_OF
+	select CSKY_MPINTC if CPU_CK860
+	select CSKY_MP_TIMER if CPU_CK860
+	select CSKY_APB_INTC
 	select DMA_DIRECT_REMAP
 	select IRQ_DOMAIN
 	select HANDLE_DOMAIN_IRQ
@@ -29,6 +32,7 @@ config CSKY
 	select GENERIC_IRQ_MULTI_HANDLER
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
+	select GX6605S_TIMER if CPU_CK610
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_DYNAMIC_FTRACE
-- 
2.7.4
