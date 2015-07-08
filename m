From: Chris Metcalf <cmetcalf@ezchip.com>
Subject: [PATCH v2 3/3] tile: use global strscpy() rather than private copy
Date: Wed, 8 Jul 2015 16:20:45 -0400
Message-ID: <1436386845-11989-4-git-send-email-cmetcalf@ezchip.com>
References: <1436386845-11989-1-git-send-email-cmetcalf@ezchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436386845-11989-1-git-send-email-cmetcalf@ezchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Chris Metcalf <cmetcalf@ezchip.com>, Al Viro <viro@zeniv.linux.org.uk>, Fabian Frederick <fabf@skynet.be>, Randy Dunlap <rdunlap@infradead.org>, Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, gregkh@linuxfoundation.org, Peter Zijlstra <peterz@infradead.org>, "David S. Miller" <davem@davemloft.net>, Frederic Weisbecker <fweisbec@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Sam Ravnborg <sam@ravnborg.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Theodore Ts'o <tytso@mit.edu>, Grant Likely <grant.likely@linaro.org>, Dan Carpenter <dan.carpenter@oracle.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michael Ellerman <mpe@ellerman.id.au>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Now that strscpy() is a standard API, remove the local copy.

Signed-off-by: Chris Metcalf <cmetcalf@ezchip.com>
---
 arch/tile/gxio/mpipe.c | 33 ++++-----------------------------
 1 file changed, 4 insertions(+), 29 deletions(-)

diff --git a/arch/tile/gxio/mpipe.c b/arch/tile/gxio/mpipe.c
index ee186e13dfe6..f102048d9c0e 100644
--- a/arch/tile/gxio/mpipe.c
+++ b/arch/tile/gxio/mpipe.c
@@ -19,6 +19,7 @@
 #include <linux/errno.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/string.h>
 
 #include <gxio/iorpc_globals.h>
 #include <gxio/iorpc_mpipe.h>
@@ -29,32 +30,6 @@
 /* HACK: Avoid pointless "shadow" warnings. */
 #define link link_shadow
 
-/**
- * strscpy - Copy a C-string into a sized buffer, but only if it fits
- * @dest: Where to copy the string to
- * @src: Where to copy the string from
- * @size: size of destination buffer
- *
- * Use this routine to avoid copying too-long strings.
- * The routine returns the total number of bytes copied
- * (including the trailing NUL) or zero if the buffer wasn't
- * big enough.  To ensure that programmers pay attention
- * to the return code, the destination has a single NUL
- * written at the front (if size is non-zero) when the
- * buffer is not big enough.
- */
-static size_t strscpy(char *dest, const char *src, size_t size)
-{
-	size_t len = strnlen(src, size) + 1;
-	if (len > size) {
-		if (size)
-			dest[0] = '\0';
-		return 0;
-	}
-	memcpy(dest, src, len);
-	return len;
-}
-
 int gxio_mpipe_init(gxio_mpipe_context_t *context, unsigned int mpipe_index)
 {
 	char file[32];
@@ -540,7 +515,7 @@ int gxio_mpipe_link_instance(const char *link_name)
 	if (!context)
 		return GXIO_ERR_NO_DEVICE;
 
-	if (strscpy(name.name, link_name, sizeof(name.name)) == 0)
+	if (strscpy(name.name, link_name, sizeof(name.name)) < 0)
 		return GXIO_ERR_NO_DEVICE;
 
 	return gxio_mpipe_info_instance_aux(context, name);
@@ -559,7 +534,7 @@ int gxio_mpipe_link_enumerate_mac(int idx, char *link_name, uint8_t *link_mac)
 
 	rv = gxio_mpipe_info_enumerate_aux(context, idx, &name, &mac);
 	if (rv >= 0) {
-		if (strscpy(link_name, name.name, sizeof(name.name)) == 0)
+		if (strscpy(link_name, name.name, sizeof(name.name)) < 0)
 			return GXIO_ERR_INVAL_MEMORY_SIZE;
 		memcpy(link_mac, mac.mac, sizeof(mac.mac));
 	}
@@ -576,7 +551,7 @@ int gxio_mpipe_link_open(gxio_mpipe_link_t *link,
 	_gxio_mpipe_link_name_t name;
 	int rv;
 
-	if (strscpy(name.name, link_name, sizeof(name.name)) == 0)
+	if (strscpy(name.name, link_name, sizeof(name.name)) < 0)
 		return GXIO_ERR_NO_DEVICE;
 
 	rv = gxio_mpipe_link_open_aux(context, name, flags);
-- 
2.1.2
