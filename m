From: Chen Gang <gang.chen@asianux.com>
Subject: [PATCH] arch: m32r: include: asm: add generic cmpxchg64() definition
Date: Thu, 27 Jun 2013 10:14:09 +0800
Message-ID: <51CB9FF1.4020308@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Hirokazu Takata <takata@linux-m32r.org>
Cc: linux-m32r@ml.linux-m32r.org, linux-m32r-ja@ml.linux-m32r.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Need define cmpxchg64(), so use generic one.

The related error (with allmodconfig):

  drivers/block/blockconsole.c: In function =91bcon_advance_console_byt=
es=92:
  drivers/block/blockconsole.c:164:2: error: implicit declaration of fu=
nction =91cmpxchg64=92 [-Werror=3Dimplicit-function-declaration]

Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/m32r/include/asm/cmpxchg.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/m32r/include/asm/cmpxchg.h b/arch/m32r/include/asm/cm=
pxchg.h
index de651db..a188b03 100644
--- a/arch/m32r/include/asm/cmpxchg.h
+++ b/arch/m32r/include/asm/cmpxchg.h
@@ -217,5 +217,6 @@ static inline unsigned long __cmpxchg_local(volatil=
e void *ptr,
 	((__typeof__(*(ptr)))__cmpxchg_local((ptr), (unsigned long)(o),	    \
 			(unsigned long)(n), sizeof(*(ptr))))
 #define cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr), (o=
), (n))
+#define cmpxchg64(ptr, o, n)	cmpxchg64_local((ptr), (o), (n))
=20
 #endif /* _ASM_M32R_CMPXCHG_H */
--=20
1.7.7.6
