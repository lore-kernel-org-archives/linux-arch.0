From: "Guan Xuetao" <guanxuetao@mprc.pku.edu.cn>
Subject: [PATCH] asm-generic headers: add arch-specific __strnlen_user calling in uaccess.h
Date: Tue, 11 Jan 2011 16:07:27 +0800
Message-ID: <008801cbb166$96cd0430$c4670c90$@mprc.pku.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mprc.pku.edu.cn ([162.105.203.9]:48777 "EHLO mprc.pku.edu.cn"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752293Ab1AKIHg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 11 Jan 2011 03:07:36 -0500
Content-Language: zh-cn
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

From: Guan Xuetao <guanxuetao@mprc.pku.edu.cn>

	This patch changes the implementation of strnlen_user in include/asm-generic/uaccess.h.
	Originally, it calls strlen() function directly, which may not correctly handle the access of
	user space in most mmu-enabled architectures.
	New __strnlen_user is added for using as an architecture specific function.

Signed-off-by: Guan Xuetao <guanxuetao@mprc.pku.edu.cn>
---
 include/asm-generic/uaccess.h |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/uaccess.h b/include/asm-generic/uaccess.h
index b218b85..ac68c99 100644
--- a/include/asm-generic/uaccess.h
+++ b/include/asm-generic/uaccess.h
@@ -288,14 +288,16 @@ strncpy_from_user(char *dst, const char __user *src, long count)
  *
  * Return 0 on exception, a value greater than N if too long
  */
-#ifndef strnlen_user
+#ifndef __strnlen_user
+#define __strnlen_user strnlen
+#endif
+
 static inline long strnlen_user(const char __user *src, long n)
 {
 	if (!access_ok(VERIFY_READ, src, 1))
 		return 0;
-	return strlen((void * __force)src) + 1;
+	return __strnlen_user(src, n);
 }
-#endif
 
 static inline long strlen_user(const char __user *src)
 {
