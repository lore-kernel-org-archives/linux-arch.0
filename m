From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [RFC][PATCH 13/14] arm: switch to csum_and_copy_from_user()
Date: Fri, 27 Mar 2020 23:31:16 +0000
Message-ID: <20200327233117.1031393-13-viro@ZenIV.linux.org.uk>
References: <20200327233006.GW23230@ZenIV.linux.org.uk>
 <20200327233117.1031393-1-viro@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:35938 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbgC0XbV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 27 Mar 2020 19:31:21 -0400
In-Reply-To: <20200327233117.1031393-1-viro@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Note that csum_partial_copy_from_user() is in assembler here,
so I'm leaving it alone and just providing the wrapper for
it.  When/if we go for switching arm to user_access_{begin,end}()
(doing domain switches in those), somebody well need to look
into that one.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/arm/include/asm/checksum.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/include/asm/checksum.h b/arch/arm/include/asm/checksum.h
index 20043e0ebb07..ed6073fee338 100644
--- a/arch/arm/include/asm/checksum.h
+++ b/arch/arm/include/asm/checksum.h
@@ -40,6 +40,20 @@ csum_partial_copy_nocheck(const void *src, void *dst, int len, __wsum sum);
 __wsum
 csum_partial_copy_from_user(const void __user *src, void *dst, int len, __wsum sum, int *err_ptr);
 
+#define _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
+static inline
+__wsum csum_and_copy_from_user (const void __user *src, void *dst,
+				      int len, __wsum sum, int *err_ptr)
+{
+	if (access_ok(src, len))
+		return csum_partial_copy_from_user(src, dst, len, sum, err_ptr);
+
+	if (len)
+		*err_ptr = -EFAULT;
+
+	return sum;
+}
+
 /*
  * 	Fold a partial checksum without adding pseudo headers
  */
-- 
2.11.0
