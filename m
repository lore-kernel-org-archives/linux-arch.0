Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:46058 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754077AbZDCAER (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 2 Apr 2009 20:04:17 -0400
Message-ID: <200904022359.n32NxMTu022789@imap1.linux-foundation.org>
Subject: [patch 142/166] preadv/pwritev: create compat_writev()
From: akpm@linux-foundation.org
Date: Thu, 02 Apr 2009 16:59:21 -0700
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, kraxel@redhat.com, arnd@arndb.de, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, ralf@linux-mips.org, viro@zeniv.linux.org.uk
Message-ID: <20090402235921.JvLVQWyu_CfjsQDDEIUD40mNXi1tEFM38K16ptagoVA@z>

From: Gerd Hoffmann <kraxel@redhat.com>

Factor out some code from compat_sys_writev() which can be shared with the
upcoming compat_sys_pwritev().

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: <linux-api@vger.kernel.org>
Cc: <linux-arch@vger.kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 fs/compat.c |   25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff -puN fs/compat.c~preadv-pwritev-create-compat_writev fs/compat.c
--- a/fs/compat.c~preadv-pwritev-create-compat_writev
+++ a/fs/compat.c
@@ -1232,15 +1232,12 @@ compat_sys_readv(unsigned long fd, const
 	return ret;
 }
 
-asmlinkage ssize_t
-compat_sys_writev(unsigned long fd, const struct compat_iovec __user *vec, unsigned long vlen)
+static size_t compat_writev(struct file *file,
+			    const struct compat_iovec __user *vec,
+			    unsigned long vlen, loff_t *pos)
 {
-	struct file *file;
 	ssize_t ret = -EBADF;
 
-	file = fget(fd);
-	if (!file)
-		return -EBADF;
 	if (!(file->f_mode & FMODE_WRITE))
 		goto out;
 
@@ -1248,12 +1245,26 @@ compat_sys_writev(unsigned long fd, cons
 	if (!file->f_op || (!file->f_op->aio_write && !file->f_op->write))
 		goto out;
 
-	ret = compat_do_readv_writev(WRITE, file, vec, vlen, &file->f_pos);
+	ret = compat_do_readv_writev(WRITE, file, vec, vlen, pos);
 
 out:
 	if (ret > 0)
 		add_wchar(current, ret);
 	inc_syscw(current);
+	return ret;
+}
+
+asmlinkage ssize_t
+compat_sys_writev(unsigned long fd, const struct compat_iovec __user *vec,
+		  unsigned long vlen)
+{
+	struct file *file;
+	ssize_t ret;
+
+	file = fget(fd);
+	if (!file)
+		return -EBADF;
+	ret = compat_writev(file, vec, vlen, &file->f_pos);
 	fput(file);
 	return ret;
 }
_
