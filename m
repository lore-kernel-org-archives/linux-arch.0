Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BAA376A05
	for <linux-arch@vger.kernel.org>; Sun, 31 May 2026 10:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780224675; cv=none; b=Nn6YQBpZynZU2O0+5NpCRUU4U70R/Li1YKCsj+dyBMKZEB51vSFvPlK8UB7qDmdkNavXRVZobV7uYZeUWFkOht4ERMR0eC2UipkF8gHMwH5S9sPrGyIAy2Gxe7ZADNepNJ16CdghQJ0CT28aLkFHvld7LIeP+LI8zujbtfW6yd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780224675; c=relaxed/simple;
	bh=FxJnp3fP2gkUp/V+gOLJJLxq+QirZlnYfCNWgHLCKXY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nldE5eA+t1rurRUPUs77YiYDQY9kFohNIB9aVc9GGhgtKSAecIhYX73YxiFS1GkbmMkYb3Mfsy30sU9SzbuDyQBAOg4besg4G22vzSevtUfbpiOmYJU/oR1XL13rgHis/w6LK3KKx1e8mdl6TmPlSvRrEDbOz0nsxk/vZ325yZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=RLX54AVb; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="RLX54AVb"
X-KPN-MessageId: 79471492-5cde-11f1-b189-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 79471492-5cde-11f1-b189-005056abad63;
	Sun, 31 May 2026 12:50:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=qtMrApNK11E5SdH2mxy9wa8qTyEySOTtUGAck0wYngs=;
	b=RLX54AVbXCZ3Q5opUYEl7aai2rmIuPHJSplBBAsVqTjTjRyfpOAYaKcOTf7FN1sSABiVlfWSsv0mL
	 SH88RL0iGnnpLwpCEEewzijcCcF2rdoanAKZYFO67KUSmK67WU6m+cWpDBzU+1YyTSm6TBkzsVsLys
	 mqaoXLqptxqBnxxvd7nGd3JilqeeuRp4G1QOpqEf3oe3jHLut0kS8s4KQ/gkAQH48aOMXjvSEfx8IC
	 4ueSPZDw9y5LPUtW8cupiiIuI63AaQ6+3gqGsk9yl++cRoM24qjCo4HUxJnJZ+s7q9pZhpci3KMbya
	 cqkqMVGDU2hzpPB1Peecdhr2w/FXvQg==
X-KPN-MID: 33|ajMjjDomOLTK4FuCXPc36Ua8oZEjGDCfcgm+akWqk5lzLZteGCHUqdEH9jD5Zb8
 oxZ3+9+mEiCC66WylLAWycDoneBsPnR6v9KKOA4i93Zo=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|h9t0ZqmNU/Swe4ogKLI4fl5Yqi85+YQD7eo7uc8dpCFSBVk7nyKR7qa0pV5Fl5l
 jUfAWgB5J7zUv300IXKj5KQ==
Received: from lt-jori.home (unknown [178.226.150.234])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 75f0633f-5cde-11f1-8011-005056ab7447;
	Sun, 31 May 2026 12:50:01 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>,
	linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and infrastructure)),
	linux-kernel@vger.kernel.org (open list),
	linux-arch@vger.kernel.org (open list:GENERIC INCLUDE/ASM HEADER FILES)
Subject: [PATCH] vfs: missing inode operation should return a consistent error code
Date: Sun, 31 May 2026 12:49:46 +0200
Message-ID: <20260531104947.6142-1-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently several different error codes are used in the VFS for
situations where the underlying filesystem does not support the
requested inode operation (such as mkdir, tmpfile, create, etc.)
Examples: create returns EACCES, mkdir EPERM, tmpfile EOPNOTSUPP,
fileattr_get ENOIOCTLCMD.

We should provide a sensible unified error code for these situations.
EOPNOTSUPP is already used for this both in the kernel (when lacking
tmpfile support) and in userland (e.g. glibc).[1] Restricting EOPNOTSUPP
to socket operations as POSIX suggests is not the current reality and
this was recently changed in the man page as well.[2]

vfs_fileattr_get|set return ENOIOCTLCMD, but this cannot be changed
since EOPNOTSUPP is already used to by underlying filesystems to indicate
that a flag is not supported. The change to EOPNOTSUPP was reverted by
4dd5b5ac089b ("Revert "fs: make vfs_fileattr_[get|set] return
-EOPNOTSUPP"")

