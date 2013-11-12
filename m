From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 06/17] frv: Remove unused declarations of __start___ex_table and __stop___ex_table
Date: Tue, 12 Nov 2013 20:42:16 +0100
Message-ID: <1384285347-13506-7-git-send-email-geert@linux-m68k.org>
References: <1384285347-13506-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from jacques.telenet-ops.be ([195.130.132.50]:60489 "EHLO
	jacques.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755458Ab3KLTmk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 12 Nov 2013 14:42:40 -0500
In-Reply-To: <1384285347-13506-1-git-send-email-geert@linux-m68k.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, David Howells <dhowells@redhat.com>

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: David Howells <dhowells@redhat.com>
---
 arch/frv/mm/extable.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/frv/mm/extable.c b/arch/frv/mm/extable.c
index 6aea124f574d..2fb9b3ab57b9 100644
--- a/arch/frv/mm/extable.c
+++ b/arch/frv/mm/extable.c
@@ -6,8 +6,6 @@
 #include <linux/spinlock.h>
 #include <asm/uaccess.h>
 
-extern const struct exception_table_entry __attribute__((aligned(8))) __start___ex_table[];
-extern const struct exception_table_entry __attribute__((aligned(8))) __stop___ex_table[];
 extern const void __memset_end, __memset_user_error_lr, __memset_user_error_handler;
 extern const void __memcpy_end, __memcpy_user_error_lr, __memcpy_user_error_handler;
 extern spinlock_t modlist_lock;
-- 
1.7.9.5
