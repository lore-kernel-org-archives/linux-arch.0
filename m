From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH 27/37] hpfs: use get/put_endian helpers
Date: Thu, 29 May 2008 13:18:55 -0700
Message-ID: <1212092335.28403.129.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.172]:44045 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754016AbYE2US4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 29 May 2008 16:18:56 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3083761wfd.4
        for <linux-arch@vger.kernel.org>; Thu, 29 May 2008 13:18:56 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch <linux-arch@vger.kernel.org>

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 fs/hpfs/inode.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/hpfs/inode.c b/fs/hpfs/inode.c
index 85d3e1d..3b963b8 100644
--- a/fs/hpfs/inode.c
+++ b/fs/hpfs/inode.c
@@ -60,14 +60,14 @@ void hpfs_read_inode(struct inode *i)
 	if (hpfs_sb(i->i_sb)->sb_eas) {
 		if ((ea = hpfs_get_ea(i->i_sb, fnode, "UID", &ea_size))) {
 			if (ea_size == 2) {
-				i->i_uid = le16_to_cpu(*(__le16*)ea);
+				i->i_uid = get_le16((__le16 *)ea);
 				hpfs_inode->i_ea_uid = 1;
 			}
 			kfree(ea);
 		}
 		if ((ea = hpfs_get_ea(i->i_sb, fnode, "GID", &ea_size))) {
 			if (ea_size == 2) {
-				i->i_gid = le16_to_cpu(*(__le16*)ea);
+				i->i_gid = get_le16((__le16 *)ea);
 				hpfs_inode->i_ea_gid = 1;
 			}
 			kfree(ea);
@@ -87,7 +87,7 @@ void hpfs_read_inode(struct inode *i)
 			int rdev = 0;
 			umode_t mode = hpfs_sb(sb)->sb_mode;
 			if (ea_size == 2) {
-				mode = le16_to_cpu(*(__le16*)ea);
+				mode = get_le16((__le16 *)ea);
 				hpfs_inode->i_ea_mode = 1;
 			}
 			kfree(ea);
@@ -95,7 +95,7 @@ void hpfs_read_inode(struct inode *i)
 			if (S_ISBLK(mode) || S_ISCHR(mode)) {
 				if ((ea = hpfs_get_ea(i->i_sb, fnode, "DEV", &ea_size))) {
 					if (ea_size == 4)
-						rdev = le32_to_cpu(*(__le32*)ea);
+						rdev = get_le32((__le32 *)ea);
 					kfree(ea);
 				}
 			}
-- 
1.5.6.rc0.277.g804cf
