From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH 31/37] qnx4: use get/put_endian helpers
Date: Thu, 29 May 2008 13:19:03 -0700
Message-ID: <1212092343.28403.133.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:43327 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754942AbYE2UTF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 29 May 2008 16:19:05 -0400
Received: by yx-out-2324.google.com with SMTP id 31so392252yxl.1
        for <linux-arch@vger.kernel.org>; Thu, 29 May 2008 13:19:04 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch <linux-arch@vger.kernel.org>

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 fs/qnx4/inode.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
index b31ab78..c2edfce 100644
--- a/fs/qnx4/inode.c
+++ b/fs/qnx4/inode.c
@@ -372,7 +372,7 @@ static int qnx4_fill_super(struct super_block *s, void *data, int silent)
 		printk("qnx4: unable to read the superblock\n");
 		goto outnobh;
 	}
-	if ( le32_to_cpup((__le32*) bh->b_data) != QNX4_SUPER_MAGIC ) {
+	if (get_le32((__le32 *)bh->b_data) != QNX4_SUPER_MAGIC) {
 		if (!silent)
 			printk("qnx4: wrong fsid in superblock.\n");
 		goto out;
-- 
1.5.6.rc0.277.g804cf
