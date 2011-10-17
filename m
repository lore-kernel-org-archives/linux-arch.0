From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [PATCH] compat: sync compat_stats with statfs.
Date: Mon, 17 Oct 2011 13:40:02 -0700
Message-ID: <m1r52b4ajh.fsf@fess.ebiederm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from out02.mta.xmission.com ([166.70.13.232]:41369 "EHLO
	out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754510Ab1JSVgQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 19 Oct 2011 17:36:16 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>, Christoph Hellwig <hch@infradead.org>
Cc: linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Kyle McMartin <kyle@mcmartin.ca>


This was found by inspection while tracking a similar
bug in compat_statfs64, that has been fixed in mainline
since decemeber.

- This fixes a bug where not all of the f_spare fields
  were cleared on mips and s390.
- Add the f_flags field to struct compat_statfs
- Copy f_flags to userspace in case someone cares.
- Use __clear_user to copy the f_spare field to userspace
  to ensure that all of the elements of f_spare are cleared.
  On some architectures f_spare is has 5 ints and on some
  architectures f_spare only has 4 ints.  Which makes
  the previous technique of clearing each int individually
  broken.

I don't expect anyone actually uses the old statfs system
call anymore but if they do let them benefit from having
the compat and the native version working the same.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/mips/include/asm/compat.h    |    3 ++-
 arch/parisc/include/asm/compat.h  |    3 ++-
 arch/powerpc/include/asm/compat.h |    3 ++-
 arch/s390/include/asm/compat.h    |    3 ++-
 arch/sparc/include/asm/compat.h   |    3 ++-
 arch/x86/include/asm/compat.h     |    3 ++-
 fs/compat.c                       |    7 ++-----
 7 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/arch/mips/include/asm/compat.h b/arch/mips/include/asm/compat.h
index dbc5106..b77df03 100644
--- a/arch/mips/include/asm/compat.h
+++ b/arch/mips/include/asm/compat.h
@@ -111,7 +111,8 @@ struct compat_statfs {
 	int		f_bavail;
 	compat_fsid_t	f_fsid;
 	int		f_namelen;
-	int		f_spare[6];
+	int		f_flags;
+	int		f_spare[5];
 };
 
 #define COMPAT_RLIM_INFINITY	0x7fffffffUL
diff --git a/arch/parisc/include/asm/compat.h b/arch/parisc/include/asm/compat.h
index efa0b60..760f331 100644
--- a/arch/parisc/include/asm/compat.h
+++ b/arch/parisc/include/asm/compat.h
@@ -105,7 +105,8 @@ struct compat_statfs {
 	__kernel_fsid_t	f_fsid;
 	s32		f_namelen;
 	s32		f_frsize;
-	s32		f_spare[5];
+	s32		f_flags;
+	s32		f_spare[4];
 };
 
 struct compat_sigcontext {
diff --git a/arch/powerpc/include/asm/compat.h b/arch/powerpc/include/asm/compat.h
index 91010e8..88e602f 100644
--- a/arch/powerpc/include/asm/compat.h
+++ b/arch/powerpc/include/asm/compat.h
@@ -100,7 +100,8 @@ struct compat_statfs {
 	compat_fsid_t	f_fsid;
 	int		f_namelen;	/* SunOS ignores this field. */
 	int		f_frsize;
-	int		f_spare[5];
+	int		f_flags;
+	int		f_spare[4];
 };
 
 #define COMPAT_RLIM_OLD_INFINITY	0x7fffffff
diff --git a/arch/s390/include/asm/compat.h b/arch/s390/include/asm/compat.h
index da359ca..cdb9b78 100644
--- a/arch/s390/include/asm/compat.h
+++ b/arch/s390/include/asm/compat.h
@@ -131,7 +131,8 @@ struct compat_statfs {
 	compat_fsid_t	f_fsid;
 	s32		f_namelen;
 	s32		f_frsize;
-	s32		f_spare[6];
+	s32		f_flags;
+	s32		f_spare[5];
 };
 
 #define COMPAT_RLIM_OLD_INFINITY	0x7fffffff
diff --git a/arch/sparc/include/asm/compat.h b/arch/sparc/include/asm/compat.h
index 6f57325..b8be20d 100644
--- a/arch/sparc/include/asm/compat.h
+++ b/arch/sparc/include/asm/compat.h
@@ -134,7 +134,8 @@ struct compat_statfs {
 	compat_fsid_t	f_fsid;
 	int		f_namelen;	/* SunOS ignores this field. */
 	int		f_frsize;
-	int		f_spare[5];
+	int		f_flags;
+	int		f_spare[4];
 };
 
 #define COMPAT_RLIM_INFINITY 0x7fffffff
diff --git a/arch/x86/include/asm/compat.h b/arch/x86/include/asm/compat.h
index 1d9cd27..30d737e 100644
--- a/arch/x86/include/asm/compat.h
+++ b/arch/x86/include/asm/compat.h
@@ -108,7 +108,8 @@ struct compat_statfs {
 	compat_fsid_t	f_fsid;
 	int		f_namelen;	/* SunOS ignores this field. */
 	int		f_frsize;
-	int		f_spare[5];
+	int		f_flags;
+	int		f_spare[4];
 };
 
 #define COMPAT_RLIM_OLD_INFINITY	0x7fffffff
diff --git a/fs/compat.c b/fs/compat.c
index 58b1da4..0f1ab46 100644
--- a/fs/compat.c
+++ b/fs/compat.c
@@ -247,11 +247,8 @@ static int put_compat_statfs(struct compat_statfs __user *ubuf, struct kstatfs *
 	    __put_user(kbuf->f_fsid.val[0], &ubuf->f_fsid.val[0]) ||
 	    __put_user(kbuf->f_fsid.val[1], &ubuf->f_fsid.val[1]) ||
 	    __put_user(kbuf->f_frsize, &ubuf->f_frsize) ||
-	    __put_user(0, &ubuf->f_spare[0]) || 
-	    __put_user(0, &ubuf->f_spare[1]) || 
-	    __put_user(0, &ubuf->f_spare[2]) || 
-	    __put_user(0, &ubuf->f_spare[3]) || 
-	    __put_user(0, &ubuf->f_spare[4]))
+	    __put_user(kbuf->f_flags, &ubuf->f_flags) ||
+	    __clear_user(ubuf->f_spare, sizeof(ubuf->f_spare)))
 		return -EFAULT;
 	return 0;
 }
-- 
1.7.2.5
