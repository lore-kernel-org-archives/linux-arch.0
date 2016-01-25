Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49930 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932807AbcAYWYv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 25 Jan 2016 17:24:51 -0500
From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 08/16] ext4: In ext4_dir_llseek, check syscall bitness directly
Date: Mon, 25 Jan 2016 14:24:22 -0800
Message-ID: <8946a5499b6b9f2837fed067885b595ea52aafdf.1453759363.git.luto@kernel.org>
In-Reply-To: <cover.1453759363.git.luto@kernel.org>
References: <cover.1453759363.git.luto@kernel.org>
In-Reply-To: <cover.1453759363.git.luto@kernel.org>
References: <cover.1453759363.git.luto@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org, linux-arch <linux-arch@vger.kernel.org>, David Miller <davem@davemloft.net>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Chris Metcalf <cmetcalf@ezchip.com>, linux-parisc@vger.kernel.org, linux-mips@linux-mips.org, sparclinux@vger.kernel.org
Message-ID: <20160125222422.dJWuM-kCe0ZDUzQHj-PaDaZSxVzQ8zkezhCQGMuwBfY@z>

ext4 treats directory offsets differently for 32-bit and 64-bit
callers.  Check the caller type using in_compat_syscall, not
is_compat_task.  This changes behavior on SPARC slightly.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 fs/ext4/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index 1d1bca74f844..6395456edea6 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -276,7 +276,7 @@ errout:
 static inline int is_32bit_api(void)
 {
 #ifdef CONFIG_COMPAT
-	return is_compat_task();
+	return in_compat_syscall();
 #else
 	return (BITS_PER_LONG == 32);
 #endif
-- 
2.5.0