[1]: https://lore.kernel.org/all/20260528-abnimmt-befreien-perspektive-a7930659fb40@brauner/
[2]: https://lore.kernel.org/linux-fsdevel/ahd3SmZZqnzP0-O2@devuan/T/#t

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/namei.c                       | 18 +++++++++---------
 include/uapi/asm-generic/errno.h |  2 +-
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index c7fac83c9a85..813419c340ad 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4192,7 +4192,7 @@ int vfs_create(struct mnt_idmap *idmap, struct dentry *dentry, umode_t mode,
 		return error;
 
 	if (!dir->i_op->create)
-		return -EACCES;	/* shouldn't it be ENOSYS? */
+		return -EOPNOTSUPP;
 
 	mode = vfs_prepare_mode(idmap, dir, mode, S_IALLUGO, S_IFREG);
 	error = security_inode_create(dir, dentry, mode);
@@ -4504,7 +4504,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		file->f_mode |= FMODE_CREATED;
 		audit_inode_child(dir_inode, dentry, AUDIT_TYPE_CHILD_CREATE);
 		if (!dir_inode->i_op->create) {
-			error = -EACCES;
+			error = -EOPNOTSUPP;
 			goto out_dput;
 		}
 
@@ -5102,7 +5102,7 @@ int vfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 		return -EPERM;
 
 	if (!dir->i_op->mknod)
-		return -EPERM;
+		return -EOPNOTSUPP;
 
 	mode = vfs_prepare_mode(idmap, dir, mode, mode, mode);
 	error = devcgroup_inode_mknod(mode, dev);
@@ -5241,7 +5241,7 @@ struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	if (error)
 		goto err;
 
-	error = -EPERM;
+	error = -EOPNOTSUPP;
 	if (!dir->i_op->mkdir)
 		goto err;
 
@@ -5345,7 +5345,7 @@ int vfs_rmdir(struct mnt_idmap *idmap, struct inode *dir,
 		return error;
 
 	if (!dir->i_op->rmdir)
-		return -EPERM;
+		return -EOPNOTSUPP;
 
 	dget(dentry);
 	inode_lock(dentry->d_inode);
@@ -5479,7 +5479,7 @@ int vfs_unlink(struct mnt_idmap *idmap, struct inode *dir,
 		return error;
 
 	if (!dir->i_op->unlink)
-		return -EPERM;
+		return -EOPNOTSUPP;
 
 	inode_lock(target);
 	if (IS_SWAPFILE(target))
@@ -5630,7 +5630,7 @@ int vfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 		return error;
 
 	if (!dir->i_op->symlink)
-		return -EPERM;
+		return -EOPNOTSUPP;
 
 	error = security_inode_symlink(dir, dentry, oldname);
 	if (error)
@@ -5752,7 +5752,7 @@ int vfs_link(struct dentry *old_dentry, struct mnt_idmap *idmap,
 	if (HAS_UNMAPPED_ID(idmap, inode))
 		return -EPERM;
 	if (!dir->i_op->link)
-		return -EPERM;
+		return -EOPNOTSUPP;
 	if (S_ISDIR(inode->i_mode))
 		return -EPERM;
 
@@ -5961,7 +5961,7 @@ int vfs_rename(struct renamedata *rd)
 		return error;
 
 	if (!old_dir->i_op->rename)
-		return -EPERM;
+		return -EOPNOTSUPP;
 
 	/*
 	 * If we are going to change the parent - check write permissions,
diff --git a/include/uapi/asm-generic/errno.h b/include/uapi/asm-generic/errno.h
index 92e7ae493ee3..7b5b71ae1b12 100644
--- a/include/uapi/asm-generic/errno.h
+++ b/include/uapi/asm-generic/errno.h
@@ -76,7 +76,7 @@
 #define	ENOPROTOOPT	92	/* Protocol not available */
 #define	EPROTONOSUPPORT	93	/* Protocol not supported */
 #define	ESOCKTNOSUPPORT	94	/* Socket type not supported */
-#define	EOPNOTSUPP	95	/* Operation not supported on transport endpoint */
+#define	EOPNOTSUPP	95	/* Operation not supported */
 #define	EPFNOSUPPORT	96	/* Protocol family not supported */
 #define	EAFNOSUPPORT	97	/* Address family not supported by protocol */
 #define	EADDRINUSE	98	/* Address already in use */

base-commit: 670b77dfebe7257adc0defbc48a4c43cfdf6c8f6
-- 
2.54.0

