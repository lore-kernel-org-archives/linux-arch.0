From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 1/6] avr32: missed _TIF_NOTIFY_RESUME on one of
 do_notify_resume callers
Date: Tue, 28 Sep 2010 03:57:22 +0100
Message-ID: <E1P0QNe-0008Rr-Vf@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:40263 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933043Ab0I1C5X (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 27 Sep 2010 22:57:23 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: hans-christian.egtvedt@atmel.com
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org


we need that not just on syscall returns but on irq ones as well...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/avr32/kernel/entry-avr32b.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/avr32/kernel/entry-avr32b.S b/arch/avr32/kernel/entry-avr32b.S
index 169268c..5e6beb2 100644
--- a/arch/avr32/kernel/entry-avr32b.S
+++ b/arch/avr32/kernel/entry-avr32b.S
@@ -587,7 +587,7 @@ fault_exit_work:
 	ld.w	r1, r0[TI_flags]
 	rjmp	fault_exit_work
 
-1:	mov	r2, _TIF_SIGPENDING | _TIF_RESTORE_SIGMASK
+1:	mov	r2, _TIF_SIGPENDING | _TIF_RESTORE_SIGMASK | _TIF_NOTIFY_RESUME
 	tst	r1, r2
 	breq	2f
 	unmask_interrupts
-- 
1.5.6.5
