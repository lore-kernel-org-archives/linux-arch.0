From: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 1/4] xtensa: reset windowbase/windowstart when cloning the VM
Date: Mon, 29 Oct 2012 18:56:18 +0400
Message-ID: <1351522581-30516-2-git-send-email-jcmvbkbc@gmail.com>
References: <1351522581-30516-1-git-send-email-jcmvbkbc@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:47053 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753589Ab2J2O4n (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 29 Oct 2012 10:56:43 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so3826596lag.19
        for <linux-arch@vger.kernel.org>; Mon, 29 Oct 2012 07:56:42 -0700 (PDT)
In-Reply-To: <1351522581-30516-1-git-send-email-jcmvbkbc@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-arch@vger.kernel.org, Chris Zankel <chris@zankel.net>, Marc Gauthier <marc@tensilica.com>, Max Filippov <jcmvbkbc@gmail.com>

From: Chris Zankel <chris@zankel.net>

When we copy a user thread with CLONE_VM, we also have to reset
windowbase and windowstart to start a pristine stack frame. Otherwise,
overflows can happen using the address 0 as the stack pointer.
Also add a special case for vfork, which continues on the
parent stack until it calls execve. Because this could be a call8, we
need to spill the stack pointer of the previus frame (if still 'live' in
the register file).

Signed-off-by: Chris Zankel <chris@zankel.net>
---
 arch/xtensa/kernel/process.c |   26 +++++++++++++++++++++++++-
 1 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/arch/xtensa/kernel/process.c b/arch/xtensa/kernel/process.c
index 1908f66..341c151 100644
--- a/arch/xtensa/kernel/process.c
+++ b/arch/xtensa/kernel/process.c
@@ -220,8 +220,32 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	if (user_mode(regs)) {
 
 		childregs->areg[1] = usp;
+
+		/* When sharing memory with the parent thread, the child
+		   usually starts on a pristine stack, so we have to reset
+		   windowbase, windowstart and wmask.
+		   (Note that such a new thread is required to always create
+		   an initial call4 frame)
+		   The exception is vfork, where the new thread continues to
+		   run on the parent's stack until it calls execve. This could
+		   be a call8 or call12, which requires a legal stack frame
+		   of the previous caller for the overflow handlers to work.
+		   (Note that it's always legal to overflow live registers).
+		   In this case, ensure to spill at least the stack pointer
+		   of that frame. */
+
 		if (clone_flags & CLONE_VM) {
-			childregs->wmask = 1;	/* can't share live windows */
+			/* check that caller window is live and same stack */
+			int len = childregs->wmask & ~0xf;
+			if (regs->areg[1] == usp && len != 0) {
+				int callinc = (regs->areg[0] >> 30) & 3;
+				int caller_ars = XCHAL_NUM_AREGS - callinc * 4;
+				put_user(regs->areg[caller_ars+1],
+					 (unsigned __user*)(usp - 12));
+			}
+			childregs->wmask = 1;
+			childregs->windowstart = 1;
+			childregs->windowbase = 0;
 		} else {
 			int len = childregs->wmask & ~0xf;
 			memcpy(&childregs->areg[XCHAL_NUM_AREGS - len/4],
-- 
1.7.7.6
