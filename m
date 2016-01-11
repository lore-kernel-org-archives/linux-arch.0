Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36371 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760107AbcAKW6W (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 11 Jan 2016 17:58:22 -0500
Received: by mail-pa0-f51.google.com with SMTP id yy13so235669290pab.3
        for <linux-arch@vger.kernel.org>; Mon, 11 Jan 2016 14:58:22 -0800 (PST)
Date: Mon, 11 Jan 2016 14:57:50 -0800
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH v7] fs: clear file privilege bits when mmap writing
Message-ID: <20160111225750.GA4256@www.outflux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andy Lutomirski <luto@amacapital.net>, Jan Kara <jack@suse.cz>, yalin wang <yalin.wang2010@gmail.com>, Willy Tarreau <w@1wt.eu>, Konstantin Khlebnikov <koct9i@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20160111225750.4NnH7Mq6uRsZpzTb8k0oFaYDVxx9kICbv7tD4aXG030@z>

Normally, when a user can modify a file that has setuid or setgid bits,
those bits are cleared when they are not the file owner or a member
of the group. This is enforced when using write and truncate but not
when writing to a shared mmap on the file. This could allow the file
writer to gain privileges by changing a binary without losing the
setuid/setgid/caps bits.

Changing the bits requires holding inode->i_mutex, so it cannot be done
during the page fault (due to mmap_sem being held during the fault). We
could do this during vm_mmap_pgoff, but that would need coverage in
mprotect as well, but to check for MAP_SHARED, we'd need to hold mmap_sem
again. We could clear at open() time, but it's possible things are
accidentally opening with O_RDWR and only reading. Better to clear on
close and error failures (i.e. an improvement over now, which is not
clearing at all).

Instead, detect the need to clear the bits during the page fault, and
actually remove the bits during final fput. Since the file was open for
writing, it wouldn't have been possible to execute it yet (ETXTBSY).

Signed-off-by: Kees Cook <keescook@chromium.org>
---
v7:
- document and avoid arch-specific O_* values, viro
v6:
- clarify ETXTBSY situation in comments, luto
v5:
- add to f_flags instead, viro
- add i_mutex during __fput, jack
v4:
- delay removal instead of still needing mmap_sem for mprotect, yalin
v3:
- move outside of mmap_sem for real now, fengguang
- check return code of file_remove_privs, akpm
v2:
- move to mmap from fault handler, jack
---
 fs/file_table.c                  | 15 +++++++++++++++
 fs/open.c                        |  2 +-
 include/uapi/asm-generic/fcntl.h | 11 +++++++++++
 mm/memory.c                      |  5 +++++
 4 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index ad17e05ebf95..ca11b86613cf 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -191,6 +191,21 @@ static void __fput(struct file *file)
 
 	might_sleep();
 
+	/*
+	 * XXX: This is a delayed removal of privs (we've already been
+	 * written to), since we must avoid mmap_sem. But a race shouldn't
+	 * be possible since when open for writing, execve() will fail
+	 * with ETXTBSY (via deny_write_access()). A remaining problem
+	 * is that since we've already been written to, we must ignore the
+	 * return value of file_remove_privs(), since we can't reject the
+	 * writes of the past.
+	 */
+	if (unlikely(file->f_flags & O_REMOVEPRIV)) {
+		mutex_lock(&inode->i_mutex);
+		file_remove_privs(file);
+		mutex_unlock(&inode->i_mutex);
+	}
+
 	fsnotify_close(file);
 	/*
 	 * The function eventpoll_release() should be the first called
diff --git a/fs/open.c b/fs/open.c
index b6f1e96a7c0b..89069d16ca80 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -895,7 +895,7 @@ static inline int build_open_flags(int flags, umode_t mode, struct open_flags *o
 		op->mode = 0;
 
 	/* Must never be set by userspace */
-	flags &= ~FMODE_NONOTIFY & ~O_CLOEXEC;
+	flags &= ~FMODE_NONOTIFY & ~O_CLOEXEC & ~O_REMOVEPRIV;
 
 	/*
 	 * O_SYNC is implemented as __O_SYNC|O_DSYNC.  As many places only
diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index e063effe0cc1..1b6c49edb393 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -88,6 +88,17 @@
 #define __O_TMPFILE	020000000
 #endif
 
+/*
+ * Reserved arch-specific values for __O_TMPFILE:
+ *			0040000000 (parisc)
+ *			0100000000 (alpha)
+ *			0200000000 (sparc)
+ */
+
+#ifndef O_REMOVEPRIV
+#define O_REMOVEPRIV	0400000000
+#endif
+
 /* a horrid kludge trying to make sure that this will fail on old kernels */
 #define O_TMPFILE (__O_TMPFILE | O_DIRECTORY)
 #define O_TMPFILE_MASK (__O_TMPFILE | O_DIRECTORY | O_CREAT)      
diff --git a/mm/memory.c b/mm/memory.c
index c387430f06c3..ad4188a8f279 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2036,6 +2036,11 @@ static inline int wp_page_reuse(struct mm_struct *mm,
 
 		if (!page_mkwrite)
 			file_update_time(vma->vm_file);
+		if (unlikely((vma->vm_file->f_flags & O_REMOVEPRIV) == 0)) {
+			spin_lock(&vma->vm_file->f_lock);
+			vma->vm_file->f_flags |= O_REMOVEPRIV;
+			spin_unlock(&vma->vm_file->f_lock);
+		}
 	}
 
 	return VM_FAULT_WRITE;
-- 
2.6.3


-- 
Kees Cook
Chrome OS & Brillo Security
