Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:57002 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754405Ab0KWNkG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 23 Nov 2010 08:40:06 -0500
From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH v3 13/22] ocfs2: use little-endian bitops
Date: Tue, 23 Nov 2010 22:38:15 +0900
Message-ID: <1290519504-3958-14-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1290519504-3958-1-git-send-email-akinobu.mita@gmail.com>
References: <1290519504-3958-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Akinobu Mita <akinobu.mita@gmail.com>, Mark Fasheh <mfasheh@suse.com>, ocfs2-devel@oss.oracle.com
Message-ID: <20101123133815.YgHTWs7aQaQhEkFGOrQBs17vazJdH_R3-IIVRM-JzGQ@z>

As a preparation for removing ext2 non-atomic bit operations from
asm/bitops.h. This converts ext2 non-atomic bit operations to
little-endian bit operations.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Acked-by: Joel Becker <joel.becker@oracle.com>
Cc: Mark Fasheh <mfasheh@suse.com>
Cc: ocfs2-devel@oss.oracle.com
---
No change from previous submission
 fs/ocfs2/ocfs2.h |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/ocfs2/ocfs2.h b/fs/ocfs2/ocfs2.h
index 1efea36..685f5c5 100644
--- a/fs/ocfs2/ocfs2.h
+++ b/fs/ocfs2/ocfs2.h
@@ -826,18 +826,21 @@ static inline unsigned int ocfs2_clusters_to_megabytes(struct super_block *sb,
 
 static inline void _ocfs2_set_bit(unsigned int bit, unsigned long *bitmap)
 {
-	ext2_set_bit(bit, bitmap);
+	__test_and_set_le_bit(bit, bitmap);
 }
 #define ocfs2_set_bit(bit, addr) _ocfs2_set_bit((bit), (unsigned long *)(addr))
 
 static inline void _ocfs2_clear_bit(unsigned int bit, unsigned long *bitmap)
 {
-	ext2_clear_bit(bit, bitmap);
+	__test_and_clear_le_bit(bit, bitmap);
 }
 #define ocfs2_clear_bit(bit, addr) _ocfs2_clear_bit((bit), (unsigned long *)(addr))
 
-#define ocfs2_test_bit ext2_test_bit
-#define ocfs2_find_next_zero_bit ext2_find_next_zero_bit
-#define ocfs2_find_next_bit ext2_find_next_bit
+#define ocfs2_test_bit(nr, addr)	\
+	test_le_bit(nr, (unsigned long *)(addr))
+#define ocfs2_find_next_zero_bit(addr, size, off)	\
+	find_next_zero_le_bit((unsigned long *)(addr), size, off)
+#define ocfs2_find_next_bit(addr, size, off)	\
+	find_next_le_bit((unsigned long *)(addr), size, off)
 #endif  /* OCFS2_H */
 
-- 
1.7.3.2

