From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH v3 1/7] m68knommu: fix build error due to the lack of find_next_bit_le()
Date: Wed, 27 Apr 2011 22:20:05 +0900
Message-ID: <1303910411-15793-2-git-send-email-akinobu.mita@gmail.com>
References: <1303910411-15793-1-git-send-email-akinobu.mita@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1303910411-15793-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, arnd@arndb.de
Cc: Akinobu Mita <akinobu.mita@gmail.com>, Greg Ungerer <gerg@uclinux.org>
List-Id: linux-arch.vger.kernel.org

m68knommu can't build ext4, udf, and ocfs2 due to the lack of
find_next_bit_le().

This implements find_next_bit_le() on m68knommu by duplicating the
generic find_next_bit_le() in lib/find_next_bit.c.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Greg Ungerer <gerg@uclinux.org>
---

This patch should go into 2.6.39

 arch/m68k/include/asm/bitops_no.h |   44 +++++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/arch/m68k/include/asm/bitops_no.h b/arch/m68k/include/asm/bitops_no.h
index 7d3779f..97d1d0c 100644
--- a/arch/m68k/include/asm/bitops_no.h
+++ b/arch/m68k/include/asm/bitops_no.h
@@ -336,6 +336,50 @@ found_middle:
 	return result + ffz(__swab32(tmp));
 }
 
+static inline unsigned long find_next_bit_le(const void *addr, unsigned
+		long size, unsigned long offset)
+{
+	const unsigned long *p = addr;
+	unsigned long result = offset & ~(BITS_PER_LONG - 1);
+	unsigned long tmp;
+
+	if (offset >= size)
+		return size;
+	p += offset / BITS_PER_LONG;
+	size -= result;
+	offset &= (BITS_PER_LONG - 1UL);
+	if (offset) {
+		tmp = __swab32(*(p++));
+		tmp &= (~0UL << offset);
+		if (size < BITS_PER_LONG)
+			goto found_first;
+		if (tmp)
+			goto found_middle;
+		size -= BITS_PER_LONG;
+		result += BITS_PER_LONG;
+	}
+
+	while (size & ~(BITS_PER_LONG - 1)) {
+		tmp = *(p++);
+		if (tmp)
+			goto found_middle_swap;
+		result += BITS_PER_LONG;
+		size -= BITS_PER_LONG;
+	}
+	if (!size)
+		return result;
+	tmp = __swab32(*p);
+found_first:
+	tmp &= (~0UL >> (BITS_PER_LONG - size));
+	if (tmp == 0UL)		/* Are any bits set? */
+		return result + size; /* Nope. */
+found_middle:
+	return result + __ffs(tmp);
+
+found_middle_swap:
+	return result + __ffs(__swab32(tmp));
+}
+
 #endif /* __KERNEL__ */
 
 #include <asm-generic/bitops/fls.h>
-- 
1.7.4.4
