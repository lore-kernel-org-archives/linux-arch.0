From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH v5 23/27] md: use little-endian bitops
Date: Sat, 22 Jan 2011 22:13:55 +0900
Message-ID: <1295702039-23186-24-git-send-email-akinobu.mita@gmail.com>
References: <1295702039-23186-1-git-send-email-akinobu.mita@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1295702039-23186-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>, NeilBrown <neilb@suse.de>
List-Id: linux-arch.vger.kernel.org

As a preparation for removing ext2 non-atomic bit operations from
asm/bitops.h.  This converts ext2 non-atomic bit operations to
little-endian bit operations.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Acked-by: NeilBrown <neilb@suse.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

Change from v4:
 - no changes

The whole series is available in the git branch at:
 git://git.kernel.org/pub/scm/linux/kernel/git/mita/linux-2.6.git le-bitops-v5

 drivers/md/bitmap.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/md/bitmap.c b/drivers/md/bitmap.c
index 9a35320..a2ce0b2 100644
--- a/drivers/md/bitmap.c
+++ b/drivers/md/bitmap.c
@@ -854,7 +854,7 @@ static void bitmap_file_set_bit(struct bitmap *bitmap, sector_t block)
 		if (bitmap->flags & BITMAP_HOSTENDIAN)
 			set_bit(bit, kaddr);
 		else
-			ext2_set_bit(bit, kaddr);
+			__test_and_set_bit_le(bit, kaddr);
 		kunmap_atomic(kaddr, KM_USER0);
 		PRINTK("set file bit %lu page %lu\n", bit, page->index);
 	}
@@ -1050,7 +1050,7 @@ static int bitmap_init_from_disk(struct bitmap *bitmap, sector_t start)
 		if (bitmap->flags & BITMAP_HOSTENDIAN)
 			b = test_bit(bit, paddr);
 		else
-			b = ext2_test_bit(bit, paddr);
+			b = test_bit_le(bit, paddr);
 		kunmap_atomic(paddr, KM_USER0);
 		if (b) {
 			/* if the disk bit is set, set the memory bit */
@@ -1226,7 +1226,7 @@ void bitmap_daemon_work(mddev_t *mddev)
 						clear_bit(file_page_offset(bitmap, j),
 							  paddr);
 					else
-						ext2_clear_bit(file_page_offset(bitmap, j),
+						__test_and_clear_bit_le(file_page_offset(bitmap, j),
 							       paddr);
 					kunmap_atomic(paddr, KM_USER0);
 				} else
-- 
1.7.3.4
