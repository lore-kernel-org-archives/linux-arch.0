Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43]:36320 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751826AbaKEVPJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 5 Nov 2014 16:15:09 -0500
Received: by mail-qg0-f43.google.com with SMTP id f51so12369qge.2
        for <linux-arch@vger.kernel.org>; Wed, 05 Nov 2014 13:15:08 -0800 (PST)
From: Milosz Tanski <milosz@adfin.com>
Subject: [PATCH v5 5/7] xfs: add RWF_NONBLOCK support
Date: Wed,  5 Nov 2014 16:14:51 -0500
Message-ID: <23798acaf272aea30908e619ff40b2b173d6e57c.1415220890.git.milosz@adfin.com>
In-Reply-To: <cover.1415220890.git.milosz@adfin.com>
References: <cover.1415220890.git.milosz@adfin.com>
In-Reply-To: <cover.1415220890.git.milosz@adfin.com>
References: <cover.1415220890.git.milosz@adfin.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, Mel Gorman <mgorman@suse.de>, Volker Lendecke <Volker.Lendecke@sernet.de>, Tejun Heo <tj@kernel.org>, Jeff Moyer <jmoyer@redhat.com>, Theodore Ts'o <tytso@mit.edu>, Al Viro <viro@zeniv.linux.org.uk>, linux-api@vger.kernel.org, Michael Kerrisk <mtk.manpages@gmail.com>, linux-arch@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <20141105211451.AmnlVIPy5VfOd3FeXyr-672GDkfW25wFtRGDLokrHeg@z>

From: Christoph Hellwig <hch@lst.de>

Add support for non-blocking reads.  The guts are handled by the generic
code, the only addition is a non-blocking variant of xfs_rw_ilock.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_file.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index b1f6334..0655915 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -61,6 +61,25 @@ xfs_rw_ilock(
 	xfs_ilock(ip, type);
 }
 
+static inline bool
+xfs_rw_ilock_nowait(
+	struct xfs_inode	*ip,
+	int			type)
+{
+	if (type & XFS_IOLOCK_EXCL) {
+		if (!mutex_trylock(&VFS_I(ip)->i_mutex))
+			return false;
+		if (!xfs_ilock_nowait(ip, type)) {
+			mutex_unlock(&VFS_I(ip)->i_mutex);
+			return false;
+		}
+	} else {
+		if (!xfs_ilock_nowait(ip, type))
+			return false;
+	}
+	return true;
+}
+
 static inline void
 xfs_rw_iunlock(
 	struct xfs_inode	*ip,
@@ -246,10 +265,6 @@ xfs_file_read_iter(
 
 	XFS_STATS_INC(xs_read_calls);
 
-	/* XXX: need a non-blocking iolock helper, shouldn't be too hard */
-	if (iocb->ki_rwflags & RWF_NONBLOCK)
-		return -EAGAIN;
-
 	if (unlikely(file->f_flags & O_DIRECT))
 		ioflags |= XFS_IO_ISDIRECT;
 	if (file->f_mode & FMODE_NOCMTIME)
@@ -287,7 +302,14 @@ xfs_file_read_iter(
 	 * This allows the normal direct IO case of no page cache pages to
 	 * proceeed concurrently without serialisation.
 	 */
-	xfs_rw_ilock(ip, XFS_IOLOCK_SHARED);
+	if (iocb->ki_rwflags & RWF_NONBLOCK) {
+		if (ioflags & XFS_IO_ISDIRECT)
+			return -EAGAIN;
+		if (!xfs_rw_ilock_nowait(ip, XFS_IOLOCK_SHARED))
+			return -EAGAIN;
+	} else {
+		xfs_rw_ilock(ip, XFS_IOLOCK_SHARED);
+	}
 	if ((ioflags & XFS_IO_ISDIRECT) && inode->i_mapping->nrpages) {
 		xfs_rw_iunlock(ip, XFS_IOLOCK_SHARED);
 		xfs_rw_ilock(ip, XFS_IOLOCK_EXCL);
-- 
1.9.1

