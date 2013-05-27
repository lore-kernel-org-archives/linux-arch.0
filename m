From: Chen Gang <gang.chen@asianux.com>
Subject: [PATCH] arch: xtensa: include: asm: compiling issue, need cmpxchg64()
 defined.
Date: Mon, 27 May 2013 19:57:01 +0800
Message-ID: <51A34A0D.5070407@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:18733 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755498Ab3E0L5w (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 27 May 2013 07:57:52 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: chris@zankel.net, jcmvbkbc@gmail.com
Cc: linux-xtensa@linux-xtensa.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>


When compiling with 'allmodconfig', some of drivers need cmpxchg64(),
xtensa does not supply 64-bit implementation for 'xchg', so use the
'generic' implementation.

e.g. (for next-20130527 tree):
  drivers/block/blockconsole.c:164:2: error: implicit declaration of fu=
nction =91cmpxchg64=92 [-Werror=3Dimplicit-function-declaration]

Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/xtensa/include/asm/cmpxchg.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/xtensa/include/asm/cmpxchg.h b/arch/xtensa/include/as=
m/cmpxchg.h
index d9ab131..370b26f 100644
--- a/arch/xtensa/include/asm/cmpxchg.h
+++ b/arch/xtensa/include/asm/cmpxchg.h
@@ -93,6 +93,7 @@ static inline unsigned long __cmpxchg_local(volatile =
void *ptr,
 	((__typeof__(*(ptr)))__cmpxchg_local_generic((ptr), (unsigned long)(o=
),\
 			(unsigned long)(n), sizeof(*(ptr))))
 #define cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr), (o=
), (n))
+#define cmpxchg64(ptr, o, n)    cmpxchg64_local((ptr), (o), (n))
=20
 /*
  * xchg_u32
--=20
1.7.7.6
