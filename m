From: Michal Simek <monstr@monstr.eu>
Subject: [PATCH 1/2] microblaze: Move restart allowed out of block
Date: Mon, 17 Sep 2012 11:18:24 +0200
Message-ID: <1347873505-17025-1-git-send-email-monstr@monstr.eu>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:53311 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755378Ab2IQJSa (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 17 Sep 2012 05:18:30 -0400
Received: by bkwj10 with SMTP id j10so2347763bkw.19
        for <linux-arch@vger.kernel.org>; Mon, 17 Sep 2012 02:18:29 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: viro@ZenIV.linux.org.uk
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>

Better not to break block which do work together.

Signed-off-by: Michal Simek <monstr@monstr.eu>
---
 arch/microblaze/kernel/entry.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/microblaze/kernel/entry.S b/arch/microblaze/kernel/entry.S
index 82ed20d..48223a1 100644
--- a/arch/microblaze/kernel/entry.S
+++ b/arch/microblaze/kernel/entry.S
@@ -371,8 +371,8 @@ C_ENTRY(_user_exception):
 	/* Figure out which function to use for this system call.  */
 	/* Note Microblaze barrel shift is optional, so don't rely on it */
 	add	r12, r12, r12;			/* convert num -> ptr */
-	addi	r30, r0, 1			/* restarts allowed */
 	add	r12, r12, r12;
+	addi	r30, r0, 1			/* restarts allowed */
 
 #ifdef DEBUG
 	/* Trac syscalls and stored them to syscall_debug_table */
-- 
1.7.0.4
