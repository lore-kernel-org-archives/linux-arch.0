Return-Path: <sky@de.ibm.com>
Received: from mtagate7.de.ibm.com ([195.212.29.156]:60590 "EHLO
	mtagate7.de.ibm.com") by vger.kernel.org with ESMTP id S263802AbUCXSKr
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 24 Mar 2004 13:10:47 -0500
Received: from d12relay01.megacenter.de.ibm.com (d12relay01.megacenter.de.ibm.com [9.149.165.180])
	by mtagate7.de.ibm.com (8.12.10/8.12.10) with ESMTP id i2OIAev4046800
	for <linux-arch@vger.kernel.org>; Wed, 24 Mar 2004 18:10:43 GMT
Received: from mschwid3.boeblingen.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12relay01.megacenter.de.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id i2OI9kso279468
	for <linux-arch@vger.kernel.org>; Wed, 24 Mar 2004 19:09:46 +0100
Received: from sky by mschwid3.boeblingen.de.ibm.com with local (Exim 3.36 #1 (Debian))
	id 1B6Cot-0000gZ-00
	for <linux-arch@vger.kernel.org>; Wed, 24 Mar 2004 19:09:39 +0100
Date: Wed, 24 Mar 2004 19:09:39 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH] swp_entry_t vs. swap pte.
Message-ID: <20040324180939.GA2599@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Hi,
I got a bug report for s390 with an oops in mk_swap_pte which has
its cause in the arch-independent swap entries vs. the pte coded
swap entries. The swp_entry_t uses 27 bits for the offset and 5
bits for the type. In sys_swapon this definition is used to find
out how many pages there can be at maximum:

---
                p->lowest_bit  = 1;
                maxpages = swp_offset(swp_entry(0,~0UL)))) - 1;
                if (maxpages > swap_header->info.last_page)
                        maxpages = swap_header->info.last_page;
---

maxpages always is 0x7fffff for 32 bit and 0x7ffffffffffffff for
64 bit. This is kind of suboptimal because the architecture may
be more restrictive on the number of bits in the offset.
The current situation is:

           offset type max swap
	   bits   bits size
alpha       24     5    64 GB
arm         23     7    32 GB
cris        20     7     4 GB
h8300       ??     ?     ?
i386        24     5    64 GB
ia64        54     7     big
m68k        20     8     4 GB
mips-32     20     7     4 GB
mips-64     24     8    64 GB
parisc      24     5    64 GB
ppc         24     5    64 GB
ppc64       48?    6     big
s390-32     19     6     2 GB
s390-64     52     6     big
sh          22     8    16 GB
sparc-32    19     7     2 GB
sparc-64    43     8     big
v850        ??     ?     ?
x86_64      40?    6     big

In my case the swap device had 2.5 GB, mkswap happily created a
swap file of that size. sys_swapon didn't object either but the
first try to create a swap entry for a page with an offset > 7ffff
crashed the machine. The same will happen on i386 with a swap
device > 64 GB.

I created a patch that should fix the problem. It uses 

  swp_type(pte_to_swp_entry(swp_entry_to_pte(swp_entry(~0UL,0))))

to find the highest possible swap type number and

  swp_offset(pte_to_swp_entry(swp_entry_to_pte(swp_entry(0,~0UL))))

to find the highest possible swap offset. This should work with the
existing __swp_entry/__swp_type/__swp_offset definitions for all
architectures except for s390 because I've added a BUG_ON in
__swp_entry if the created swap pte is dubious.  Oh, well.

By the way there is room for improvement for some architectures to
increase the maximum size of a single swap device by using some of
the bits currently used for the type. The architecture independent
swp_entry_t limits the number of swap files to 32 anyway so there
is not use for more than 5 type bits. While I was at it I did this
change for s390.

See patch against 2.6.5-rc2-mm2 @EOM.

blue skies,
  Martin.


