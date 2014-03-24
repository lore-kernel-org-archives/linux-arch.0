From: behanw@converseincode.com
Subject: [PATCH v4] LLVMLinux: Remove warning about returning an uninitialized variable
Date: Sun, 23 Mar 2014 22:53:24 -0700
Message-ID: <1395640404-27958-1-git-send-email-behanw@converseincode.com>
References: <1395506558.2143.18.camel@dabdike.int.hansenpartnership.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:46853 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993AbaCXFxc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 24 Mar 2014 01:53:32 -0400
Received: by mail-pd0-f178.google.com with SMTP id x10so4859809pdj.23
        for <linux-arch@vger.kernel.org>; Sun, 23 Mar 2014 22:53:31 -0700 (PDT)
In-Reply-To: <1395506558.2143.18.camel@dabdike.int.hansenpartnership.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, dwmw2@infradead.org, pageexec@freemail.hu, Behan Webster <behanw@converseincode.com>, Mark Charlebois <charlebm@gmail.com>

From: Behan Webster <behanw@converseincode.com>

Fix uninitialized return code in default case in cmpxchg-local.h

This patch fixes the code to prevent an uninitialized return value that is detected
when compiling with clang. The bug produces numerous warnings when compiling the
Linux kernel with clang.

Signed-off-by: Behan Webster <behanw@converseincode.com>
Signed-off-by: Mark Charlebois <charlebm@gmail.com>
---
 include/asm-generic/cmpxchg-local.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/cmpxchg-local.h b/include/asm-generic/cmpxchg-local.h
index d8d4c89..70bef78 100644
--- a/include/asm-generic/cmpxchg-local.h
+++ b/include/asm-generic/cmpxchg-local.h
@@ -4,7 +4,8 @@
 #include <linux/types.h>
 #include <linux/irqflags.h>
 
-extern unsigned long wrong_size_cmpxchg(volatile void *ptr);
+extern unsigned long wrong_size_cmpxchg(volatile void *ptr)
+	__noreturn;
 
 /*
  * Generic version of __cmpxchg_local (disables interrupts). Takes an unsigned
-- 
1.8.3.2
