Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A121FE47B
	for <linux-arch@vger.kernel.org>; Mon, 23 Feb 2026 15:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771859869; cv=none; b=Dhb8mC9waaGGyuWalXjBx1L1pUGxANVlAYx1R+iNKqJRU+iQ+FOHd2N4hkl4AERtF96cKbwgrn7txVWeIdYabhDpoFGRD1LTTFj7fjok62Mr6TfnS0WAz8gzjLLwnoL2Cn6tJlaU3cDK2JK71nN/gC88P8xQh/xj4fCHvHEEXps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771859869; c=relaxed/simple;
	bh=S6f4OSeOdwFtTvDmuWzz71idGWXHpg8JIYPYCgQVQZg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mcMoOmXWT8YS/NiurAG+O35wBPgQurLhU3SbjoPmZOeBbI7XJ3QZyWHbtyhMtFSWRlXr3bO6ZQRBE62dBkU3ydxIYpikE39FrVvb7VqFSZvEenalGO3TawPXtiN+ZMCRl0/H5IeKdeKJELm1EAH98Cnb3S5R1r7enUxHL+YlOAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=UFWcD0xh; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="UFWcD0xh"
X-KPN-MessageId: a59a2182-10ca-11f1-b181-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id a59a2182-10ca-11f1-b181-005056abad63;
	Mon, 23 Feb 2026 16:16:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=LZV0p7h9QVGul+r0X+delToi4GAIpdjQCqrCW/EFPa0=;
	b=UFWcD0xhmlurYXNxTQ1VnPgKQRJXg5MP51aPGnoIbDithc2UwF7X4Vg9HnZIzfEzVYlMPWYOQIc9f
	 Jw+z5J4KZOFnU8BgNo3taJg4n1kuI2Pr+F0eApizx/C5EsohLrt1d9L4/JZIvbpqKCpmKiYt+GFPIT
	 74n+I+zWsKMDPYiagosxnlGNowfl7fXTZYSL/HysEzutsTb9zn5b2xrf2tShZtNZk6Qx+3D9W8C0PF
	 1e6TyBqN3VRshNPGMi2xZs+YzHsZwaJQA3v6ZBeCG/uyY21FqFPJe25RyNLtxc7H4CFpUM02KG5LsZ
	 t65/L0TEZaxH4UWJfE0wlmfT9KNAm3w==
X-KPN-MID: 33|6xbVdMBpbX6LwH2HYBsrQ/S9ZruyUKnwQUibKvwI/r7OCqDA4wbX68TB9AWiccj
 OJqyIkFMLSRfueoMyeYtosw==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|vVWvf2zt/0xViE/6bU7JINk92i5Q+ghtq3hQdSCWNH838Jv6O1S3YuQrURSx2pF
 5EvCZxY/g99HZbnWbNVzALg==
Received: from daedalus.home (unknown [91.141.147.178])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id a1ffedf7-10ca-11f1-b8df-005056ab7584;
	Mon, 23 Feb 2026 16:16:37 +0100 (CET)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: jlayton@kernel.org,
	chuck.lever@oracle.com,
	alex.aring@gmail.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	arnd@arndb.de,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Cc: jkoolstra@xs4all.nl
Subject: [PATCH] Add support for empty path in openat and openat2 syscalls
Date: Mon, 23 Feb 2026 16:16:52 +0100
Message-ID: <20260223151652.582048-1-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To get an operable version of an O_PATH file descriptors, it is possible
to use openat(fd, ".", O_DIRECTORY) for directories, but other files
currently require going through open("/proc/<pid>/fd/<nr>") which
depends on a functioning procfs.

This patch adds the O_EMPTY_PATH flag to openat and openat2. If passed
LOOKUP_EMPTY is set at path resolve time.

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/fcntl.c                       | 2 +-
 fs/open.c                        | 6 ++++--
 include/linux/fcntl.h            | 2 +-
 include/uapi/asm-generic/fcntl.h | 4 ++++
 4 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index f93dbca08435..62ab4ad2b6f5 100644
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
index 91f1139591ab..32865822ca1c 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1160,7 +1160,7 @@ struct file *kernel_file_open(const struct path *path, int flags,
 EXPORT_SYMBOL_GPL(kernel_file_open);
 
 #define WILL_CREATE(flags)	(flags & (O_CREAT | __O_TMPFILE))
-#define O_PATH_FLAGS		(O_DIRECTORY | O_NOFOLLOW | O_PATH | O_CLOEXEC)
+#define O_PATH_FLAGS		(O_DIRECTORY | O_NOFOLLOW | O_PATH | O_CLOEXEC | O_EMPTY_PATH)
 
 inline struct open_how build_open_how(int flags, umode_t mode)
 {
@@ -1277,6 +1277,8 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 		}
 	}
 
+	if (flags & O_EMPTY_PATH)
+		lookup_flags |= LOOKUP_EMPTY;
 	if (flags & O_DIRECTORY)
 		lookup_flags |= LOOKUP_DIRECTORY;
 	if (!(flags & O_NOFOLLOW))
@@ -1362,7 +1364,7 @@ static int do_sys_openat2(int dfd, const char __user *filename,
 	if (unlikely(err))
 		return err;
 
-	CLASS(filename, name)(filename);
+	CLASS(filename_flags, name)(filename, op.lookup_flags);
 	return FD_ADD(how->flags, do_file_open(dfd, name, &op));
 }
 
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index a332e79b3207..ce742f67bf60 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -10,7 +10,7 @@
 	(O_RDONLY | O_WRONLY | O_RDWR | O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC | \
 	 O_APPEND | O_NDELAY | O_NONBLOCK | __O_SYNC | O_DSYNC | \
 	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
-	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
+	 O_NOATIME | O_CLOEXEC | O_PATH | O_EMPTY_PATH | __O_TMPFILE)
 
 /* List of all valid flags for the how->resolve argument: */
 #define VALID_RESOLVE_FLAGS \
diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index 613475285643..8e4e796ad212 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -88,6 +88,10 @@
 #define __O_TMPFILE	020000000
 #endif
 
+#ifndef O_EMPTY_PATH
+#define O_EMPTY_PATH	0100000000
+#endif
+
 /* a horrid kludge trying to make sure that this will fail on old kernels */
 #define O_TMPFILE (__O_TMPFILE | O_DIRECTORY)
 
-- 
2.53.0

