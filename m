Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D92330B0B
	for <linux-arch@vger.kernel.org>; Sun, 19 Apr 2026 13:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776604771; cv=none; b=t9kKWUggBGcTSOmFDQrSgN1i0qjU9JNYbVpzzPtUwoOR9ipFV4kfLz7EE72woa3Ty3KrprSm+Xp1JIfLlShZqAwCzD4ezLssg0hRVfRYVq76gLP0aAHzPJ9dSQZMBFt0Ktmz8i8JTddrNySD+8LkqQj2GR7NtPzPyrjnLhPukOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776604771; c=relaxed/simple;
	bh=piegtrwAfQlcJ1gJnKFobGmCxa1L/mtr52ScpX88psE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IeTtjDObN/qVdt2jsZFYZiMOSTJhTCnfQuvwCBj87KS8wtWzKW54YRAF+sDyA1toPrW/jjxJ9kITmBv4TygxeiUzdmWPEmApVND0CgEvPclvczFJqGcvoNsztQNHf1p7jDc1niS2woc6A4L+/YCJE3B1d/qdB8GVkhyhv6q0Iyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=jf4IpW7D; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="jf4IpW7D"
X-KPN-MessageId: 3b35c853-3bf2-11f1-89e1-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 3b35c853-3bf2-11f1-89e1-00505699b430;
	Sun, 19 Apr 2026 15:18:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=OT/GmjwXVW710Q03NOsNHKFOk0z6sXD8EMuD3Rgu+mE=;
	b=jf4IpW7Dq6M7kiS3Jltqt5KsCq3G02WqGhkJe01vsCMqMcdUt1rd3ybjrj3bmS1q8KN7NtS03oeo7
	 rvwKLKlLhpSdla08xa0vI96pyOtQQ3+LoqM7z2mRV7rrclbCM+sPy6UOBh8k10nlBALywQa37Hx91B
	 DbmbILwxr7vV7Fd459R36EWoUDuzA6BKNXAoDejmp5Zny+I8vKd/n/OVT759GHMk1qs8lVWvzsUqVP
	 fqcZbC2k+ovNt/tduw2OhOmcf57slU4fQJ/UTZu5W1CNELfs3ANLpldaJ5hlaspiSm7xcoCTKqusFj
	 En/l8mgOwXF+WgyM356YhKmlA3qrGaw==
X-KPN-MID: 33|KECJPZpwAPBwREkfSmhmhI4z6SLDCh66BenYizqxZuiZd4BLt5dsS3AXsr+yh82
 QVXBAxC6zLsY6WHQRh6ISD4RInYfCFVnNNeo+RTc5xxM=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|+bl3p0rh67ASnUGE2BSIbL7nI4HOQCYDvl6xyRmsRW4iCQLXQVL1SYM9E19QXw9
 j8gDyKxz0Hbp1dcUpCjkH9A==
Received: from daedalus.home (unknown [178.227.25.188])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 361c9105-3bf2-11f1-bffa-00505699772e;
	Sun, 19 Apr 2026 15:18:18 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Aleksa Sarai <cyphar@cyphar.com>,
	cmirabil@redhat.com,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>,
	linux-fsdevel@vger.kernel.org (open list:FILE LOCKING (flock() and fcntl()/lockf())),
	linux-kernel@vger.kernel.org (open list),
	linux-arch@vger.kernel.org (open list:GENERIC INCLUDE/ASM HEADER FILES)
Subject: [PATCH v4 1/2] vfs: add O_EMPTYPATH to openat(2)/openat2(2)
Date: Sun, 19 Apr 2026 15:17:49 +0200
Message-ID: <20260419131800.486788-1-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To get an operable version of an O_PATH file descriptor, it is possible
to use openat(fd, ".", O_DIRECTORY) for directories, but other files
currently require going through open("/proc/<pid>/fd/<nr>"), which
depends on a functioning procfs.

This patch adds the O_EMPTYPATH flag to openat(2)/openat2(2). If passed,
LOOKUP_EMPTY is set at path resolution time.

Note: This implies that you cannot rely anymore on disabling procfs from
being mounted (e.g. inside a container without procfs mounted and with
CAP_SYS_ADMIN dropped) to prevent O_PATH fds from being re-opened
read-write.

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/fcntl.c                       | 2 +-
 fs/open.c                        | 6 ++++--
 include/linux/fcntl.h            | 2 +-
 include/uapi/asm-generic/fcntl.h | 4 ++++
 4 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index beab8080badf..7d2165855a9c 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -1169,7 +1169,7 @@ static int __init fcntl_init(void)
 	 * Exceptions: O_NONBLOCK is a two bit define on parisc; O_NDELAY
 	 * is defined as O_NONBLOCK on some platforms and not on others.
 	 */
-	BUILD_BUG_ON(20 - 1 /* for O_RDONLY being 0 */ !=
+	BUILD_BUG_ON(21 - 1 /* for O_RDONLY being 0 */ !=
 		HWEIGHT32(
 			(VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY)) |
 			__FMODE_EXEC));
diff --git a/fs/open.c b/fs/open.c
index 681d405bc61e..9e0164a8c1fb 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1158,7 +1158,7 @@ struct file *kernel_file_open(const struct path *path, int flags,
 EXPORT_SYMBOL_GPL(kernel_file_open);
 
 #define WILL_CREATE(flags)	(flags & (O_CREAT | __O_TMPFILE))
-#define O_PATH_FLAGS		(O_DIRECTORY | O_NOFOLLOW | O_PATH | O_CLOEXEC)
+#define O_PATH_FLAGS		(O_DIRECTORY | O_NOFOLLOW | O_PATH | O_CLOEXEC | O_EMPTYPATH)
 
 inline struct open_how build_open_how(int flags, umode_t mode)
 {
@@ -1279,6 +1279,8 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 		lookup_flags |= LOOKUP_DIRECTORY;
 	if (!(flags & O_NOFOLLOW))
 		lookup_flags |= LOOKUP_FOLLOW;
+	if (flags & O_EMPTYPATH)
+		lookup_flags |= LOOKUP_EMPTY;
 
 	if (how->resolve & RESOLVE_NO_XDEV)
 		lookup_flags |= LOOKUP_NO_XDEV;
@@ -1360,7 +1362,7 @@ static int do_sys_openat2(int dfd, const char __user *filename,
 	if (unlikely(err))
 		return err;
 
-	CLASS(filename, name)(filename);
+	CLASS(filename_flags, name)(filename, op.lookup_flags);
 	return FD_ADD(how->flags, do_file_open(dfd, name, &op));
 }
 
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index a332e79b3207..c65c5c73d362 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -10,7 +10,7 @@
 	(O_RDONLY | O_WRONLY | O_RDWR | O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC | \
 	 O_APPEND | O_NDELAY | O_NONBLOCK | __O_SYNC | O_DSYNC | \
 	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
-	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
+	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE | O_EMPTYPATH)
 
 /* List of all valid flags for the how->resolve argument: */
 #define VALID_RESOLVE_FLAGS \
diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index 613475285643..db144851f57b 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -88,6 +88,10 @@
 #define __O_TMPFILE	020000000
 #endif
 
+#ifndef O_EMPTYPATH
+#define O_EMPTYPATH	040000000	/* allow empty path */
+#endif
+
 /* a horrid kludge trying to make sure that this will fail on old kernels */
 #define O_TMPFILE (__O_TMPFILE | O_DIRECTORY)
 
-- 
2.53.0

