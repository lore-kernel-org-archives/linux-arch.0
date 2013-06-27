From: Chen Gang <gang.chen@asianux.com>
Subject: [PATCH] arch: m32r: include: asm: use 'readb' instead of 'read'
Date: Thu, 27 Jun 2013 10:57:34 +0800
Message-ID: <51CBAA1E.8000206@asianux.com>
References: <51CBA43F.9050000@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:55530 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751467Ab3F0C60 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 26 Jun 2013 22:58:26 -0400
In-Reply-To: <51CBA43F.9050000@asianux.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Hirokazu Takata <takata@linux-m32r.org>
Cc: linux-m32r@ml.linux-m32r.org, linux-m32r-ja@ml.linux-m32r.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

Need use 'readb' instead of 'read', it is a typo issue which found by
compiler.

The related error (with allmodconfig):

  drivers/i2c/busses/i2c-ocores.c: In function =91oc_getreg_8=92:
  drivers/i2c/busses/i2c-ocores.c:96:2: error: implicit declaration of =
function =91read=92 [-Werror=3Dimplicit-function-declaration]

Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/m32r/include/asm/io.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/m32r/include/asm/io.h b/arch/m32r/include/asm/io.h
index 4010f1f..343ae4c 100644
--- a/arch/m32r/include/asm/io.h
+++ b/arch/m32r/include/asm/io.h
@@ -162,7 +162,7 @@ static inline void _writel(unsigned long l, unsigne=
d long addr)
 #define __raw_writew writew
 #define __raw_writel writel
=20
-#define ioread8 read
+#define ioread8 readb
 #define ioread16 readw
 #define ioread32 readl
 #define iowrite8 writeb
--=20
1.7.7.6
