Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:47811 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbeJKWhA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 Oct 2018 18:37:00 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] percpu: include irqflags.h for raw_local_irq_save()
Date: Thu, 11 Oct 2018 17:09:20 +0200
Message-Id: <20181011150920.9034-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, tglx@linutronix.de, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The header percpu.h header file is using raw_local_irq_save() but does
not include irqflags.h for its definition. It compiles because the
header file is included via an other header file.
On -RT the build fails because raw_local_irq_save() is not defined.

Include irqflags.h in percpu.h.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/asm-generic/percpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/asm-generic/percpu.h b/include/asm-generic/percpu.h
index 1817a8415a5e8..942d64c0476e7 100644
--- a/include/asm-generic/percpu.h
+++ b/include/asm-generic/percpu.h
@@ -5,6 +5,7 @@
 #include <linux/compiler.h>
 #include <linux/threads.h>
 #include <linux/percpu-defs.h>
+#include <linux/irqflags.h>
 
 #ifdef CONFIG_SMP
 
-- 
2.19.1
