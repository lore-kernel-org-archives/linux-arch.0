From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH 13/37] md: use get/put_endian helpers
Date: Thu, 29 May 2008 13:18:23 -0700
Message-ID: <1212092303.28403.115.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.174]:41560 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758048AbYE2USZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 29 May 2008 16:18:25 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3083442wfd.4
        for <linux-arch@vger.kernel.org>; Thu, 29 May 2008 13:18:24 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch <linux-arch@vger.kernel.org>

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 drivers/md/md.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 51c19f8..ce19588 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -1022,7 +1022,7 @@ static __le32 calc_sb_1_csum(struct mdp_superblock_1 * sb)
 		newcsum += le32_to_cpu(*isuper++);
 
 	if (size == 2)
-		newcsum += le16_to_cpu(*(__le16*) isuper);
+		newcsum += get_le16((__le16 *)isuper);
 
 	csum = (newcsum & 0xffffffff) + (newcsum >> 32);
 	sb->sb_csum = disk_csum;
-- 
1.5.6.rc0.277.g804cf
