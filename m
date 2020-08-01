Return-Path: <SRS0=4doj=BL=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728219AbgHABOr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 31 Jul 2020 21:14:47 -0400
From: guoren@kernel.org
Subject: [PATCH 05/13] csky: Fixup kprobes handler couldn't change pc
Date: Sat,  1 Aug 2020 01:14:05 +0000
Message-ID: <1596244453-98575-6-git-send-email-guoren@kernel.org>
In-Reply-To: <1596244453-98575-1-git-send-email-guoren@kernel.org>
References: <1596244453-98575-1-git-send-email-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: guoren@kernel.org, arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, linux-arch@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Message-ID: <20200801011405.IacUyAFDc-UcVzqKcrptTfB9HKtVCueB27zztpU86YI@z>

From: Guo Ren <guoren@linux.alibaba.com>

The "Changing Execution Path" section in the Documentation/kprobes.txt
said:

Since kprobes can probe into a running kernel code, it can change the
register set, including instruction pointer.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/abiv2/mcount.S | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/csky/abiv2/mcount.S b/arch/csky/abiv2/mcount.S
index 911512b..d745e10 100644
--- a/arch/csky/abiv2/mcount.S
+++ b/arch/csky/abiv2/mcount.S
@@ -55,7 +55,9 @@
 
 .macro mcount_exit_regs
 	RESTORE_REGS_FTRACE
-	ldw	t1, (sp, 0)
+	subi	sp, 152
+	ldw	t1, (sp, 4)
+	addi	sp, 152
 	ldw	r8, (sp, 4)
 	ldw	lr, (sp, 8)
 	addi	sp, 12
-- 
2.7.4
