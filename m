From: Mark Salter <msalter@redhat.com>
Subject: [PATCH 01/24] fix default __strnlen_user macro
Date: Mon, 22 Aug 2011 16:09:22 -0400
Message-ID: <1314043785-2880-2-git-send-email-msalter@redhat.com>
References: <1314043785-2880-1-git-send-email-msalter@redhat.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46403 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752588Ab1HVULC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 22 Aug 2011 16:11:02 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p7MKB1mk006637
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-arch@vger.kernel.org>; Mon, 22 Aug 2011 16:11:01 -0400
In-Reply-To: <1314043785-2880-1-git-send-email-msalter@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Mark Salter <msalter@redhat.com>

The existing __strnlen_user macro simply resolved to strnlen. However, the
count returned by strnlen_user should include the NULL byte. This patch
fixes the __strnlen_user macro to include the NULL byte in the count.

Signed-off-by: Mark Salter <msalter@redhat.com>
---
 include/asm-generic/uaccess.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/asm-generic/uaccess.h b/include/asm-generic/uaccess.h
index ac68c99..1d0fdf8 100644
--- a/include/asm-generic/uaccess.h
+++ b/include/asm-generic/uaccess.h
@@ -289,7 +289,7 @@ strncpy_from_user(char *dst, const char __user *src, long count)
  * Return 0 on exception, a value greater than N if too long
  */
 #ifndef __strnlen_user
-#define __strnlen_user strnlen
+#define __strnlen_user(s, n) (strnlen((s), (n)) + 1)
 #endif
 
 static inline long strnlen_user(const char __user *src, long n)
-- 
1.7.6
