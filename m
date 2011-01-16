From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] xfs: Do not name variables "panic"
Date: Sun, 16 Jan 2011 14:14:25 +0100 (CET)
Message-ID: <alpine.DEB.2.00.1101161409150.24311@ayla.of.borg>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-7
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gerard.telenet-ops.be ([195.130.132.48]:33362 "EHLO
	gerard.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752301Ab1APNO3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 16 Jan 2011 08:14:29 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Chinner <dchinner@redhat.com>, Alex Elder <aelder@sgi.com>, Christoph Hellwig <hch@lst.de>
Cc: xfs@oss.sgi.com, Linux Kernel Development <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org

On platforms that call panic() inside their BUG() macro (m68k/sun3, and
all platforms that don't set HAVE_ARCH_BUG), compilation fails with:

| fs/xfs/support/debug.c: In function =A1xfs_cmn_err=A2:
| fs/xfs/support/debug.c:92: error: called object =A1panic=A2 is not a =
function

as the local variable "panic" conflicts with the "panic()" function.
Rename the local variable to resolve this.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
m68k/sun3: http://kisskb.ellerman.id.au/kisskb/buildresult/3779006/
None of the !HAVE_ARCH_BUG archs (h8300, m32r, m68knommu, microblaze, s=
core,
tile, xtensa) seems to be covered by linux-next

 fs/xfs/support/debug.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/support/debug.c b/fs/xfs/support/debug.c
index e6cf955..0df8889 100644
--- a/fs/xfs/support/debug.c
+++ b/fs/xfs/support/debug.c
@@ -75,11 +75,11 @@ xfs_cmn_err(
 {
 	struct va_format	vaf;
 	va_list			args;
-	int			panic =3D 0;
+	int			do_panic =3D 0;
=20
 	if (xfs_panic_mask && (xfs_panic_mask & panic_tag)) {
 		printk(KERN_ALERT "XFS: Transforming an alert into a BUG.");
-		panic =3D 1;
+		do_panic =3D 1;
 	}
=20
 	va_start(args, fmt);
@@ -89,7 +89,7 @@ xfs_cmn_err(
 	printk(KERN_ALERT "Filesystem %s: %pV", mp->m_fsname, &vaf);
 	va_end(args);
=20
-	BUG_ON(panic);
+	BUG_ON(do_panic);
 }
=20
 void
--=20
1.7.0.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
							    -- Linus Torvalds
