Return-Path: <sky@de.ibm.com>
Received: from mtagate6.uk.ibm.com ([195.212.29.139]:64696 "EHLO
	mtagate6.uk.ibm.com") by vger.kernel.org with ESMTP id S268419AbUCYNUM
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 25 Mar 2004 08:20:12 -0500
Date: Thu, 25 Mar 2004 14:02:07 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] swp_entry_t vs. swap pte.
Message-ID: <20040325130207.GA1127@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Hi Andrew,
as requested the swp_entry_t vs. swap pte patch against bitkeeper with
comments on what the heck we are doing there.

blue skies,
  Martin.

ChangeLog:

[PATCH] swp_entry_t vs. swap pte.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

This fixes a problem in sys_swapon that can cause the creation of
invalid swap ptes. This has its cause in the arch-independent swap
entries vs. the pte coded swap entries. The swp_entry_t uses 27
bits for the offset and 5 bits for the type. In sys_swapon this
definition is used to find how many swap devices and how many pages
on each device there can be. But the swap entries encoded in a pte
can be subject to additional restrictions due to the hardware
besides the 27/5 division of the bits in the swp_entry_t type.
This is solved by adding pte_to_swp_entry and swp_entry_to_pte
calls to the calculations for maximum type and offset.

In addition the s390 swap pte division for offset/type is changed
from 19/6 bits to 20/5 bits.

diff -urN linux-2.6/include/asm-s390/pgtable.h linux-2.6-swp/include/asm-s390/pgtable.h
--- linux-2.6/include/asm-s390/pgtable.h	Thu Mar 11 03:55:42 2004
+++ linux-2.6-swp/include/asm-s390/pgtable.h	Thu Mar 25 10:00:12 2004
@@ -719,14 +719,14 @@
  * information in the lowcore.
  * Bit 21 and bit 22 are the page invalid bit and the page protection
  * bit. We set both to indicate a swapped page.
- * Bit 31 is used as the software page present bit. If a page is
- * swapped this obviously has to be zero.
- * This leaves the bits 1-19 and bits 24-30 to store type and offset.
- * We use the 7 bits from 24-30 for the type and the 19 bits from 1-19
- * for the offset.
- * 0|     offset      |0110|type |0
- * 00000000001111111111222222222233
- * 01234567890123456789012345678901
+ * Bit 30 and 31 are used to distinguish the different page types. For
+ * a swapped page these bits need to be zero.
+ * This leaves the bits 1-19 and bits 24-29 to store type and offset.
+ * We use the 5 bits from 25-29 for the type and the 20 bits from 1-19
+ * plus 24 for the offset.
+ * 0|     offset        |0110|o|type |00|
+ * 0 0000000001111111111 2222 2 22222 33
+ * 0 1234567890123456789 0123 4 56789 01
  *
  * 64 bit swap entry format:
  * A page-table entry has some bits we have to treat in a special way.
@@ -736,29 +736,25 @@
  * information in the lowcore.
  * Bit 53 and bit 54 are the page invalid bit and the page protection
  * bit. We set both to indicate a swapped page.
- * Bit 63 is used as the software page present bit. If a page is
- * swapped this obviously has to be zero.
- * This leaves the bits 0-51 and bits 56-62 to store type and offset.
- * We use the 7 bits from 56-62 for the type and the 52 bits from 0-51
- * for the offset.
- * |                     offset                       |0110|type |0
- * 0000000000111111111122222222223333333333444444444455555555556666
- * 0123456789012345678901234567890123456789012345678901234567890123
+ * Bit 62 and 63 are used to distinguish the different page types. For
+ * a swapped page these bits need to be zero.
+ * This leaves the bits 0-51 and bits 56-61 to store type and offset.
+ * We use the 5 bits from 57-61 for the type and the 53 bits from 0-51
+ * plus 56 for the offset.
+ * |                      offset                        |0110|o|type |00|
+ *  0000000000111111111122222222223333333333444444444455 5555 5 55566 66
+ *  0123456789012345678901234567890123456789012345678901 2345 6 78901 23
  */
 extern inline pte_t mk_swap_pte(unsigned long type, unsigned long offset)
 {
 	pte_t pte;
-	pte_val(pte) = (type << 1) | (offset << 12) | _PAGE_INVALID_SWAP;
-#ifndef __s390x__
-	BUG_ON((pte_val(pte) & 0x80000901) != 0);
-#else /* __s390x__ */
-	BUG_ON((pte_val(pte) & 0x901) != 0);
-#endif /* __s390x__ */
+	pte_val(pte) = _PAGE_INVALID_SWAP | ((type & 0x1f) << 2) |
+		((offset & 1) << 7) | ((offset & 0xffffe) << 11);
 	return pte;
 }
 
-#define __swp_type(entry)	(((entry).val >> 1) & 0x3f)
-#define __swp_offset(entry)	((entry).val >> 12)
+#define __swp_type(entry)	(((entry).val >> 2) & 0x1f)
+#define __swp_offset(entry)	(((entry).val >> 11) | (((entry).val >> 7) & 1))
 #define __swp_entry(type,offset) ((swp_entry_t) { pte_val(mk_swap_pte((type),(offset))) })
 
 #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
diff -urN linux-2.6/mm/swapfile.c linux-2.6-swp/mm/swapfile.c
--- linux-2.6/mm/swapfile.c	Thu Mar 25 09:58:15 2004
+++ linux-2.6-swp/mm/swapfile.c	Thu Mar 25 13:00:47 2004
@@ -1242,7 +1242,19 @@
 		if (!(p->flags & SWP_USED))
 			break;
 	error = -EPERM;
-	if (type >= MAX_SWAPFILES) {
+	/*
+	 * Test if adding another swap device is possible. There are
+	 * two limiting factors: 1) the number of bits for the swap
+	 * type swp_entry_t definition and 2) the number of bits for
+	 * the swap type in the swap ptes as defined by the different
+	 * architectures. To honor both limitations a swap entry
+	 * with swap offset 0 and swap type ~0UL is created, encoded
+	 * to a swap pte, decoded to a swp_entry_t again and finally
+	 * the swap type part is extracted. This will mask all bits
+	 * from the initial ~0UL that can't be encoded in either the
+	 * swp_entry_t or the architecture definition of a swap pte.
+	 */
+	if (type > swp_type(pte_to_swp_entry(swp_entry_to_pte(swp_entry(~0UL,0))))) {
 		swap_list_unlock();
 		goto out;
 	}
@@ -1364,7 +1376,21 @@
 		}
 
 		p->lowest_bit  = 1;
-		maxpages = swp_offset(swp_entry(0,~0UL)) - 1;
+		/*
+		 * Find out how many pages are allowed for a single swap
+		 * device. There are two limiting factors: 1) the number of
+		 * bits for the swap offset in the swp_entry_t type and
+		 * 2) the number of bits in the a swap pte as defined by
+		 * the different architectures. In order to find the
+		 * largest possible bit mask a swap entry with swap type 0
+		 * and swap offset ~0UL is created, encoded to a swap pte,
+		 * decoded to a swp_entry_t again and finally the swap
+		 * offset is extracted. This will mask all the bits from
+		 * the initial ~0UL mask that can't be encoded in either
+		 * the swp_entry_t or the architecture definition of a 
+		 * swap pte.
+		 */
+		maxpages = swp_offset(pte_to_swp_entry(swp_entry_to_pte(swp_entry(0,~0UL)))) - 1;
 		if (maxpages > swap_header->info.last_page)
 			maxpages = swap_header->info.last_page;
 		p->highest_bit = maxpages - 1;
