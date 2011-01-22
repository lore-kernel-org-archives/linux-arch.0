From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH v5 17/27] ext4: use little-endian bitops
Date: Sat, 22 Jan 2011 22:13:49 +0900
Message-ID: <1295702039-23186-18-git-send-email-akinobu.mita@gmail.com>
References: <1295702039-23186-1-git-send-email-akinobu.mita@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1295702039-23186-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>, Andreas Dilger <adilger.kernel@dilger.ca>, Theodore Ts'o <tytso@mit.edu>
List-Id: linux-arch.vger.kernel.org

As a preparation for removing ext2 non-atomic bit operations from
asm/bitops.h.  This converts ext2 non-atomic bit operations to
little-endian bit operations.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Acked-by: "Theodore Ts'o" <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

Change from v4:
 - remove casts to "unsigned long *" due to le-bitops prototype change

The whole series is available in the git branch at:
 git://git.kernel.org/pub/scm/linux/kernel/git/mita/linux-2.6.git le-bitops-v5

 fs/ext4/ext4.h |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 0c8d97b..ab28816 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -922,14 +922,14 @@ struct ext4_inode_info {
 #define test_opt2(sb, opt)		(EXT4_SB(sb)->s_mount_opt2 & \
 					 EXT4_MOUNT2_##opt)
 
-#define ext4_set_bit			ext2_set_bit
+#define ext4_set_bit			__test_and_set_bit_le
 #define ext4_set_bit_atomic		ext2_set_bit_atomic
-#define ext4_clear_bit			ext2_clear_bit
+#define ext4_clear_bit			__test_and_clear_bit_le
 #define ext4_clear_bit_atomic		ext2_clear_bit_atomic
-#define ext4_test_bit			ext2_test_bit
-#define ext4_find_first_zero_bit	ext2_find_first_zero_bit
-#define ext4_find_next_zero_bit		ext2_find_next_zero_bit
-#define ext4_find_next_bit		ext2_find_next_bit
+#define ext4_test_bit			test_bit_le
+#define ext4_find_first_zero_bit	find_first_zero_bit_le
+#define ext4_find_next_zero_bit		find_next_zero_bit_le
+#define ext4_find_next_bit		find_next_bit_le
 
 /*
  * Maximal mount counts between two filesystem checks
-- 
1.7.3.4
