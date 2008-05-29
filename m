From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH 24/37] ext3: use get/put_endian helpers
Date: Thu, 29 May 2008 13:18:48 -0700
Message-ID: <1212092328.28403.126.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.175]:43046 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754127AbYE2USu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 29 May 2008 16:18:50 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3083458wfd.4
        for <linux-arch@vger.kernel.org>; Thu, 29 May 2008 13:18:50 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, ext-devel <linux-ext4@vger.kernel.org>, "Stephen C. Tweedie" <sct@redhat.com>

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 fs/ext3/super.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext3/super.c b/fs/ext3/super.c
index fe3119a..23804d7 100644
--- a/fs/ext3/super.c
+++ b/fs/ext3/super.c
@@ -2595,8 +2595,8 @@ static int ext3_statfs (struct dentry * dentry, struct kstatfs * buf)
 	buf->f_ffree = percpu_counter_sum_positive(&sbi->s_freeinodes_counter);
 	es->s_free_inodes_count = cpu_to_le32(buf->f_ffree);
 	buf->f_namelen = EXT3_NAME_LEN;
-	fsid = le64_to_cpup((void *)es->s_uuid) ^
-	       le64_to_cpup((void *)es->s_uuid + sizeof(u64));
+	fsid = get_le64((void *)es->s_uuid) ^
+	       get_le64((void *)es->s_uuid + sizeof(__le64));
 	buf->f_fsid.val[0] = fsid & 0xFFFFFFFFUL;
 	buf->f_fsid.val[1] = (fsid >> 32) & 0xFFFFFFFFUL;
 	return 0;
-- 
1.5.6.rc0.277.g804cf
