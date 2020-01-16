From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH v2 1/2] asm-generic/uaccess: don't define inline functions if noinline lib/* in use
Date: Wed, 15 Jan 2020 16:21:23 -0800
Message-ID: <20200116002124.17988-2-vgupta@synopsys.com>
References: <20200116002124.17988-1-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:58916 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729025AbgAPAV2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Jan 2020 19:21:28 -0500
In-Reply-To: <20200116002124.17988-1-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-snps-arc@lists.infradead.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>, Vineet Gupta <Vineet.Gupta1@synopsys.com>

There are 2 generic varaints of strncpy_from_user() / strnlen_user()
 (1). inline version in asm-generic/uaccess.h
 (2). optimized word-at-a-time version in lib/*

This patch disables #1 if #2 selected. This allows arches to continue
reusing asm-generic/uaccess.h for rest of code

This came up when switching ARC to generic word-at-a-time interface

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 include/asm-generic/uaccess.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/asm-generic/uaccess.h b/include/asm-generic/uaccess.h
index e935318804f8..2ea7f4e0e60e 100644
--- a/include/asm-generic/uaccess.h
+++ b/include/asm-generic/uaccess.h
@@ -212,6 +212,7 @@ static inline int __get_user_fn(size_t size, const void __user *ptr, void *x)
 
 extern int __get_user_bad(void) __attribute__((noreturn));
 
+#ifndef CONFIG_GENERIC_STRNCPY_FROM_USER
 /*
  * Copy a null terminated string from userspace.
  */
@@ -234,7 +235,11 @@ strncpy_from_user(char *dst, const char __user *src, long count)
 		return -EFAULT;
 	return __strncpy_from_user(dst, src, count);
 }
+#else
+extern long strncpy_from_user(char *dest, const char __user *src, long count);
+#endif
 
+#ifndef CONFIG_GENERIC_STRNLEN_USER
 /*
  * Return the size of a string (including the ending 0)
  *
@@ -255,6 +260,9 @@ static inline long strnlen_user(const char __user *src, long n)
 		return 0;
 	return __strnlen_user(src, n);
 }
+#else
+extern __must_check long strnlen_user(const char __user *str, long n);
+#endif
 
 /*
  * Zero Userspace
-- 
2.20.1
