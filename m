From: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 4/7] Blackfin: Rename DES PC2() symbol
	to avoid collision
Date: Thu, 26 Aug 2010 15:11:26 +0100
Message-ID: <20100826141126.11132.71843.stgit@warthog.procyon.org.uk>
References: <20100826141110.11132.91931.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <20100826141110.11132.91931.stgit-S6HVgzuS8uM4Awkfq6JHfwNdhmdF6hFW@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org
Cc: dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

Rename the PC2() symbol in the generic DES crypto module to be prefixed with
DES_ to avoid collision with arch code (Blackfin in this case).

Signed-off-by: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---

 crypto/des_generic.c |  130 +++++++++++++++++++++++++-------------------------
 1 files changed, 65 insertions(+), 65 deletions(-)

diff --git a/crypto/des_generic.c b/crypto/des_generic.c
index 249f903..873818d 100644
--- a/crypto/des_generic.c
+++ b/crypto/des_generic.c
@@ -614,7 +614,7 @@ static const u32 S8[64] = {
 #define T3(x) pt[2 * (x) + 2]
 #define T4(x) pt[2 * (x) + 3]
 
-#define PC2(a, b, c, d) (T4(d) | T3(c) | T2(b) | T1(a))
+#define DES_PC2(a, b, c, d) (T4(d) | T3(c) | T2(b) | T1(a))
 
 /*
  * Encryption key expansion
@@ -639,22 +639,22 @@ unsigned long des_ekey(u32 *pe, const u8 *k)
 	b = k[6]; b &= 0x0e; b <<= 4; b |= k[2] & 0x1e; b = pc1[b];
 	a = k[7]; a &= 0x0e; a <<= 4; a |= k[3] & 0x1e; a = pc1[a];
 
-	pe[15 * 2 + 0] = PC2(a, b, c, d); d = rs[d];
-	pe[14 * 2 + 0] = PC2(d, a, b, c); c = rs[c]; b = rs[b];
-	pe[13 * 2 + 0] = PC2(b, c, d, a); a = rs[a]; d = rs[d];
-	pe[12 * 2 + 0] = PC2(d, a, b, c); c = rs[c]; b = rs[b];
-	pe[11 * 2 + 0] = PC2(b, c, d, a); a = rs[a]; d = rs[d];
-	pe[10 * 2 + 0] = PC2(d, a, b, c); c = rs[c]; b = rs[b];
-	pe[ 9 * 2 + 0] = PC2(b, c, d, a); a = rs[a]; d = rs[d];
-	pe[ 8 * 2 + 0] = PC2(d, a, b, c); c = rs[c];
-	pe[ 7 * 2 + 0] = PC2(c, d, a, b); b = rs[b]; a = rs[a];
-	pe[ 6 * 2 + 0] = PC2(a, b, c, d); d = rs[d]; c = rs[c];
-	pe[ 5 * 2 + 0] = PC2(c, d, a, b); b = rs[b]; a = rs[a];
-	pe[ 4 * 2 + 0] = PC2(a, b, c, d); d = rs[d]; c = rs[c];
-	pe[ 3 * 2 + 0] = PC2(c, d, a, b); b = rs[b]; a = rs[a];
-	pe[ 2 * 2 + 0] = PC2(a, b, c, d); d = rs[d]; c = rs[c];
-	pe[ 1 * 2 + 0] = PC2(c, d, a, b); b = rs[b];
-	pe[ 0 * 2 + 0] = PC2(b, c, d, a);
+	pe[15 * 2 + 0] = DES_PC2(a, b, c, d); d = rs[d];
+	pe[14 * 2 + 0] = DES_PC2(d, a, b, c); c = rs[c]; b = rs[b];
+	pe[13 * 2 + 0] = DES_PC2(b, c, d, a); a = rs[a]; d = rs[d];
+	pe[12 * 2 + 0] = DES_PC2(d, a, b, c); c = rs[c]; b = rs[b];
+	pe[11 * 2 + 0] = DES_PC2(b, c, d, a); a = rs[a]; d = rs[d];
+	pe[10 * 2 + 0] = DES_PC2(d, a, b, c); c = rs[c]; b = rs[b];
+	pe[ 9 * 2 + 0] = DES_PC2(b, c, d, a); a = rs[a]; d = rs[d];
+	pe[ 8 * 2 + 0] = DES_PC2(d, a, b, c); c = rs[c];
+	pe[ 7 * 2 + 0] = DES_PC2(c, d, a, b); b = rs[b]; a = rs[a];
+	pe[ 6 * 2 + 0] = DES_PC2(a, b, c, d); d = rs[d]; c = rs[c];
+	pe[ 5 * 2 + 0] = DES_PC2(c, d, a, b); b = rs[b]; a = rs[a];
+	pe[ 4 * 2 + 0] = DES_PC2(a, b, c, d); d = rs[d]; c = rs[c];
+	pe[ 3 * 2 + 0] = DES_PC2(c, d, a, b); b = rs[b]; a = rs[a];
+	pe[ 2 * 2 + 0] = DES_PC2(a, b, c, d); d = rs[d]; c = rs[c];
+	pe[ 1 * 2 + 0] = DES_PC2(c, d, a, b); b = rs[b];
+	pe[ 0 * 2 + 0] = DES_PC2(b, c, d, a);
 
 	/* Check if first half is weak */
 	w  = (a ^ c) | (b ^ d) | (rs[a] ^ c) | (b ^ rs[d]);
@@ -670,22 +670,22 @@ unsigned long des_ekey(u32 *pe, const u8 *k)
 	/* Check if second half is weak */
 	w |= (a ^ c) | (b ^ d) | (rs[a] ^ c) | (b ^ rs[d]);
 
-	pe[15 * 2 + 1] = PC2(a, b, c, d); d = rs[d];
-	pe[14 * 2 + 1] = PC2(d, a, b, c); c = rs[c]; b = rs[b];
-	pe[13 * 2 + 1] = PC2(b, c, d, a); a = rs[a]; d = rs[d];
-	pe[12 * 2 + 1] = PC2(d, a, b, c); c = rs[c]; b = rs[b];
-	pe[11 * 2 + 1] = PC2(b, c, d, a); a = rs[a]; d = rs[d];
-	pe[10 * 2 + 1] = PC2(d, a, b, c); c = rs[c]; b = rs[b];
-	pe[ 9 * 2 + 1] = PC2(b, c, d, a); a = rs[a]; d = rs[d];
-	pe[ 8 * 2 + 1] = PC2(d, a, b, c); c = rs[c];
-	pe[ 7 * 2 + 1] = PC2(c, d, a, b); b = rs[b]; a = rs[a];
-	pe[ 6 * 2 + 1] = PC2(a, b, c, d); d = rs[d]; c = rs[c];
-	pe[ 5 * 2 + 1] = PC2(c, d, a, b); b = rs[b]; a = rs[a];
-	pe[ 4 * 2 + 1] = PC2(a, b, c, d); d = rs[d]; c = rs[c];
-	pe[ 3 * 2 + 1] = PC2(c, d, a, b); b = rs[b]; a = rs[a];
-	pe[ 2 * 2 + 1] = PC2(a, b, c, d); d = rs[d]; c = rs[c];
-	pe[ 1 * 2 + 1] = PC2(c, d, a, b); b = rs[b];
-	pe[ 0 * 2 + 1] = PC2(b, c, d, a);
+	pe[15 * 2 + 1] = DES_PC2(a, b, c, d); d = rs[d];
+	pe[14 * 2 + 1] = DES_PC2(d, a, b, c); c = rs[c]; b = rs[b];
+	pe[13 * 2 + 1] = DES_PC2(b, c, d, a); a = rs[a]; d = rs[d];
+	pe[12 * 2 + 1] = DES_PC2(d, a, b, c); c = rs[c]; b = rs[b];
+	pe[11 * 2 + 1] = DES_PC2(b, c, d, a); a = rs[a]; d = rs[d];
+	pe[10 * 2 + 1] = DES_PC2(d, a, b, c); c = rs[c]; b = rs[b];
+	pe[ 9 * 2 + 1] = DES_PC2(b, c, d, a); a = rs[a]; d = rs[d];
+	pe[ 8 * 2 + 1] = DES_PC2(d, a, b, c); c = rs[c];
+	pe[ 7 * 2 + 1] = DES_PC2(c, d, a, b); b = rs[b]; a = rs[a];
+	pe[ 6 * 2 + 1] = DES_PC2(a, b, c, d); d = rs[d]; c = rs[c];
+	pe[ 5 * 2 + 1] = DES_PC2(c, d, a, b); b = rs[b]; a = rs[a];
+	pe[ 4 * 2 + 1] = DES_PC2(a, b, c, d); d = rs[d]; c = rs[c];
+	pe[ 3 * 2 + 1] = DES_PC2(c, d, a, b); b = rs[b]; a = rs[a];
+	pe[ 2 * 2 + 1] = DES_PC2(a, b, c, d); d = rs[d]; c = rs[c];
+	pe[ 1 * 2 + 1] = DES_PC2(c, d, a, b); b = rs[b];
+	pe[ 0 * 2 + 1] = DES_PC2(b, c, d, a);
 
 	/* Fixup: 2413 5768 -> 1357 2468 */
 	for (d = 0; d < 16; ++d) {
@@ -722,22 +722,22 @@ static void dkey(u32 *pe, const u8 *k)
 	b = k[6]; b &= 0x0e; b <<= 4; b |= k[2] & 0x1e; b = pc1[b];
 	a = k[7]; a &= 0x0e; a <<= 4; a |= k[3] & 0x1e; a = pc1[a];
 
-	pe[ 0 * 2] = PC2(a, b, c, d); d = rs[d];
-	pe[ 1 * 2] = PC2(d, a, b, c); c = rs[c]; b = rs[b];
-	pe[ 2 * 2] = PC2(b, c, d, a); a = rs[a]; d = rs[d];
-	pe[ 3 * 2] = PC2(d, a, b, c); c = rs[c]; b = rs[b];
-	pe[ 4 * 2] = PC2(b, c, d, a); a = rs[a]; d = rs[d];
-	pe[ 5 * 2] = PC2(d, a, b, c); c = rs[c]; b = rs[b];
-	pe[ 6 * 2] = PC2(b, c, d, a); a = rs[a]; d = rs[d];
-	pe[ 7 * 2] = PC2(d, a, b, c); c = rs[c];
-	pe[ 8 * 2] = PC2(c, d, a, b); b = rs[b]; a = rs[a];
-	pe[ 9 * 2] = PC2(a, b, c, d); d = rs[d]; c = rs[c];
-	pe[10 * 2] = PC2(c, d, a, b); b = rs[b]; a = rs[a];
-	pe[11 * 2] = PC2(a, b, c, d); d = rs[d]; c = rs[c];
-	pe[12 * 2] = PC2(c, d, a, b); b = rs[b]; a = rs[a];
-	pe[13 * 2] = PC2(a, b, c, d); d = rs[d]; c = rs[c];
-	pe[14 * 2] = PC2(c, d, a, b); b = rs[b];
-	pe[15 * 2] = PC2(b, c, d, a);
+	pe[ 0 * 2] = DES_PC2(a, b, c, d); d = rs[d];
+	pe[ 1 * 2] = DES_PC2(d, a, b, c); c = rs[c]; b = rs[b];
+	pe[ 2 * 2] = DES_PC2(b, c, d, a); a = rs[a]; d = rs[d];
+	pe[ 3 * 2] = DES_PC2(d, a, b, c); c = rs[c]; b = rs[b];
+	pe[ 4 * 2] = DES_PC2(b, c, d, a); a = rs[a]; d = rs[d];
+	pe[ 5 * 2] = DES_PC2(d, a, b, c); c = rs[c]; b = rs[b];
+	pe[ 6 * 2] = DES_PC2(b, c, d, a); a = rs[a]; d = rs[d];
+	pe[ 7 * 2] = DES_PC2(d, a, b, c); c = rs[c];
+	pe[ 8 * 2] = DES_PC2(c, d, a, b); b = rs[b]; a = rs[a];
+	pe[ 9 * 2] = DES_PC2(a, b, c, d); d = rs[d]; c = rs[c];
+	pe[10 * 2] = DES_PC2(c, d, a, b); b = rs[b]; a = rs[a];
+	pe[11 * 2] = DES_PC2(a, b, c, d); d = rs[d]; c = rs[c];
+	pe[12 * 2] = DES_PC2(c, d, a, b); b = rs[b]; a = rs[a];
+	pe[13 * 2] = DES_PC2(a, b, c, d); d = rs[d]; c = rs[c];
+	pe[14 * 2] = DES_PC2(c, d, a, b); b = rs[b];
+	pe[15 * 2] = DES_PC2(b, c, d, a);
 
 	/* Skip to next table set */
 	pt += 512;
@@ -747,22 +747,22 @@ static void dkey(u32 *pe, const u8 *k)
 	b = k[2]; b &= 0xe0; b >>= 4; b |= k[6] & 0xf0; b = pc1[b + 1];
 	a = k[3]; a &= 0xe0; a >>= 4; a |= k[7] & 0xf0; a = pc1[a + 1];
 
-	pe[ 0 * 2 + 1] = PC2(a, b, c, d); d = rs[d];
-	pe[ 1 * 2 + 1] = PC2(d, a, b, c); c = rs[c]; b = rs[b];
-	pe[ 2 * 2 + 1] = PC2(b, c, d, a); a = rs[a]; d = rs[d];
-	pe[ 3 * 2 + 1] = PC2(d, a, b, c); c = rs[c]; b = rs[b];
-	pe[ 4 * 2 + 1] = PC2(b, c, d, a); a = rs[a]; d = rs[d];
-	pe[ 5 * 2 + 1] = PC2(d, a, b, c); c = rs[c]; b = rs[b];
-	pe[ 6 * 2 + 1] = PC2(b, c, d, a); a = rs[a]; d = rs[d];
-	pe[ 7 * 2 + 1] = PC2(d, a, b, c); c = rs[c];
-	pe[ 8 * 2 + 1] = PC2(c, d, a, b); b = rs[b]; a = rs[a];
-	pe[ 9 * 2 + 1] = PC2(a, b, c, d); d = rs[d]; c = rs[c];
-	pe[10 * 2 + 1] = PC2(c, d, a, b); b = rs[b]; a = rs[a];
-	pe[11 * 2 + 1] = PC2(a, b, c, d); d = rs[d]; c = rs[c];
-	pe[12 * 2 + 1] = PC2(c, d, a, b); b = rs[b]; a = rs[a];
-	pe[13 * 2 + 1] = PC2(a, b, c, d); d = rs[d]; c = rs[c];
-	pe[14 * 2 + 1] = PC2(c, d, a, b); b = rs[b];
-	pe[15 * 2 + 1] = PC2(b, c, d, a);
+	pe[ 0 * 2 + 1] = DES_PC2(a, b, c, d); d = rs[d];
+	pe[ 1 * 2 + 1] = DES_PC2(d, a, b, c); c = rs[c]; b = rs[b];
+	pe[ 2 * 2 + 1] = DES_PC2(b, c, d, a); a = rs[a]; d = rs[d];
+	pe[ 3 * 2 + 1] = DES_PC2(d, a, b, c); c = rs[c]; b = rs[b];
+	pe[ 4 * 2 + 1] = DES_PC2(b, c, d, a); a = rs[a]; d = rs[d];
+	pe[ 5 * 2 + 1] = DES_PC2(d, a, b, c); c = rs[c]; b = rs[b];
+	pe[ 6 * 2 + 1] = DES_PC2(b, c, d, a); a = rs[a]; d = rs[d];
+	pe[ 7 * 2 + 1] = DES_PC2(d, a, b, c); c = rs[c];
+	pe[ 8 * 2 + 1] = DES_PC2(c, d, a, b); b = rs[b]; a = rs[a];
+	pe[ 9 * 2 + 1] = DES_PC2(a, b, c, d); d = rs[d]; c = rs[c];
+	pe[10 * 2 + 1] = DES_PC2(c, d, a, b); b = rs[b]; a = rs[a];
+	pe[11 * 2 + 1] = DES_PC2(a, b, c, d); d = rs[d]; c = rs[c];
+	pe[12 * 2 + 1] = DES_PC2(c, d, a, b); b = rs[b]; a = rs[a];
+	pe[13 * 2 + 1] = DES_PC2(a, b, c, d); d = rs[d]; c = rs[c];
+	pe[14 * 2 + 1] = DES_PC2(c, d, a, b); b = rs[b];
+	pe[15 * 2 + 1] = DES_PC2(b, c, d, a);
 
 	/* Fixup: 2413 5768 -> 1357 2468 */
 	for (d = 0; d < 16; ++d) {
