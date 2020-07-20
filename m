From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] arch, net: remove the last csum_partial_copy() leftovers
Date: Mon, 20 Jul 2020 13:36:09 +0200
Message-ID: <20200720113609.177259-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: msalter@redhat.com, jacquiot.aurelien@gmail.com, ley.foon.tan@intel.com, arnd@arndb.de
Cc: linux-c6x-dev@linux-c6x.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Most of the tree only uses and implements csum_partial_copy_nocheck,
but the c6x and lib/checksum.c implement a csum_partial_copy that
isn't used anywere except to define csum_partial_copy.  Get rid of
this pointless alias.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/c6x/lib/checksum.c           | 2 +-
 arch/c6x/lib/csum_64plus.S        | 8 ++++----
 arch/nios2/include/asm/checksum.h | 5 ++---
 include/asm-generic/checksum.h    | 6 ++----
 lib/checksum.c                    | 4 ++--
 5 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/arch/c6x/lib/checksum.c b/arch/c6x/lib/checksum.c
index 335ca490080847..dff2e2ec6e6472 100644
--- a/arch/c6x/lib/checksum.c
+++ b/arch/c6x/lib/checksum.c
@@ -6,6 +6,6 @@
 
 /* These are from csum_64plus.S */
 EXPORT_SYMBOL(csum_partial);
-EXPORT_SYMBOL(csum_partial_copy);
+EXPORT_SYMBOL(csum_partial_copy_nocheck);
 EXPORT_SYMBOL(ip_compute_csum);
 EXPORT_SYMBOL(ip_fast_csum);
diff --git a/arch/c6x/lib/csum_64plus.S b/arch/c6x/lib/csum_64plus.S
index 8e625a30fd435a..9c07127485d165 100644
--- a/arch/c6x/lib/csum_64plus.S
+++ b/arch/c6x/lib/csum_64plus.S
@@ -10,8 +10,8 @@
 #include <linux/linkage.h>
 
 ;
-;unsigned int csum_partial_copy(const char *src, char * dst,
-;				int len, int sum)
+;unsigned int csum_partial_copy_nocheck(const char *src, char * dst,
+;					int len, int sum)
 ;
 ; A4:	src
 ; B4:	dst
@@ -21,7 +21,7 @@
 ;
 
 	.text
-ENTRY(csum_partial_copy)
+ENTRY(csum_partial_copy_nocheck)
 	MVC	.S2	ILC,B30
 
 	MV	.D1X	B6,A31		; given csum
@@ -149,7 +149,7 @@ L10:	ADD	.D1	A31,A9,A9
 
 	BNOP	.S2	B3,4
 	MVC	.S2	B30,ILC
-ENDPROC(csum_partial_copy)
+ENDPROC(csum_partial_copy_nocheck)
 
 ;
 ;unsigned short
diff --git a/arch/nios2/include/asm/checksum.h b/arch/nios2/include/asm/checksum.h
index ec39698d3beac8..b4316c361729f0 100644
--- a/arch/nios2/include/asm/checksum.h
+++ b/arch/nios2/include/asm/checksum.h
@@ -12,10 +12,9 @@
 
 /* Take these from lib/checksum.c */
 extern __wsum csum_partial(const void *buff, int len, __wsum sum);
-extern __wsum csum_partial_copy(const void *src, void *dst, int len,
+__wsum csum_partial_copy_nocheck(const void *src, void *dst, int len,
 				__wsum sum);
-#define csum_partial_copy_nocheck(src, dst, len, sum)	\
-	csum_partial_copy((src), (dst), (len), (sum))
+#define csum_partial_copy_nocheck csum_partial_copy_nocheck
 
 extern __sum16 ip_fast_csum(const void *iph, unsigned int ihl);
 extern __sum16 ip_compute_csum(const void *buff, int len);
diff --git a/include/asm-generic/checksum.h b/include/asm-generic/checksum.h
index 5a80f8e543008a..cd8b75aa770d00 100644
--- a/include/asm-generic/checksum.h
+++ b/include/asm-generic/checksum.h
@@ -23,11 +23,9 @@ extern __wsum csum_partial(const void *buff, int len, __wsum sum);
  * here even more important to align src and dst on a 32-bit (or even
  * better 64-bit) boundary
  */
-extern __wsum csum_partial_copy(const void *src, void *dst, int len, __wsum sum);
-
 #ifndef csum_partial_copy_nocheck
-#define csum_partial_copy_nocheck(src, dst, len, sum)	\
-	csum_partial_copy((src), (dst), (len), (sum))
+__wsum csum_partial_copy_nocheck(const void *src, void *dst, int len,
+		__wsum sum);
 #endif
 
 #ifndef ip_fast_csum
diff --git a/lib/checksum.c b/lib/checksum.c
index 7ac65a0000ff09..c7861e84c5261a 100644
--- a/lib/checksum.c
+++ b/lib/checksum.c
@@ -149,12 +149,12 @@ EXPORT_SYMBOL(ip_compute_csum);
  * copy from ds while checksumming, otherwise like csum_partial
  */
 __wsum
-csum_partial_copy(const void *src, void *dst, int len, __wsum sum)
+csum_partial_copy_nocheck(const void *src, void *dst, int len, __wsum sum)
 {
 	memcpy(dst, src, len);
 	return csum_partial(dst, len, sum);
 }
-EXPORT_SYMBOL(csum_partial_copy);
+EXPORT_SYMBOL(csum_partial_copy_nocheck);
 
 #ifndef csum_tcpudp_nofold
 static inline u32 from64to32(u64 x)
-- 
2.27.0
