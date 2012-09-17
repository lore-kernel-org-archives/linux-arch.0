From: Michal Simek <monstr@monstr.eu>
Subject: [PATCH 2/2] microblaze: Remove compilation failure
Date: Mon, 17 Sep 2012 11:18:25 +0200
Message-ID: <1347873505-17025-2-git-send-email-monstr@monstr.eu>
References: <1347873505-17025-1-git-send-email-monstr@monstr.eu>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:62585 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755397Ab2IQJSb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 17 Sep 2012 05:18:31 -0400
Received: by bkwj10 with SMTP id j10so2347777bkw.19
        for <linux-arch@vger.kernel.org>; Mon, 17 Sep 2012 02:18:30 -0700 (PDT)
In-Reply-To: <1347873505-17025-1-git-send-email-monstr@monstr.eu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: viro@ZenIV.linux.org.uk
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>

Remove typo fault in addik asm instruction.

Error log:
arch/microblaze/kernel/built-in.o: In function `sys_rt_sigreturn_wrapper':
(.text+0x50e0): undefined reference to `r0'

Caused by:
"microblaze: fix the horror with restarts of sigreturn()"
(sha1: 4441e2fc9d18124d395010d60435e07c70ae4271)

Signed-off-by: Michal Simek <monstr@monstr.eu>
---
 arch/microblaze/kernel/entry.S |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/microblaze/kernel/entry.S b/arch/microblaze/kernel/entry.S
index 48223a1..76ae019 100644
--- a/arch/microblaze/kernel/entry.S
+++ b/arch/microblaze/kernel/entry.S
@@ -429,7 +429,7 @@ C_ENTRY(ret_from_trap):
 	bri	1b
 
 	/* Maybe handle a signal */
-5:	
+5:
 	andi	r11, r19, _TIF_SIGPENDING | _TIF_NOTIFY_RESUME;
 	beqi	r11, 4f;		/* Signals to handle, handle them */
 
@@ -505,7 +505,7 @@ C_ENTRY(sys_execve):
 	addik	r8, r1, 0;		/* add user context as 4th arg */
 
 C_ENTRY(sys_rt_sigreturn_wrapper):
-	addik	r30, r0, r0		/* no restarts */
+	addik	r30, r0, 0		/* no restarts */
 	brid	sys_rt_sigreturn	/* Do real work */
 	addik	r5, r1, 0;		/* add user context as 1st arg */
 
-- 
1.7.0.4
