Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48175 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757553Ab0JUOok (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 21 Oct 2010 10:44:40 -0400
From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH v2 16/22] udf: use little-endian bitops
Date: Thu, 21 Oct 2010 23:41:11 +0900
Message-ID: <1287672077-5797-17-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1287672077-5797-1-git-send-email-akinobu.mita@gmail.com>
References: <1287672077-5797-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Akinobu Mita <akinobu.mita@gmail.com>
Message-ID: <20101021144111.fUe3fuS41teHJ26kzjSX0GGjfVw_1uAIT7M7-c7sGbA@z>

As a preparation for removing ext2 non-atomic bit operations from
asm/bitops.h. This converts ext2 non-atomic bit operations to
little-endian bit operations.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Acked-by: Jan Kara <jack@suse.cz>
---
No change from previous submission

 fs/udf/balloc.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/udf/balloc.c b/fs/udf/balloc.c
index b608efa..e55aff9 100644
--- a/fs/udf/balloc.c
+++ b/fs/udf/balloc.c
@@ -27,11 +27,14 @@
 #include "udf_i.h"
 #include "udf_sb.h"
 
-#define udf_clear_bit(nr, addr) ext2_clear_bit(nr, addr)
-#define udf_set_bit(nr, addr) ext2_set_bit(nr, addr)
-#define udf_test_bit(nr, addr) ext2_test_bit(nr, addr)
+#define udf_clear_bit(nr, addr)	\
+	__test_and_clear_le_bit(nr, (unsigned long *)(addr))
+#define udf_set_bit(nr, addr)	\
+	__test_and_set_le_bit(nr, (unsigned long *)(addr))
+#define udf_test_bit(nr, addr)	\
+	test_le_bit(nr, (unsigned long *)(addr))
 #define udf_find_next_one_bit(addr, size, offset) \
-		ext2_find_next_bit(addr, size, offset)
+	find_next_le_bit((unsigned long *)(addr), size, offset)
 
 static int read_block_bitmap(struct super_block *sb,
 			     struct udf_bitmap *bitmap, unsigned int block,
-- 
1.7.1.231.gd0b16

