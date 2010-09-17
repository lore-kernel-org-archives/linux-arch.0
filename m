From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH] ARM: prevent multiple syscall restarts
Date: Fri, 17 Sep 2010 16:21:58 +0100
Message-ID: <20100917152158.GA20369@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:33681 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753955Ab0IQPWH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 17 Sep 2010 11:22:07 -0400
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>

Al Viro reports that calling "sys_sigsuspend(-ERESTARTNOHAND, 0, 0)"
with two signals coming and being handled in kernel space results
in the syscall restart being done twice.

Avoid this by clearing the 'why' flag when we call the signal handling
code to prevent further syscall restarts after the first.

Acked-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/entry-common.S |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index f05a35a..4a560d3 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -48,6 +48,8 @@ work_pending:
 	beq	no_work_pending
 	mov	r0, sp				@ 'regs'
 	mov	r2, why				@ 'syscall'
+	tst	r1, #_TIF_SIGPENDING		@ delivering a signal?
+	movne	why, #0				@ prevent further restarts
 	bl	do_notify_resume
 	b	ret_slow_syscall		@ Check work again
 
-- 
1.6.2.5


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