diff -urN linux-2.6/include/asm-s390/pgtable.h linux-2.6-swp/include/asm-s390/pgtable.h
--- linux-2.6/include/asm-s390/pgtable.h	Wed Mar 24 18:26:50 2004
+++ linux-2.6-swp/include/asm-s390/pgtable.h	Wed Mar 24 18:27:27 2004
@@ -744,11 +744,11 @@
  * Bit 30 and 31 are used to distinguish the different page types. For
  * a swapped page these bits need to be zero.
  * This leaves the bits 1-19 and bits 24-29 to store type and offset.
- * We use the 6 bits from 24-29 for the type and the 19 bits from 1-19
- * for the offset.
- * 0|     offset        |0110| type |00|
- * 0 0000000001111111111 2222 222222 33
- * 0 1234567890123456789 0123 456789 01
+ * We use the 5 bits from 25-29 for the type and the 20 bits from 1-19
+ * plus 24 for the offset.
+ * 0|     offset        |0110|o|type |00|
+ * 0 0000000001111111111 2222 2 22222 33
+ * 0 1234567890123456789 0123 4 56789 01
  *
  * 64 bit swap entry format:
  * A page-table entry has some bits we have to treat in a special way.
@@ -761,26 +761,22 @@
  * Bit 62 and 63 are used to distinguish the different page types. For
  * a swapped page these bits need to be zero.
  * This leaves the bits 0-51 and bits 56-61 to store type and offset.
- * We use the 6 bits from 56-61 for the type and the 52 bits from 0-51
- * for the offset.
- * |                      offset                        |0110| type |00|
- *  0000000000111111111122222222223333333333444444444455 5555 555566 66
- *  0123456789012345678901234567890123456789012345678901 2345 678901 23
+ * We use the 5 bits from 57-61 for the type and the 53 bits from 0-51
+ * plus 56 for the offset.
+ * |                      offset                        |0110|o|type |00|
+ *  0000000000111111111122222222223333333333444444444455 5555 5 55566 66
+ *  0123456789012345678901234567890123456789012345678901 2345 6 78901 23
  */
 extern inline pte_t mk_swap_pte(unsigned long type, unsigned long offset)
 {
 	pte_t pte;
-	pte_val(pte) = (type << 2) | (offset << 12) | _PAGE_INVALID_SWAP;
-#ifndef __s390x__
-	BUG_ON((pte_val(pte) & 0x80000901) != 0);
-#else /* __s390x__ */
-	BUG_ON((pte_val(pte) & 0x901) != 0);
-#endif /* __s390x__ */
+	pte_val(pte) = _PAGE_INVALID_SWAP | ((type & 0x1f) << 2) |
+		((offset & 1) << 7) | ((offset & 0xffffe) << 11);
 	return pte;
 }
 
-#define __swp_type(entry)	(((entry).val >> 2) & 0x3f)
-#define __swp_offset(entry)	((entry).val >> 12)
+#define __swp_type(entry)	(((entry).val >> 2) & 0x1f)
+#define __swp_offset(entry)	(((entry).val >> 11) | (((entry).val >> 7) & 1))
 #define __swp_entry(type,offset) ((swp_entry_t) { pte_val(mk_swap_pte((type),(offset))) })
 
 #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
diff -urN linux-2.6/mm/swapfile.c linux-2.6-swp/mm/swapfile.c
--- linux-2.6/mm/swapfile.c	Wed Mar 24 18:26:50 2004
+++ linux-2.6-swp/mm/swapfile.c	Wed Mar 24 18:29:37 2004
@@ -1302,7 +1302,7 @@
 		if (!(p->flags & SWP_USED))
 			break;
 	error = -EPERM;
-	if (type >= MAX_SWAPFILES) {
+	if (type > swp_type(pte_to_swp_entry(swp_entry_to_pte(swp_entry(~0UL,0))))) {
 		swap_list_unlock();
 		goto out;
 	}
@@ -1424,7 +1424,7 @@
 		}
 
 		p->lowest_bit  = 1;
-		maxpages = swp_offset(swp_entry(0,~0UL)) - 1;
+		maxpages = swp_offset(pte_to_swp_entry(swp_entry_to_pte(swp_entry(0,~0UL)))) - 1;
 		if (maxpages > swap_header->info.last_page)
 			maxpages = swap_header->info.last_page;
 		p->highest_bit = maxpages - 1;
