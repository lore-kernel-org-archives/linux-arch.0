From: guoren@kernel.org
Subject: [PATCH 3/4] csky: Fixup remove duplicate irq_disable
Date: Wed, 13 May 2020 18:16:16 +0800
Message-ID: <20200513101617.11588-3-guoren@kernel.org>
References: <20200513101617.11588-1-guoren@kernel.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733003AbgEMKQ2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 13 May 2020 06:16:28 -0400
In-Reply-To: <20200513101617.11588-1-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-csky@vger.kernel.org
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, guoren@kernel.org, Liu Yibin <jiulong@linux.alibaba.com>, Guo Ren <guoren@linux.alibaba.com>

From: Liu Yibin <jiulong@linux.alibaba.com>

Interrupt has been disabled in __schedule() with local_irq_disable()
and enabled in finish_task_switch->finish_lock_switch() with
local_irq_enabled(), So needn't to disable irq here.

Signed-off-by: Liu Yibin <jiulong@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/csky/kernel/entry.S | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
index 364819536f2e..6a468ff75432 100644
--- a/arch/csky/kernel/entry.S
+++ b/arch/csky/kernel/entry.S
@@ -332,8 +332,6 @@ ENTRY(__switch_to)
 
 	mfcr	a2, psr			/* Save PSR value */
 	stw	a2, (a3, THREAD_SR)	/* Save PSR in task struct */
-	bclri	a2, 6			/* Disable interrupts */
-	mtcr	a2, psr
 
 	SAVE_SWITCH_STACK
 
-- 
2.17.0
