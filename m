From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [RFC][PATCH 04/14] x86: switch 32bit csum_and_copy_to_user() to user_access_{begin,end}()
Date: Fri, 27 Mar 2020 23:31:07 +0000
Message-ID: <20200327233117.1031393-4-viro@ZenIV.linux.org.uk>
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

consolidate HAVE_CSUM_COPY_USER for 32bit and 64bit, while are at it

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/include/asm/checksum.h    | 1 +
 arch/x86/include/asm/checksum_32.h | 6 ++----
 arch/x86/include/asm/checksum_64.h | 3 ---
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/checksum.h b/arch/x86/include/asm/checksum.h
index 1ab9572ae4c2..0ada98d5d09f 100644
--- a/arch/x86/include/asm/checksum.h
+++ b/arch/x86/include/asm/checksum.h
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #define  _HAVE_ARCH_COPY_AND_CSUM_FROM_USER 1
+#define HAVE_CSUM_COPY_USER
 #ifdef CONFIG_X86_32
 # include <asm/checksum_32.h>
 #else
diff --git a/arch/x86/include/asm/checksum_32.h b/arch/x86/include/asm/checksum_32.h
index 2487b7fc2d24..11624c8a9d8d 100644
--- a/arch/x86/include/asm/checksum_32.h
+++ b/arch/x86/include/asm/checksum_32.h
@@ -176,7 +176,6 @@ static inline __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 /*
  *	Copy and checksum to user
  */
-#define HAVE_CSUM_COPY_USER
 static inline __wsum csum_and_copy_to_user(const void *src,
 					   void __user *dst,
 					   int len, __wsum sum,
@@ -185,11 +184,10 @@ static inline __wsum csum_and_copy_to_user(const void *src,
 	__wsum ret;
 
 	might_sleep();
-	if (access_ok(dst, len)) {
-		stac();
+	if (user_access_begin(dst, len)) {
 		ret = csum_partial_copy_generic(src, (__force void *)dst,
 						len, sum, NULL, err_ptr);
-		clac();
+		user_access_end();
 		return ret;
 	}
 
diff --git a/arch/x86/include/asm/checksum_64.h b/arch/x86/include/asm/checksum_64.h
index 2f8435542376..0a289b87e872 100644
--- a/arch/x86/include/asm/checksum_64.h
+++ b/arch/x86/include/asm/checksum_64.h
@@ -129,9 +129,6 @@ static inline __sum16 csum_tcpudp_magic(__be32 saddr, __be32 daddr,
  */
 extern __wsum csum_partial(const void *buff, int len, __wsum sum);
 
-#define HAVE_CSUM_COPY_USER 1
-
-
 /* Do not call this directly. Use the wrappers below */
 extern __visible __wsum csum_partial_copy_generic(const void *src, const void *dst,
 					int len, __wsum sum,
-- 
2.11.0
