Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1E73BF673
	for <linux-arch@vger.kernel.org>; Fri, 24 Apr 2026 11:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777031285; cv=none; b=JkOFHxMe6VHLth5lsFX3N+G/jqj0AWa4ucjNuIyquZxxSEVgEzrEY0DszFXmLIwviptxFS06Cal54rmKJT7e2eacJ84EjI6Ag3MFg3kU9DexSKXent5DBffRbeTnGwo4Eg2pwqL7713S9TiDs+z8EG0QsYqakAVqt9Dv8Bya3Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777031285; c=relaxed/simple;
	bh=4r5RvhbLKnR/CgAsUMSEjQzzprHmmek/AmO6M+zAB60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dBb0ke4JY37Efpvs2unSYX36BYsEajakD6MHyKUcLZpl8e97j1/B6x0UUdrGHIYtTinZ7mawnIi1Yu7cSGXcDQ1WFPyBnl56u6C9AUKreWCaLrLt9CyBxBrWhp5uXLAYCxjK6gq5+iy6KMBG3R4TUVBmUsQ9Fh3fkmRidPThUQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=stjuhjTC; arc=none smtp.client-ip=195.121.94.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="stjuhjTC"
X-KPN-MessageId: 4aa257ec-3fd3-11f1-8ff3-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 4aa257ec-3fd3-11f1-8ff3-005056999439;
	Fri, 24 Apr 2026 13:46:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=ZrhMYcreG9Hj+7wH35gfOV2SV98uZrceH6hCeQICsGg=;
	b=stjuhjTC1LvnAatFjI6P5/spawHckQyezjdZbo5tq3o4VPAhUgGmmgX6hVIy1ImeLnVdGgBOmQP2K
	 Og4JWiOq8ovY6xCKUGGmtj1VL/rFAFiYGJGRctZCdz8sRH/iCB8sTlsDGEnyA81FY+/kSmPj9Hvr6n
	 vBCou8fdy4aOPJcvcsmcRxDQACZXDGiVTuJpLh/5YAK1Z463siHKfHo2Wd+lvnlvTk+qlwtoi7ofHY
	 vSVPfe4O08nsuEAxcUycpNb/Am7eQ9PKRJn+WSsclHBNs1PCFpdRFGllfTnawFFEm43gi2PjHDjItC
	 TBZ4F0selLyuxoHUVE7pWAl27sxxeKg==
X-KPN-MID: 33|FUnsPlT93BNBRRPIGjQuHsTveNGhZKo7Fw1aQ0rXGKxm9L+62p1aCM/VvQiDFCg
 9nxwyXHXVWIH6GuP4d/iorEXLeIwxU0iC+TxggF4CJLk=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|FpymY/PkmFhHzrLRaMdxRmirFll8b5SmaGQ+Z9Eomz5JSL4V3AgigkWq2uktUeK
 nJgcvjEyTD7qTwe4aLURuLQ==
Received: from daedalus.home (unknown [178.227.109.146])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 4a5d8641-3fd3-11f1-9c0b-00505699d6e5;
	Fri, 24 Apr 2026 13:46:54 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	linux-arch@vger.kernel.org (open list:GENERIC INCLUDE/ASM HEADER FILES)
Subject: [PATCH v5 1/2] vfs: add O_EMPTYPATH to openat(2)/openat2(2)
Date: Fri, 24 Apr 2026 13:46:02 +0200
Message-ID: <20260424114611.1678641-2-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260424114611.1678641-1-jkoolstra@xs4all.nl>
References: <20260424114611.1678641-1-jkoolstra@xs4all.nl>
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
index 613475285643..bfc68156b45a 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -88,6 +88,10 @@
 #define __O_TMPFILE	020000000
 #endif
 
+#ifndef O_EMPTYPATH
+#define O_EMPTYPATH	(1 << 26)	/* allow empty path */
+#endif
+
 /* a horrid kludge trying to make sure that this will fail on old kernels */
 #define O_TMPFILE (__O_TMPFILE | O_DIRECTORY)
 
-- 
2.54.0

