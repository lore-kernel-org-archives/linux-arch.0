From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [PATCH] remove compat_sys_getdents64() (was Re: [RFC] why do we
 still keep __{get,put}_user_unaligned()?)
Date: Sat, 8 Apr 2017 19:36:19 +0100
Message-ID: <20170408183619.GA29622@ZenIV.linux.org.uk>
References: <20170408062115.GZ29622@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:48518 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752508AbdDHSgW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Apr 2017 14:36:22 -0400
Content-Disposition: inline
In-Reply-To: <20170408062115.GZ29622@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Sat, Apr 08, 2017 at 07:21:16AM +0100, Al Viro wrote:
> 	Right now we have no users of __get_user_unaligned() outside of
> arch/* and only 4 users of __put_user_unaligned() outside of arch/*.
> 
> 	All 4 are in compat_sys_getdents64().  For storing
> ->d_ino and ->d_off in
> struct linux_dirent64 {
>         u64             d_ino;
>         s64             d_off;
>         unsigned short  d_reclen;
>         unsigned char   d_type;
>         char            d_name[0];
> };
> in case 32bit userland has weaker alignment requirements for that thing
> and passes us a pointer that would've been aligned for 32bit, but not
> for 64bit ABI.  Which architecture would that be, though?
> 
> 	arm, mips, powerpc, sparc and s390 have that thing 64bit-aligned
> in 32bit ABI (both of them in case of mips).  And since native getdents()
> does *not* maintain more than that when padding an entry, we'd better have
> put_user() of 64bit values work for any 64bit-aligned pointer.  I hadn't
> checked actual cross-compile for tile, but judging by their compat.h they
> are not suffering from that kind of braindamage either.
> 
> 	x86 does, indeed, have weaker alignment in 32bit ABI.  It also
> has __put_user_unaligned defined as __put_user.
> 
> 	Is there any reason to keep those around?  As it is, the only places
> that need those are m68k and arm binfmt-flat, and these boil down to "can this
> CPU flavour do unaligned access?", with "use __get_user/__put_user" and
> "use __copy_from_user/__copy_to_user" as outcomes.  Nothing more fancy...

	Looking at the pre-2.6.12 history, it's even more ridiculous.
compat_sys_getdents64() had been introduced for (and only ever needed by)
biarch support on itanic.  arm64 use of that thing is, AFAICS, not needed
at all and appeared when arm biarch support went in; looks like an oversight
when putting together a list of syscalls ("compat variant is there, probably
ought to use it for some reason", at a guess).
	Use in include/asm-generic/unistd.h appears to be a similar mistake
by tile folks.  amd64 one is definitely an accident - "[PATCH] x86_64: Use
compat readdir and aio functions" had converted old_readdir, getdents,
io_getevents and io_submit from amd64-specific wrappers to generic compat
variants and switched getdents64 to compat wrapper at the same time - from
native sys_getdents64.  Might've assumed that the lack of wrapper for that one
had been a bug...

	Let's at least remove compat_sys_getdents64()...  Linus, do you
have any problems with the following?

    Remove compat_sys_getdents64()
    
    Unlike normal compat syscall variants, it is needed only for
    biarch architectures that have different alignement requirements for
    u64 in 32bit and 64bit ABI *and* have __put_user() that won't handle
    a store of 64bit value at 32bit-aligned address.  We used to have one
    such (ia64), but its biarch support has been gone since 2010 (after
    being broken in 2008, which went unnoticed since nobody had been using
    it).
    
    It had escaped removal at the same time only because back in 2004
    a patch that switched several syscalls on amd64 from private wrappers to
    generic compat ones had switched to use of compat_sys_getdents64(), which
    hadn't needed (or used) a compat wrapper on amd64.
    
    Let's bury it - it's at least 7 years overdue.
    
    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index bdbeb06dc11e..a0baa9af5487 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -14,7 +14,6 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 #ifdef CONFIG_COMPAT
-#define __ARCH_WANT_COMPAT_SYS_GETDENTS64
 #define __ARCH_WANT_COMPAT_STAT64
 #define __ARCH_WANT_SYS_GETHOSTNAME
 #define __ARCH_WANT_SYS_PAUSE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index c66b51aab195..ef292160748c 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -456,7 +456,7 @@ __SYSCALL(__NR_setfsuid32, sys_setfsuid)
 #define __NR_setfsgid32 216
 __SYSCALL(__NR_setfsgid32, sys_setfsgid)
 #define __NR_getdents64 217
-__SYSCALL(__NR_getdents64, compat_sys_getdents64)
+__SYSCALL(__NR_getdents64, sys_getdents64)
 #define __NR_pivot_root 218
 __SYSCALL(__NR_pivot_root, sys_pivot_root)
 #define __NR_mincore 219
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 9ba050fe47f3..b1a63f6f53c0 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -226,7 +226,7 @@
 217	i386	pivot_root		sys_pivot_root
 218	i386	mincore			sys_mincore
 219	i386	madvise			sys_madvise
-220	i386	getdents64		sys_getdents64			compat_sys_getdents64
+220	i386	getdents64		sys_getdents64
 221	i386	fcntl64			sys_fcntl64			compat_sys_fcntl64
 # 222 is unused
 # 223 is unused
diff --git a/arch/x86/include/asm/unistd.h b/arch/x86/include/asm/unistd.h
index 32712a925f26..1ba1536f627e 100644
--- a/arch/x86/include/asm/unistd.h
+++ b/arch/x86/include/asm/unistd.h
@@ -23,7 +23,6 @@
 #  include <asm/unistd_64.h>
 #  include <asm/unistd_64_x32.h>
 #  define __ARCH_WANT_COMPAT_SYS_TIME
-#  define __ARCH_WANT_COMPAT_SYS_GETDENTS64
 #  define __ARCH_WANT_COMPAT_SYS_PREADV64
 #  define __ARCH_WANT_COMPAT_SYS_PWRITEV64
 #  define __ARCH_WANT_COMPAT_SYS_PREADV64V2
diff --git a/fs/compat.c b/fs/compat.c
index c61b506f5bc9..54e5855e291a 100644
--- a/fs/compat.c
+++ b/fs/compat.c
@@ -907,97 +907,6 @@ COMPAT_SYSCALL_DEFINE3(getdents, unsigned int, fd,
 	return error;
 }
 
-#ifdef __ARCH_WANT_COMPAT_SYS_GETDENTS64
-
-struct compat_getdents_callback64 {
-	struct dir_context ctx;
-	struct linux_dirent64 __user *current_dir;
-	struct linux_dirent64 __user *previous;
-	int count;
-	int error;
-};
-
-static int compat_filldir64(struct dir_context *ctx, const char *name,
-			    int namlen, loff_t offset, u64 ino,
-			    unsigned int d_type)
-{
-	struct linux_dirent64 __user *dirent;
-	struct compat_getdents_callback64 *buf =
-		container_of(ctx, struct compat_getdents_callback64, ctx);
-	int reclen = ALIGN(offsetof(struct linux_dirent64, d_name) + namlen + 1,
-		sizeof(u64));
-	u64 off;
-
-	buf->error = -EINVAL;	/* only used if we fail.. */
-	if (reclen > buf->count)
-		return -EINVAL;
-	dirent = buf->previous;
-
-	if (dirent) {
-		if (signal_pending(current))
-			return -EINTR;
-		if (__put_user_unaligned(offset, &dirent->d_off))
-			goto efault;
-	}
-	dirent = buf->current_dir;
-	if (__put_user_unaligned(ino, &dirent->d_ino))
-		goto efault;
-	off = 0;
-	if (__put_user_unaligned(off, &dirent->d_off))
-		goto efault;
-	if (__put_user(reclen, &dirent->d_reclen))
-		goto efault;
-	if (__put_user(d_type, &dirent->d_type))
-		goto efault;
-	if (copy_to_user(dirent->d_name, name, namlen))
-		goto efault;
-	if (__put_user(0, dirent->d_name + namlen))
-		goto efault;
-	buf->previous = dirent;
-	dirent = (void __user *)dirent + reclen;
-	buf->current_dir = dirent;
-	buf->count -= reclen;
-	return 0;
-efault:
-	buf->error = -EFAULT;
-	return -EFAULT;
-}
-
-COMPAT_SYSCALL_DEFINE3(getdents64, unsigned int, fd,
-		struct linux_dirent64 __user *, dirent, unsigned int, count)
-{
-	struct fd f;
-	struct linux_dirent64 __user * lastdirent;
-	struct compat_getdents_callback64 buf = {
-		.ctx.actor = compat_filldir64,
-		.current_dir = dirent,
-		.count = count
-	};
-	int error;
-
-	if (!access_ok(VERIFY_WRITE, dirent, count))
-		return -EFAULT;
-
-	f = fdget_pos(fd);
-	if (!f.file)
-		return -EBADF;
-
-	error = iterate_dir(f.file, &buf.ctx);
-	if (error >= 0)
-		error = buf.error;
-	lastdirent = buf.previous;
-	if (lastdirent) {
-		typeof(lastdirent->d_off) d_off = buf.ctx.pos;
-		if (__put_user_unaligned(d_off, &lastdirent->d_off))
-			error = -EFAULT;
-		else
-			error = count - buf.count;
-	}
-	fdput_pos(f);
-	return error;
-}
-#endif /* __ARCH_WANT_COMPAT_SYS_GETDENTS64 */
-
 /*
  * Exactly like fs/open.c:sys_open(), except that it doesn't set the
  * O_LARGEFILE flag.
diff --git a/include/linux/compat.h b/include/linux/compat.h
index aef47be2a5c1..54d65eb3d1e7 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -528,11 +528,6 @@ asmlinkage long compat_sys_old_readdir(unsigned int fd,
 asmlinkage long compat_sys_getdents(unsigned int fd,
 				    struct compat_linux_dirent __user *dirent,
 				    unsigned int count);
-#ifdef __ARCH_WANT_COMPAT_SYS_GETDENTS64
-asmlinkage long compat_sys_getdents64(unsigned int fd,
-				      struct linux_dirent64 __user *dirent,
-				      unsigned int count);
-#endif
 asmlinkage long compat_sys_vmsplice(int fd, const struct compat_iovec __user *,
 				    unsigned int nr_segs, unsigned int flags);
 asmlinkage long compat_sys_open(const char __user *filename, int flags,
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index a076cf1a3a23..061185a5eb51 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -194,8 +194,7 @@ __SYSCALL(__NR_quotactl, sys_quotactl)
 
 /* fs/readdir.c */
 #define __NR_getdents64 61
-#define __ARCH_WANT_COMPAT_SYS_GETDENTS64
-__SC_COMP(__NR_getdents64, sys_getdents64, compat_sys_getdents64)
+__SYSCALL(__NR_getdents64, sys_getdents64)
 
 /* fs/read_write.c */
 #define __NR3264_lseek 62
