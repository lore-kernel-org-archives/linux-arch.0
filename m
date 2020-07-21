From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [PATCH 13/18] mips: __csum_partial_copy_kernel() has no users left
Date: Tue, 21 Jul 2020 21:25:44 +0100
Message-ID: <20200721202549.4150745-13-viro@ZenIV.linux.org.uk>
References: <20200721202425.GA2786714@ZenIV.linux.org.uk>
 <20200721202549.4150745-1-viro@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200721202549.4150745-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/mips/include/asm/checksum.h | 3 ---
 arch/mips/lib/csum_partial.S     | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/arch/mips/include/asm/checksum.h b/arch/mips/include/asm/checksum.h
index 7a5c97c5d705..bf02d2d3869f 100644
--- a/arch/mips/include/asm/checksum.h
+++ b/arch/mips/include/asm/checksum.h
@@ -34,9 +34,6 @@
  */
 __wsum csum_partial(const void *buff, int len, __wsum sum);
 
-__wsum __csum_partial_copy_kernel(const void *src, void *dst,
-				  int len, __wsum sum, int *err_ptr);
-
 __wsum __csum_partial_copy_from_user(const void *src, void *dst,
 				     int len, __wsum sum, int *err_ptr);
 __wsum __csum_partial_copy_to_user(const void *src, void *dst,
diff --git a/arch/mips/lib/csum_partial.S b/arch/mips/lib/csum_partial.S
index 8d70855b0914..983e909c2052 100644
--- a/arch/mips/lib/csum_partial.S
+++ b/arch/mips/lib/csum_partial.S
@@ -827,8 +827,6 @@ EXPORT_SYMBOL(csum_partial)
 	.set	pop
 	.endm
 
-LEAF(__csum_partial_copy_kernel)
-EXPORT_SYMBOL(__csum_partial_copy_kernel)
 #ifndef CONFIG_EVA
 FEXPORT(__csum_partial_copy_to_user)
 EXPORT_SYMBOL(__csum_partial_copy_to_user)
@@ -836,7 +834,6 @@ FEXPORT(__csum_partial_copy_from_user)
 EXPORT_SYMBOL(__csum_partial_copy_from_user)
 #endif
 __BUILD_CSUM_PARTIAL_COPY_USER LEGACY_MODE USEROP USEROP 1
-END(__csum_partial_copy_kernel)
 
 #ifdef CONFIG_EVA
 LEAF(__csum_partial_copy_to_user)
-- 
2.11.0
