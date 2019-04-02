Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfDBIDj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 2 Apr 2019 04:03:39 -0400
From: guoren@kernel.org
Subject: [PATCH 3/3] riscv/signal: Fixup additional syscall restarting
Date: Tue,  2 Apr 2019 16:02:33 +0800
Message-ID: <1554192153-2587-3-git-send-email-guoren@kernel.org>
In-Reply-To: <1554192153-2587-1-git-send-email-guoren@kernel.org>
References: <1554192153-2587-1-git-send-email-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de, palmer@sifive.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, ren_guo@c-sky.com, linux-riscv@lists.infradead.org
Message-ID: <20190402080233.cQ6llgZqjR8J6uODoerKWEU6j7DdlxjXty62zOrVoyU@z>

From: Guo Ren <ren_guo@c-sky.com>

The function of do_notify_resume called by entry.S could be entered
in loop when SIGPENDING was setted again before sret. So we must add
prevent code to make syscall restart (regs->sepc -= 0x4) or it may
re-execute unexpected instructions.

Just like in_syscall & forget_syscall used by arm.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/riscv/kernel/signal.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index 837e164..804d6ee 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -234,6 +234,9 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 
 	/* Are we from a system call? */
 	if (regs->scause == EXC_SYSCALL) {
+		/* Avoid additional syscall restarting via ret_from_exception */
+		regs->scause = -1UL;
+
 		/* If so, check system call restarting.. */
 		switch (regs->a0) {
 		case -ERESTART_RESTARTBLOCK:
@@ -272,6 +275,9 @@ static void do_signal(struct pt_regs *regs)
 
 	/* Did we come from a system call? */
 	if (regs->scause == EXC_SYSCALL) {
+		/* Avoid additional syscall restarting via ret_from_exception */
+		regs->scause = -1UL;
+
 		/* Restart the system call - no handlers present */
 		switch (regs->a0) {
 		case -ERESTARTNOHAND:
-- 
2.7.4
