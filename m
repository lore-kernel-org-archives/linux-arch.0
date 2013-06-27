From: Chen Gang <gang.chen@asianux.com>
Subject: [PATCH] arch: m32r: include: asm: add generic ioremap_wc() definition
Date: Thu, 27 Jun 2013 10:32:31 +0800
Message-ID: <51CBA43F.9050000@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:50926 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922Ab3F0CdY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 26 Jun 2013 22:33:24 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Hirokazu Takata <takata@linux-m32r.org>
Cc: linux-m32r@ml.linux-m32r.org, linux-m32r-ja@ml.linux-m32r.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

Add generic ioremap_wc() definition, or compiling failed.

The related error (with allmodconfig):

  drivers/gpu/drm/drm_bufs.c: In function =91drm_addmap_core=92:
  drivers/gpu/drm/drm_bufs.c:219:5: error: implicit declaration of func=
tion =91ioremap_wc=92 [-Werror=3Dimplicit-function-declaration]
  drivers/gpu/drm/drm_bufs.c:219:17: warning: assignment makes pointer =
from integer without a cast [enabled by default]

Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/m32r/include/asm/io.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/m32r/include/asm/io.h b/arch/m32r/include/asm/io.h
index 4010f1f..f9f4fb6 100644
--- a/arch/m32r/include/asm/io.h
+++ b/arch/m32r/include/asm/io.h
@@ -67,6 +67,7 @@ static inline void __iomem *ioremap(unsigned long off=
set, unsigned long size)
=20
 extern void iounmap(volatile void __iomem *addr);
 #define ioremap_nocache(off,size) ioremap(off,size)
+#define ioremap_wc ioremap_nocache
=20
 /*
  * IO bus memory addresses are also 1:1 with the physical address
--=20
1.7.7.6
