From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH 22/37] cifs: use get/put_endian helpers
Date: Thu, 29 May 2008 13:18:44 -0700
Message-ID: <1212092324.28403.124.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:43494 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754127AbYE2USs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 29 May 2008 16:18:48 -0400
Received: by yx-out-2324.google.com with SMTP id 31so392319yxl.1
        for <linux-arch@vger.kernel.org>; Thu, 29 May 2008 13:18:48 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, Steve French <smfrench@gmail.com>

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 fs/cifs/inode.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index 129dbfe..9a49f6c 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -314,8 +314,8 @@ static int decode_sfu_inode(struct inode *inode, __u64 size,
 					/* we have enough to decode dev num */
 					__u64 mjr; /* major */
 					__u64 mnr; /* minor */
-					mjr = le64_to_cpu(*(__le64 *)(pbuf+8));
-					mnr = le64_to_cpu(*(__le64 *)(pbuf+16));
+					mjr = get_le64((__le64 *)(pbuf + 8));
+					mnr = get_le64((__le64 *)(pbuf + 16));
 					inode->i_rdev = MKDEV(mjr, mnr);
 				}
 			} else if (memcmp("IntxCHR", pbuf, 8) == 0) {
@@ -325,8 +325,8 @@ static int decode_sfu_inode(struct inode *inode, __u64 size,
 					/* we have enough to decode dev num */
 					__u64 mjr; /* major */
 					__u64 mnr; /* minor */
-					mjr = le64_to_cpu(*(__le64 *)(pbuf+8));
-					mnr = le64_to_cpu(*(__le64 *)(pbuf+16));
+					mjr = get_le64((__le64 *)(pbuf + 8));
+					mnr = get_le64((__le64 *)(pbuf + 16));
 					inode->i_rdev = MKDEV(mjr, mnr);
 				}
 			} else if (memcmp("IntxLNK", pbuf, 7) == 0) {
-- 
1.5.6.rc0.277.g804cf
