From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH 32/37] reiserfs: use get/put_endian helpers
Date: Thu, 29 May 2008 13:19:05 -0700
Message-ID: <1212092345.28403.134.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.177]:65440 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754584AbYE2UTI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 29 May 2008 16:19:08 -0400
Received: by ik-out-1112.google.com with SMTP id c28so1839904ika.5
        for <linux-arch@vger.kernel.org>; Thu, 29 May 2008 13:19:07 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch <linux-arch@vger.kernel.org>

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 fs/reiserfs/super.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
index ed424d7..e1861b4 100644
--- a/fs/reiserfs/super.c
+++ b/fs/reiserfs/super.c
@@ -221,7 +221,7 @@ static int finish_unfinished(struct super_block *s)
 
 		/* reiserfs_iget needs k_dirid and k_objectid only */
 		item = B_I_PITEM(bh, ih);
-		obj_key.on_disk_key.k_dir_id = le32_to_cpu(*(__le32 *) item);
+		obj_key.on_disk_key.k_dir_id = get_le32((__le32 *)item);
 		obj_key.on_disk_key.k_objectid =
 		    le32_to_cpu(ih->ih_key.k_objectid);
 		obj_key.on_disk_key.k_offset = 0;
-- 
1.5.6.rc0.277.g804cf
