Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:64134 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422663AbaE3UML (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 30 May 2014 16:12:11 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: [RFC 24/32] hfs, hfsplus: convert to struct inode_time
Date: Fri, 30 May 2014 22:01:48 +0200
Message-ID: <1401480116-1973111-25-git-send-email-arnd@arndb.de>
In-Reply-To: <1401480116-1973111-1-git-send-email-arnd@arndb.de>
References: <1401480116-1973111-1-git-send-email-arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, joseph@codesourcery.com, john.stultz@linaro.org, hch@infradead.org, tglx@linutronix.de, geert@linux-m68k.org, lftan@altera.com, hpa@zytor.com, linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20140530200148.-bCGDtPXIzGTshGstcDtPHYqLsNxcIkQ8qCCPf6DXGc@z>

hfs uses 32-bit integers based at 1904 for inode timestamps, which will
only work until 2040, but the VFS uses struct timespec for timestamps,
which expires even earlier in 2038 on 32-bit CPUs.

This gets us one small step closer to lifting the VFS limit by using
struct inode_time in logfs.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/hfs/hfs_fs.h         | 2 +-
 fs/hfsplus/hfsplus_fs.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
index 0524cda..1a449b6 100644
--- a/fs/hfs/hfs_fs.h
+++ b/fs/hfs/hfs_fs.h
@@ -257,7 +257,7 @@ extern struct timezone sys_tz;
 #define HFS_I(inode)	(list_entry(inode, struct hfs_inode_info, vfs_inode))
 #define HFS_SB(sb)	((struct hfs_sb_info *)(sb)->s_fs_info)
 
-#define hfs_m_to_utime(time)	(struct timespec){ .tv_sec = __hfs_m_to_utime(time) }
+#define hfs_m_to_utime(time)	(struct inode_time){ .tv_sec = __hfs_m_to_utime(time) }
 #define hfs_u_to_mtime(time)	__hfs_u_to_mtime((time).tv_sec)
 #define hfs_mtime()		__hfs_u_to_mtime(get_seconds())
 
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 8b35648..dd9e642 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -522,7 +522,7 @@ int hfsplus_submit_bio(struct super_block *sb, sector_t sector,
 #define __hfsp_ut2mt(t)		(cpu_to_be32(t + 2082844800U))
 
 /* compatibility */
-#define hfsp_mt2ut(t)		(struct timespec){ .tv_sec = __hfsp_mt2ut(t) }
+#define hfsp_mt2ut(t)		(struct inode_time){ .tv_sec = __hfsp_mt2ut(t) }
 #define hfsp_ut2mt(t)		__hfsp_ut2mt((t).tv_sec)
 #define hfsp_now2mt()		__hfsp_ut2mt(get_seconds())
 
-- 
1.8.3.2

