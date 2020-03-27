From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [RFC][PATCH 09/14] sparc: switch to providing csum_and_copy_from_user()
Date: Fri, 27 Mar 2020 23:31:12 +0000
Message-ID: <20200327233117.1031393-9-viro@ZenIV.linux.org.uk>
References: <20200327233006.GW23230@ZenIV.linux.org.uk>
 <20200327233117.1031393-1-viro@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200327233117.1031393-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

sparc64 already is equivalent to that (trivial access_ok());
add it into sparc32 csum_partial_copy_from_user() and we can
rename both to csum_and_copy_fromUser() and be done with that.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/sparc/include/asm/checksum.h    | 1 +
 arch/sparc/include/asm/checksum_32.h | 8 +++++++-
 arch/sparc/include/asm/checksum_64.h | 2 +-
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/include/asm/checksum.h b/arch/sparc/include/asm/checksum.h
index c3be56e2e768..a6256cb6fc5c 100644
--- a/arch/sparc/include/asm/checksum.h
+++ b/arch/sparc/include/asm/checksum.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef ___ASM_SPARC_CHECKSUM_H
 #define ___ASM_SPARC_CHECKSUM_H
+#define _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
 #if defined(__sparc__) && defined(__arch64__)
 #include <asm/checksum_64.h>
 #else
diff --git a/arch/sparc/include/asm/checksum_32.h b/arch/sparc/include/asm/checksum_32.h
index 450ddfb444c8..479a0b812af5 100644
--- a/arch/sparc/include/asm/checksum_32.h
+++ b/arch/sparc/include/asm/checksum_32.h
@@ -60,7 +60,7 @@ csum_partial_copy_nocheck(const void *src, void *dst, int len, __wsum sum)
 }
 
 static inline __wsum
-csum_partial_copy_from_user(const void __user *src, void *dst, int len,
+csum_and_copy_from_user(const void __user *src, void *dst, int len,
 			    __wsum sum, int *err)
   {
 	register unsigned long ret asm("o0") = (unsigned long)src;
@@ -68,6 +68,12 @@ csum_partial_copy_from_user(const void __user *src, void *dst, int len,
 	register int l asm("g1") = len;
 	register __wsum s asm("g7") = sum;
 
+	if (unlikely(!access_ok(src, len))) {
+		if (len)
+			*err = -EFAULT;
+		return sum;
+	}
+
 	__asm__ __volatile__ (
 	".section __ex_table,#alloc\n\t"
 	".align 4\n\t"
diff --git a/arch/sparc/include/asm/checksum_64.h b/arch/sparc/include/asm/checksum_64.h
index e52450930e4e..0fa4433f5662 100644
--- a/arch/sparc/include/asm/checksum_64.h
+++ b/arch/sparc/include/asm/checksum_64.h
@@ -46,7 +46,7 @@ long __csum_partial_copy_from_user(const void __user *src,
 				   __wsum sum);
 
 static inline __wsum
-csum_partial_copy_from_user(const void __user *src,
+csum_and_copy_from_user(const void __user *src,
 			    void *dst, int len,
 			    __wsum sum, int *err)
 {
-- 
2.11.0
