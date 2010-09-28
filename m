From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 5/6] avr32: need to reset ->restart_block.fn on sigreturn
Date: Tue, 28 Sep 2010 03:58:03 +0100
Message-ID: <E1P0QOJ-0008Sx-0W@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:40282 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760599Ab0I1C6E (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 27 Sep 2010 22:58:04 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: hans-christian.egtvedt@atmel.com
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/avr32/kernel/signal.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/avr32/kernel/signal.c b/arch/avr32/kernel/signal.c
index 7dbbec1..8e8f6ba 100644
--- a/arch/avr32/kernel/signal.c
+++ b/arch/avr32/kernel/signal.c
@@ -42,6 +42,9 @@ restore_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc)
 {
 	int err = 0;
 
+	/* Always make any pending restarted system calls return -EINTR */
+	current_thread_info()->restart_block.fn = do_no_restart_syscall;
+
 #define COPY(x)		err |= __get_user(regs->x, &sc->x)
 	COPY(sr);
 	COPY(pc);
-- 
1.5.6.5
