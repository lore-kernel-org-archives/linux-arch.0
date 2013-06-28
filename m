From: Chen Gang <gang.chen@asianux.com>
Subject: [PATCH] arch: tile: include: asm: add cmpxchg64() definition
Date: Fri, 28 Jun 2013 09:51:35 +0800
Message-ID: <51CCEC27.8050508@asianux.com>
References: <51CA6D21.3090901@asianux.com> <51CC492C.1040105@tilera.com> <51CCD891.8000806@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:45166 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753249Ab3F1Bw3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 27 Jun 2013 21:52:29 -0400
In-Reply-To: <51CCD891.8000806@asianux.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Metcalf <cmetcalf@tilera.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

Need add cmpxchg64(), or will cause compiling issue.

Just define it as cmpxchg(), since cmpxchg() can support 8 bytes.

The related error (with allmodconfig):

  drivers/block/blockconsole.c: In function =A1=AEbcon_advance_console_=
bytes=A1=AF:
  drivers/block/blockconsole.c:164:2: error: implicit declaration of fu=
nction =A1=AEcmpxchg64=A1=AF [-Werror=3Dimplicit-function-declaration]

Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/tile/include/asm/cmpxchg.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/tile/include/asm/cmpxchg.h b/arch/tile/include/asm/cm=
pxchg.h
index 276f067..7688c28 100644
--- a/arch/tile/include/asm/cmpxchg.h
+++ b/arch/tile/include/asm/cmpxchg.h
@@ -68,6 +68,8 @@ extern unsigned long __cmpxchg_called_with_bad_pointe=
r(void);
=20
 #define tas(ptr) (xchg((ptr), 1))
=20
+#define cmpxchg64(ptr, o, n)		cmpxchg((ptr), (o), (n))
+
 #endif /* __ASSEMBLY__ */
=20
 #endif /* _ASM_TILE_CMPXCHG_H */
--=20
1.7.7.6
