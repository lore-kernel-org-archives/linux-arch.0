From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH 23/37] ext2: use get/put_endian helpers
Date: Thu, 29 May 2008 13:18:46 -0700
Message-ID: <1212092326.28403.125.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:43327 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755037AbYE2USt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 29 May 2008 16:18:49 -0400
Received: by yx-out-2324.google.com with SMTP id 31so392252yxl.1
        for <linux-arch@vger.kernel.org>; Thu, 29 May 2008 13:18:49 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, ext-devel <linux-ext4@vger.kernel.org>, "Stephen C. Tweedie" <sct@redhat.com>

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 fs/ext2/super.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index ef50cbc..7002f37 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -1277,8 +1277,8 @@ static int ext2_statfs (struct dentry * dentry, struct kstatfs * buf)
 	buf->f_ffree = ext2_count_free_inodes(sb);
 	es->s_free_inodes_count = cpu_to_le32(buf->f_ffree);
 	buf->f_namelen = EXT2_NAME_LEN;
-	fsid = le64_to_cpup((void *)es->s_uuid) ^
-	       le64_to_cpup((void *)es->s_uuid + sizeof(u64));
+	fsid = get_le64((void *)es->s_uuid) ^
+	       get_le64((void *)es->s_uuid + sizeof(__le64));
 	buf->f_fsid.val[0] = fsid & 0xFFFFFFFFUL;
 	buf->f_fsid.val[1] = (fsid >> 32) & 0xFFFFFFFFUL;
 	return 0;
-- 
1.5.6.rc0.277.g804cf
