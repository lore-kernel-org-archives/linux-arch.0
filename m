Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726557AbfG3MPy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 30 Jul 2019 08:15:54 -0400
From: guoren@kernel.org
Subject: [PATCH 1/4] csky: Fixup dma_rmb/wmb synchronization problem
Date: Tue, 30 Jul 2019 20:15:42 +0800
Message-ID: <1564488945-20149-1-git-send-email-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-csky@vger.kernel.org, feng_shizhu@dahuatech.com, zhang_jian5@dahuatech.com, zheng_xingjian@dahuatech.com, zhu_peng@dahuatech.com, Guo Ren <ren_guo@c-sky.com>
Message-ID: <20190730121542.Iaen7cuGJkSnUcMdb9SxoUvIR_DEltAKjdJ1gXR2awI@z>

From: Guo Ren <ren_guo@c-sky.com>

If arch didn't define dma_r/wmb(), linux will use w/rmb instead. Csky
use bar.xxx to implement mb() and that will cause problem when sync data
with dma device, becasue bar.xxx couldn't guarantee bus transactions
finished at outside bus level. We must use sync.s instead of bar.xxx for
dma data synchronization and it will guarantee retirement after getting
the bus bresponse.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/include/asm/barrier.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/csky/include/asm/barrier.h b/arch/csky/include/asm/barrier.h
index 476eb78..061a633 100644
--- a/arch/csky/include/asm/barrier.h
+++ b/arch/csky/include/asm/barrier.h
@@ -9,7 +9,9 @@
 #define nop()	asm volatile ("nop\n":::"memory")
 
 /*
- * sync:        completion barrier
+ * sync:        completion barrier, all sync.xx instructions
+ *              guarantee the last response recieved by bus transaction
+ *              made by ld/st instructions before sync.s
  * sync.s:      completion barrier and shareable to other cores
  * sync.i:      completion barrier with flush cpu pipeline
  * sync.is:     completion barrier with flush cpu pipeline and shareable to
@@ -31,6 +33,9 @@
 #define rmb()		asm volatile ("bar.brar\n":::"memory")
 #define wmb()		asm volatile ("bar.bwaw\n":::"memory")
 
+#define dma_rmb()	asm volatile ("sync.s\n":::"memory")
+#define dma_wmb()	asm volatile ("sync.s\n":::"memory")
+
 #ifdef CONFIG_SMP
 #define __smp_mb()	asm volatile ("bar.brwarws\n":::"memory")
 #define __smp_rmb()	asm volatile ("bar.brars\n":::"memory")
-- 
2.7.4
