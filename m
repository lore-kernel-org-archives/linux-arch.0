Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52422 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753556Ab1AVNOo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 22 Jan 2011 08:14:44 -0500
From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH v5 20/27] reiserfs: use little-endian bitops
Date: Sat, 22 Jan 2011 22:13:52 +0900
Message-ID: <1295702039-23186-21-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1295702039-23186-1-git-send-email-akinobu.mita@gmail.com>
References: <1295702039-23186-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>
Message-ID: <20110122131352.20UsDiO7BQnvVEq3p2PHiATzohcYrtD0bLdj-HwC6r8@z>

As a preparation for removing ext2 non-atomic bit operations from
asm/bitops.h.  This converts ext2 non-atomic bit operations to
little-endian bit operations.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

Change from v4:
 - remove casts to "unsigned long *" due to le-bitops prototype change

The whole series is available in the git branch at:
 git://git.kernel.org/pub/scm/linux/kernel/git/mita/linux-2.6.git le-bitops-v5

 include/linux/reiserfs_fs.h |   27 +++++++++++++--------------
 1 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/include/linux/reiserfs_fs.h b/include/linux/reiserfs_fs.h
index c21072a..0a3842a 100644
--- a/include/linux/reiserfs_fs.h
+++ b/include/linux/reiserfs_fs.h
@@ -1124,15 +1124,18 @@ struct reiserfs_de_head {
 #   define aligned_address(addr)           ((void *)((long)(addr) & ~((1UL << ADDR_UNALIGNED_BITS) - 1)))
 #   define unaligned_offset(addr)          (((int)((long)(addr) & ((1 << ADDR_UNALIGNED_BITS) - 1))) << 3)
 
-#   define set_bit_unaligned(nr, addr)     ext2_set_bit((nr) + unaligned_offset(addr), aligned_address(addr))
-#   define clear_bit_unaligned(nr, addr)   ext2_clear_bit((nr) + unaligned_offset(addr), aligned_address(addr))
-#   define test_bit_unaligned(nr, addr)    ext2_test_bit((nr) + unaligned_offset(addr), aligned_address(addr))
+#   define set_bit_unaligned(nr, addr)	\
+	__test_and_set_bit_le((nr) + unaligned_offset(addr), aligned_address(addr))
+#   define clear_bit_unaligned(nr, addr)	\
+	__test_and_clear_bit_le((nr) + unaligned_offset(addr), aligned_address(addr))
+#   define test_bit_unaligned(nr, addr)	\
+	test_bit_le((nr) + unaligned_offset(addr), aligned_address(addr))
 
 #else
 
-#   define set_bit_unaligned(nr, addr)     ext2_set_bit(nr, addr)
-#   define clear_bit_unaligned(nr, addr)   ext2_clear_bit(nr, addr)
-#   define test_bit_unaligned(nr, addr)    ext2_test_bit(nr, addr)
+#   define set_bit_unaligned(nr, addr)	__test_and_set_bit_le(nr, addr)
+#   define clear_bit_unaligned(nr, addr)	__test_and_clear_bit_le(nr, addr)
+#   define test_bit_unaligned(nr, addr)	test_bit_le(nr, addr)
 
 #endif
 
@@ -2329,14 +2332,10 @@ __u32 keyed_hash(const signed char *msg, int len);
 __u32 yura_hash(const signed char *msg, int len);
 __u32 r5_hash(const signed char *msg, int len);
 
-/* the ext2 bit routines adjust for big or little endian as
-** appropriate for the arch, so in our laziness we use them rather
-** than using the bit routines they call more directly.  These
-** routines must be used when changing on disk bitmaps.  */
-#define reiserfs_test_and_set_le_bit   ext2_set_bit
-#define reiserfs_test_and_clear_le_bit ext2_clear_bit
-#define reiserfs_test_le_bit           ext2_test_bit
-#define reiserfs_find_next_zero_le_bit ext2_find_next_zero_bit
+#define reiserfs_test_and_set_le_bit	__test_and_set_bit_le
+#define reiserfs_test_and_clear_le_bit	__test_and_clear_bit_le
+#define reiserfs_test_le_bit		test_bit_le
+#define reiserfs_find_next_zero_le_bit	find_next_zero_bit_le
 
 /* sometimes reiserfs_truncate may require to allocate few new blocks
    to perform indirect2direct conversion. People probably used to
-- 
1.7.3.4

