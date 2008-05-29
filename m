From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH 28/37] isofs: use get/put_endian helpers
Date: Thu, 29 May 2008 13:18:57 -0700
Message-ID: <1212092337.28403.130.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.175]:43046 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754225AbYE2UTA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 29 May 2008 16:19:00 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3083458wfd.4
        for <linux-arch@vger.kernel.org>; Thu, 29 May 2008 13:19:00 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch <linux-arch@vger.kernel.org>

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 fs/isofs/compress.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/isofs/compress.c b/fs/isofs/compress.c
index defb932..4512e4b 100644
--- a/fs/isofs/compress.c
+++ b/fs/isofs/compress.c
@@ -124,7 +124,7 @@ static int zisofs_readpage(struct file *file, struct page *page)
 			brelse(ptrbh[1]);
 		goto eio;
 	}
-	cstart = le32_to_cpu(*(__le32 *)(bh->b_data + (blockptr & bufmask)));
+	cstart = get_le32((__le32 *)(bh->b_data + (blockptr & bufmask)));
 
 	if ( indexblocks == 2 ) {
 		/* We just crossed a block boundary.  Switch to the next block */
@@ -136,7 +136,7 @@ static int zisofs_readpage(struct file *file, struct page *page)
 			goto eio;
 		}
 	}
-	cend = le32_to_cpu(*(__le32 *)(bh->b_data + (blockendptr & bufmask)));
+	cend = get_le32((__le32 *)(bh->b_data + (blockendptr & bufmask)));
 	brelse(bh);
 
 	if (cstart > cend)
-- 
1.5.6.rc0.277.g804cf
