From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH v5 26/27] m68k: remove inline asm from minix_find_first_zero_bit
Date: Sat, 22 Jan 2011 22:13:58 +0900
Message-ID: <1295702039-23186-27-git-send-email-akinobu.mita@gmail.com>
References: <1295702039-23186-1-git-send-email-akinobu.mita@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1295702039-23186-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Roman Zippel <zippel@linux-m68k.org>, Andreas Schwab <schwab@linux-m68k.org>
List-Id: linux-arch.vger.kernel.org

As a preparation for moving minix bit operations from asm/bitops.h to
architecture independent code in minix filesystem, this removes inline
asm from minix_find_first_zero_bit() for m68k.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Roman Zippel <zippel@linux-m68k.org>
Cc: Andreas Schwab <schwab@linux-m68k.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

Change from v4:
 - no changes

The whole series is available in the git branch at:
 git://git.kernel.org/pub/scm/linux/kernel/git/mita/linux-2.6.git le-bitops-v5

 arch/m68k/include/asm/bitops_mm.h |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/m68k/include/asm/bitops_mm.h b/arch/m68k/include/asm/bitops_mm.h
index 645a4d5..497e711 100644
--- a/arch/m68k/include/asm/bitops_mm.h
+++ b/arch/m68k/include/asm/bitops_mm.h
@@ -330,23 +330,19 @@ static inline int __fls(int x)
 static inline int minix_find_first_zero_bit(const void *vaddr, unsigned size)
 {
 	const unsigned short *p = vaddr, *addr = vaddr;
-	int res;
 	unsigned short num;
 
 	if (!size)
 		return 0;
 
 	size = (size >> 4) + ((size & 15) > 0);
-	while (*p++ == 0xffff)
-	{
+	while (*p++ == 0xffff) {
 		if (--size == 0)
 			return (p - addr) << 4;
 	}
 
-	num = ~*--p;
-	__asm__ __volatile__ ("bfffo %1{#16,#16},%0"
-			      : "=d" (res) : "d" (num & -num));
-	return ((p - addr) << 4) + (res ^ 31);
+	num = *--p;
+	return ((p - addr) << 4) + ffz(num);
 }
 
 #define minix_test_and_set_bit(nr, addr)	__test_and_set_bit((nr) ^ 16, (unsigned long *)(addr))
-- 
1.7.3.4
