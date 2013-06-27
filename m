From: Chen Gang <gang.chen@asianux.com>
Subject: [PATCH] arch: m32r: include: asm: add "dma-mapping-common.h"
Date: Thu, 27 Jun 2013 12:50:59 +0800
Message-ID: <51CBC4B3.807@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:7692 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993Ab3F0Evw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 27 Jun 2013 00:51:52 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Hirokazu Takata <takata@linux-m32r.org>
Cc: "dhowells@redhat.com" <dhowells@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Paul McKenney <paulmck@linux.vnet.ibm.com>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>, Rusty Russell <rusty@rustcorp.com.au>, linux-m32r@ml.linux-m32r.org, linux-m32r-ja@ml.linux-m32r.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

Need add generic "dma-mapping-common.h", or compiling may fail.

The related error (with allmodconfig):

    CC [M]  net/irda/irlan/irlan_eth.o
  drivers/media/v4l2-core/videobuf2-dma-contig.c: In function =91vb2_dc=
_mmap=92:
  drivers/media/v4l2-core/videobuf2-dma-contig.c:202:2: error: implicit=
 declaration of function =91dma_mmap_coherent=92 [-Werror=3Dimplicit-fu=
nction-declaration]
  drivers/media/v4l2-core/videobuf2-dma-contig.c: In function =91vb2_dc=
_get_base_sgt=92:
  drivers/media/v4l2-core/videobuf2-dma-contig.c:385:2: error: implicit=
 declaration of function =91dma_get_sgtable=92 [-Werror=3Dimplicit-func=
tion-declaration]


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/m32r/include/asm/Kbuild |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/m32r/include/asm/Kbuild b/arch/m32r/include/asm/Kbuil=
d
index bebdc36..fecca22 100644
--- a/arch/m32r/include/asm/Kbuild
+++ b/arch/m32r/include/asm/Kbuild
@@ -1,5 +1,6 @@
=20
 generic-y +=3D clkdev.h
+generic-y +=3D dma-mapping-common.h
 generic-y +=3D exec.h
 generic-y +=3D module.h
 generic-y +=3D trace_clock.h
--=20
1.7.7.6
