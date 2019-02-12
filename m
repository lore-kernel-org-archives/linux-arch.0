Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yb1-f195.google.com ([209.85.219.195]:46579 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbfBLOy7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Feb 2019 09:54:59 -0500
From: demiobenour@gmail.com
Subject: [PATCH 2/4] Expose O_PATHSTATIC to userspace
Date: Tue, 12 Feb 2019 09:54:45 -0500
Message-ID: <20190212145450.2200-2-demiobenour@gmail.com>
In-Reply-To: <20190212145450.2200-1-demiobenour@gmail.com>
References: <20190212145450.2200-1-demiobenour@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, "open list:FILE LOCKING flock and
        fcntl/lockf" <linux-fsdevel@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>
Cc: "Demi M. Obenour" <demiobenour@gmail.com>
Message-ID: <20190212145445.kU54cWNxRS4geIIEoIgK6LG0tSROaQClfxsaWap40DQ@z>

From: "Demi M. Obenour" <demiobenour@gmail.com>

This adds the file open flag O_PATHSTATIC, which ensures that symbolic
links are *never* followed, even in path components other than the last.
This is distinct from O_NOFOLLOW, which only prevents symlinks in the
*last* component from being followed.

This is useful for avoiding race conditions in userspace code that
should expose only a subset of the filesystem to clients.  This includes
FTP and SFTP servers, QEMU, and others.

Currently, O_NOFOLLOW must be set if O_PATHSTATIC is set.  Otherwise,
open() fails with -EINVAL.
---
 fs/fcntl.c                       |  2 +-
 fs/namei.c                       |  6 ++++++
 fs/open.c                        | 24 ++++++++++++++++++++++--
 include/linux/fcntl.h            |  2 +-
 include/uapi/asm-generic/fcntl.h |  4 ++++
 5 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 083185174c6d..6c85c4d0c006 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -1031,7 +1031,7 @@ static int __init fcntl_init(void)
 	 * Exceptions: O_NONBLOCK is a two bit define on parisc; O_NDELAY
 	 * is defined as O_NONBLOCK on some platforms and not on others.
 	 */
-	BUILD_BUG_ON(21 - 1 /* for O_RDONLY being 0 */ !=
+	BUILD_BUG_ON(22 - 1 /* for O_RDONLY being 0 */ !=
 		HWEIGHT32(
 			(VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY)) |
 			__FMODE_EXEC | __FMODE_NONOTIFY));
diff --git a/fs/namei.c b/fs/namei.c
index 54fbd2c7ba82..4c90f265c103 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3282,6 +3282,12 @@ static int do_last(struct nameidata *nd,
 	if (!(open_flag & O_CREAT)) {
 		if (nd->last.name[nd->last.len])
 			nd->flags |= LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
+
+		if (open_flag & O_PATHSTATIC) {
+			nd->flags |= LOOKUP_NEVER_FOLLOW;
+			nd->flags &= ~LOOKUP_FOLLOW;
+		}
+
 		/* we _can_ be in RCU mode here */
 		error = lookup_fast(nd, &path, &inode, &seq);
 		if (likely(error > 0))
diff --git a/fs/open.c b/fs/open.c
index 0285ce7dbd51..717afa8179c0 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -940,6 +940,24 @@ static inline int build_open_flags(int flags, umode_t mode, struct open_flags *o
 	/* Must never be set by userspace */
 	flags &= ~FMODE_NONOTIFY & ~O_CLOEXEC;
 
+	/*
+	 * If nonzero, setting O_PATHSTATIC but not O_NOFOLLOW fails with
+	 * -EINVAL.  Otherwise, setting O_PATHSTATIC automatically sets
+	 * O_NOFOLLOW.
+	 */
+#define REQUIRE_NOFOLLOW_FOR_PATHSTATIC 1
+
+#if REQUIRE_NOFOLLOW_FOR_PATHSTATIC
+	/* O_PATHSTATIC doesn't make sense without O_NOFOLLOW */
+	if (unlikely((flags & O_PATHSTATIC) && !(flags & O_NOFOLLOW)))
+		return -EINVAL;
+#elif defined REQUIRE_NOFOLLOW_FOR_PATHSTATIC
+	if (flags & O_PATHSTATIC)
+		flags &= O_NOFOLLOW;
+#else
+#error REQUIRE_NOFOLLOW_FOR_PATHSTATIC must be defined
+#endif
+
 	/*
 	 * O_SYNC is implemented as __O_SYNC|O_DSYNC.  As many places only
 	 * check for O_DSYNC if the need any syncing at all we enforce it's
@@ -959,7 +977,7 @@ static inline int build_open_flags(int flags, umode_t mode, struct open_flags *o
 		 * If we have O_PATH in the open flag. Then we
 		 * cannot have anything other than the below set of flags
 		 */
-		flags &= O_DIRECTORY | O_NOFOLLOW | O_PATH;
+		flags &= O_DIRECTORY | O_NOFOLLOW | O_PATH | O_PATHSTATIC;
 		acc_mode = 0;
 	}
 
@@ -986,7 +1004,9 @@ static inline int build_open_flags(int flags, umode_t mode, struct open_flags *o
 
 	if (flags & O_DIRECTORY)
 		lookup_flags |= LOOKUP_DIRECTORY;
-	if (!(flags & O_NOFOLLOW))
+	if (flags & O_PATHSTATIC)
+		lookup_flags |= LOOKUP_NEVER_FOLLOW;
+	else if (!(flags & O_NOFOLLOW))
 		lookup_flags |= LOOKUP_FOLLOW;
 	op->lookup_flags = lookup_flags;
 	return 0;
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index 27dc7a60693e..6f91e1490592 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -9,7 +9,7 @@
 	(O_RDONLY | O_WRONLY | O_RDWR | O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC | \
 	 O_APPEND | O_NDELAY | O_NONBLOCK | O_NDELAY | __O_SYNC | O_DSYNC | \
 	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
-	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
+	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE | O_PATHSTATIC)
 
 #ifndef force_o_largefile
 #define force_o_largefile() (BITS_PER_LONG != 32)
diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index 9dc0bf0c5a6e..314ea1cecf44 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -89,6 +89,10 @@
 #define __O_TMPFILE	020000000
 #endif
 
+#ifndef O_PATHSTATIC
+#define O_PATHSTATIC	040000000
+#endif
+
 /* a horrid kludge trying to make sure that this will fail on old kernels */
 #define O_TMPFILE (__O_TMPFILE | O_DIRECTORY)
 #define O_TMPFILE_MASK (__O_TMPFILE | O_DIRECTORY | O_CREAT)      
-- 
2.20.1
