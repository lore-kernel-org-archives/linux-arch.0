From: Joel Porquet <joel@porquet.org>
Subject: [PATCH] asm-generic: uaccess: avoid name conflicts for strncpy and str(n)len
Date: Wed, 28 May 2014 17:21:51 +0200
Message-ID: <1401290511-10211-1-git-send-email-joel@porquet.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mo5.mail-out.ovh.net ([178.32.228.5]:43885 "EHLO
	mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752968AbaE1Qiv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 28 May 2014 12:38:51 -0400
Received: from mail422.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo5.mail-out.ovh.net (Postfix) with SMTP id B3650FFBD49
	for <linux-arch@vger.kernel.org>; Wed, 28 May 2014 17:22:13 +0200 (CEST)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Joel Porquet <joel@porquet.org>

asm-generic/uaccess.h defines 'strncpy_from_user', 'strnlen_user' and
'strlen_user' as static inline functions. It makes it impossible for an
arch to include asm-generic/uaccess.h and benefits from its content, in
addition to defining GENERIC_STRNCPY_FROM_USER and GENERIC_STRNLEN_USER.

Both configuration tokens respectively enable lib/strncpy_from_user.c
and lib/strnlen_user.c which redefine the same symbols, causing
redefinition errors at compilation.

This patch modifies asm-generic/uaccess.h so that strncpy_from_user is
not defined when GENERIC_STRNCPY_FROM_USER is, and strnlen_user and
strlen_user are not defined when GENERIC_STRNLEN_USER is, thus avoiding
any name conflict.

At the moment, numerous archs, which make use of
GENERIC_STRNCPY_FROM_USER and GENERIC_STRNLEN_USER, are forced to
rewrite an entire asm/uaccess.h header because of this issue.

To the best of my knowledge, the following list of archs could benefit
from this patch: x86, sh, openrisc, powerpc, arm64, arm, alpha, parisc,
sparc, m68k.

Signed-off-by: Joel Porquet <joel@porquet.org>
---
 include/asm-generic/uaccess.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/asm-generic/uaccess.h b/include/asm-generic/uaccess.h
index 72d8803..4198d84 100644
--- a/include/asm-generic/uaccess.h
+++ b/include/asm-generic/uaccess.h
@@ -272,6 +272,7 @@ static inline long copy_to_user(void __user *to,
 		return n;
 }
 
+#ifndef CONFIG_GENERIC_STRNCPY_FROM_USER
 /*
  * Copy a null terminated string from userspace.
  */
@@ -294,7 +295,9 @@ strncpy_from_user(char *dst, const char __user *src, long count)
 		return -EFAULT;
 	return __strncpy_from_user(dst, src, count);
 }
+#endif
 
+#ifndef CONFIG_GENERIC_STRNLEN_USER
 /*
  * Return the size of a string (including the ending 0)
  *
@@ -320,6 +323,7 @@ static inline long strlen_user(const char __user *src)
 {
 	return strnlen_user(src, 32767);
 }
+#endif
 
 /*
  * Zero Userspace
-- 
1.9.3
