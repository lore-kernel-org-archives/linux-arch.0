From: Chen Gang <gang.chen@asianux.com>
Subject: [PATCH] arch: m32r: include: asm: add ioread*be() and iowrite*be()
Date: Thu, 27 Jun 2013 11:29:45 +0800
Message-ID: <51CBB1A9.5080203@asianux.com>
References: <51CBA43F.9050000@asianux.com> <51CBAA1E.8000206@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:37323 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751557Ab3F0Dai (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 26 Jun 2013 23:30:38 -0400
In-Reply-To: <51CBAA1E.8000206@asianux.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Hirokazu Takata <takata@linux-m32r.org>
Cc: linux-m32r@ml.linux-m32r.org, linux-m32r-ja@ml.linux-m32r.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

Add generic ioread*be() and iowrite*be(), or compiling fails.

The related error (with allmodconfig):

  drivers/ipack/ipack.c: In function =91ipack_device_read_id=92:
  drivers/ipack/ipack.c:376:3: error: implicit declaration of function =
=91ioread16be=92 [-Werror=3Dimplicit-function-declaration]

Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/m32r/include/asm/io.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/m32r/include/asm/io.h b/arch/m32r/include/asm/io.h
index 4010f1f..9f9b609 100644
--- a/arch/m32r/include/asm/io.h
+++ b/arch/m32r/include/asm/io.h
@@ -164,10 +164,14 @@ static inline void _writel(unsigned long l, unsig=
ned long addr)
=20
 #define ioread8 read
 #define ioread16 readw
+#define ioread16be(addr)	__be16_to_cpu(__raw_readw(addr))
 #define ioread32 readl
+#define ioread32be(addr)	__be32_to_cpu(__raw_readl(addr))
 #define iowrite8 writeb
 #define iowrite16 writew
+#define iowrite16be(v, addr)	__raw_writew(__cpu_to_be16(v), addr)
 #define iowrite32 writel
+#define iowrite32be(v, addr)	__raw_writel(__cpu_to_be32(v), addr)
=20
 #define mmiowb()
=20
--=20
1.7.7.6
