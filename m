From: Chen Gang <gang.chen@asianux.com>
Subject: [PATCH] arch: xtensa: include: asm: define '_PAGE_CHG_MASK' when
 'NOMMU'
Date: Sat, 22 Jun 2013 15:40:36 +0800
Message-ID: <51C554F4.8060704@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:9299 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828Ab3FVHlb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 22 Jun 2013 03:41:31 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: chris@zankel.net, Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-xtensa@linux-xtensa.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>


Define '_PAGE_CHG_MASK' when 'NOMMU' to pass compiling.

The related make:

  make ARCH=3Dxtensa allmodconfig
  make ARCH=3Dxtensa menuconfig
    set "xtensa-linux-gnu-" for "Cross compilier tool prefix"
    select "s6000" for "Processor type and features" -> "Xtensa Process=
or"
  make ARCH=3Dxtensa EXTRA_CFLAGS=3D-W

The related error:

  arch/xtensa/include/asm/pgtable.h: In function =91pte_modify=92:
  arch/xtensa/include/asm/pgtable.h:289:9: error: =91_PAGE_CHG_MASK=92 =
undeclared (first use in this function)


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/xtensa/include/asm/pgtable.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/xtensa/include/asm/pgtable.h b/arch/xtensa/include/as=
m/pgtable.h
index 7e09f70..a28c49b 100644
--- a/arch/xtensa/include/asm/pgtable.h
+++ b/arch/xtensa/include/asm/pgtable.h
@@ -149,9 +149,10 @@
 #define _PAGE_DIRTY		(1<<7)	/* software: page dirty */
 #define _PAGE_ACCESSED		(1<<8)	/* software: page accessed (read) */
=20
+#define _PAGE_CHG_MASK	   (PAGE_MASK | _PAGE_ACCESSED | _PAGE_DIRTY)
+
 #ifdef CONFIG_MMU
=20
-#define _PAGE_CHG_MASK	   (PAGE_MASK | _PAGE_ACCESSED | _PAGE_DIRTY)
 #define _PAGE_PRESENT	   (_PAGE_HW_VALID | _PAGE_CA_WB | _PAGE_ACCESSE=
D)
=20
 #define PAGE_NONE	   __pgprot(_PAGE_NONE | _PAGE_USER)
--=20
1.7.7.6
