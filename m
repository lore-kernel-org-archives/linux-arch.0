From: guoren@kernel.org
Subject: [PATCH 04/13] csky: Fixup duplicated restore sp in RESTORE_REGS_FTRACE
Date: Sat,  1 Aug 2020 01:14:04 +0000
Message-ID: <1596244453-98575-5-git-send-email-guoren@kernel.org>
References: <1596244453-98575-1-git-send-email-guoren@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1596244453-98575-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: guoren@kernel.org, arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, linux-arch@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
List-Id: linux-arch.vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

There is no user return for RESTORE_REGS_FTRACE, so it's no need to
save sp into ss0 as RESTORE_REGS_ALL.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/abiv2/inc/abi/entry.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/csky/abiv2/inc/abi/entry.h b/arch/csky/abiv2/inc/abi/entry.h
index 4fdd6c1..bedcc6f 100644
--- a/arch/csky/abiv2/inc/abi/entry.h
+++ b/arch/csky/abiv2/inc/abi/entry.h
@@ -136,8 +136,6 @@
 
 .macro	RESTORE_REGS_FTRACE
 	ldw	tls, (sp, 0)
-	ldw	a0, (sp, 16)
-	mtcr	a0, ss0
 
 #ifdef CONFIG_CPU_HAS_HILO
 	ldw	a0, (sp, 140)
@@ -158,7 +156,6 @@
 	addi    sp, 40
 	ldm     r16-r30, (sp)
 	addi    sp, 72
-	mfcr	sp, ss0
 .endm
 
 .macro SAVE_SWITCH_STACK
-- 
2.7.4
