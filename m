From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH 34/37] xfs: use get/put_endian helpers
Date: Thu, 29 May 2008 13:19:10 -0700
Message-ID: <1212092350.28403.136.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:43494 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754930AbYE2UTL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 29 May 2008 16:19:11 -0400
Received: by yx-out-2324.google.com with SMTP id 31so392319yxl.1
        for <linux-arch@vger.kernel.org>; Thu, 29 May 2008 13:19:11 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-arch <linux-arch@vger.kernel.org>, David Chinner <dgc@sgi.com>

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 fs/xfs/xfs_mount.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index da39884..c301505 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -488,16 +488,16 @@ xfs_sb_to_disk(
 		} else {
 			switch (size) {
 			case 2:
-				*(__be16 *)(to_ptr + first) =
-					cpu_to_be16(*(__u16 *)(from_ptr + first));
+				put_be16(*(u16 *)(from_ptr + first),
+					 (__be16 *)(to_ptr + first));
 				break;
 			case 4:
-				*(__be32 *)(to_ptr + first) =
-					cpu_to_be32(*(__u32 *)(from_ptr + first));
+				put_be32(*(u32 *)(from_ptr + first),
+					 (__be32 *)(to_ptr + first));
 				break;
 			case 8:
-				*(__be64 *)(to_ptr + first) =
-					cpu_to_be64(*(__u64 *)(from_ptr + first));
+				put_be64(*(u64 *)(from_ptr + first),
+					 (__be64 *)(to_ptr + first));
 				break;
 			default:
 				ASSERT(0);
-- 
1.5.6.rc0.277.g804cf
