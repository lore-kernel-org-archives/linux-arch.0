Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40092 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbfBVMxl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Feb 2019 07:53:41 -0500
Received: by mail-wm1-f65.google.com with SMTP id t15so1848948wmi.5
        for <linux-arch@vger.kernel.org>; Fri, 22 Feb 2019 04:53:38 -0800 (PST)
From: Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v10 04/12] mm, arm64: untag user pointers passed to memory syscalls
Date: Fri, 22 Feb 2019 13:53:16 +0100
Message-ID: <3875fa863b755d8cb43afa7bb0fe543e5fd05a5d.1550839937.git.andreyknvl@google.com>
In-Reply-To: <cover.1550839937.git.andreyknvl@google.com>
References: <cover.1550839937.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Robin Murphy <robin.murphy@arm.com>, Kees Cook <keescook@chromium.org>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Shuah Khan <shuah@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>, Evgeniy Stepanov <eugenis@google.com>, Lee Smith <Lee.Smith@arm.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Jacob Bramley <Jacob.Bramley@arm.com>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Chintan Pandya <cpandya@codeaurora.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Dave Martin <Dave.Martin@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Andrey Konovalov <andreyknvl@google.com>
Message-ID: <20190222125316.ld9V-C3Y1DfZWSyn-lXtPBBz7wmFdkLX1pIbkHzuVgs@z>

This commit allows tagged pointers to be passed to the following memory
syscalls: madvise, mbind, get_mempolicy, mincore, mlock, mlock2, brk,
mmap_pgoff, old_mmap, munmap, remap_file_pages, mprotect, pkey_mprotect,
mremap, msync and shmdt.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 ipc/shm.c      | 2 ++
 mm/madvise.c   | 2 ++
 mm/mempolicy.c | 5 +++++
 mm/migrate.c   | 1 +
 mm/mincore.c   | 2 ++
 mm/mlock.c     | 5 +++++
 mm/mmap.c      | 7 +++++++
 mm/mprotect.c  | 2 ++
 mm/mremap.c    | 2 ++
 mm/msync.c     | 2 ++
 10 files changed, 30 insertions(+)

diff --git a/ipc/shm.c b/ipc/shm.c
index 0842411cb0e9..f0fd9591d28f 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -1567,6 +1567,7 @@ SYSCALL_DEFINE3(shmat, int, shmid, char __user *, shmaddr, int, shmflg)
 	unsigned long ret;
 	long err;
 
+	shmaddr = untagged_addr(shmaddr);
 	err = do_shmat(shmid, shmaddr, shmflg, &ret, SHMLBA);
 	if (err)
 		return err;
@@ -1706,6 +1707,7 @@ long ksys_shmdt(char __user *shmaddr)
 
 SYSCALL_DEFINE1(shmdt, char __user *, shmaddr)
 {
+	shmaddr = untagged_addr(shmaddr);
 	return ksys_shmdt(shmaddr);
 }
 
diff --git a/mm/madvise.c b/mm/madvise.c
index 21a7881a2db4..64e6d34a7f9b 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -809,6 +809,8 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
 	size_t len;
 	struct blk_plug plug;
 
+	start = untagged_addr(start);
+
 	if (!madvise_behavior_valid(behavior))
 		return error;
 
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index ee2bce59d2bf..0b5d5f794f4e 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1334,6 +1334,7 @@ static long kernel_mbind(unsigned long start, unsigned long len,
 	int err;
 	unsigned short mode_flags;
 
+	start = untagged_addr(start);
 	mode_flags = mode & MPOL_MODE_FLAGS;
 	mode &= ~MPOL_MODE_FLAGS;
 	if (mode >= MPOL_MAX)
@@ -1491,6 +1492,8 @@ static int kernel_get_mempolicy(int __user *policy,
 	int uninitialized_var(pval);
 	nodemask_t nodes;
 
+	addr = untagged_addr(addr);
+
 	if (nmask != NULL && maxnode < nr_node_ids)
 		return -EINVAL;
 
@@ -1576,6 +1579,8 @@ COMPAT_SYSCALL_DEFINE6(mbind, compat_ulong_t, start, compat_ulong_t, len,
 	unsigned long nr_bits, alloc_size;
 	nodemask_t bm;
 
+	start = untagged_addr(start);
+
 	nr_bits = min_t(unsigned long, maxnode-1, MAX_NUMNODES);
 	alloc_size = ALIGN(nr_bits, BITS_PER_LONG) / 8;
 
diff --git a/mm/migrate.c b/mm/migrate.c
index d4fd680be3b0..b9f414e66af1 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1601,6 +1601,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 		if (get_user(node, nodes + i))
 			goto out_flush;
 		addr = (unsigned long)p;
+		addr = untagged_addr(addr);
 
 		err = -ENODEV;
 		if (node < 0 || node >= MAX_NUMNODES)
diff --git a/mm/mincore.c b/mm/mincore.c
index 218099b5ed31..c4a3f4484b6b 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -228,6 +228,8 @@ SYSCALL_DEFINE3(mincore, unsigned long, start, size_t, len,
 	unsigned long pages;
 	unsigned char *tmp;
 
+	start = untagged_addr(start);
+
 	/* Check the start address: needs to be page-aligned.. */
 	if (start & ~PAGE_MASK)
 		return -EINVAL;
diff --git a/mm/mlock.c b/mm/mlock.c
index 41cc47e28ad6..8fa29e7c0e73 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -715,6 +715,7 @@ static __must_check int do_mlock(unsigned long start, size_t len, vm_flags_t fla
 
 SYSCALL_DEFINE2(mlock, unsigned long, start, size_t, len)
 {
+	start = untagged_addr(start);
 	return do_mlock(start, len, VM_LOCKED);
 }
 
@@ -722,6 +723,8 @@ SYSCALL_DEFINE3(mlock2, unsigned long, start, size_t, len, int, flags)
 {
 	vm_flags_t vm_flags = VM_LOCKED;
 
+	start = untagged_addr(start);
+
 	if (flags & ~MLOCK_ONFAULT)
 		return -EINVAL;
 
@@ -735,6 +738,8 @@ SYSCALL_DEFINE2(munlock, unsigned long, start, size_t, len)
 {
 	int ret;
 
+	start = untagged_addr(start);
+
 	len = PAGE_ALIGN(len + (offset_in_page(start)));
 	start &= PAGE_MASK;
 
diff --git a/mm/mmap.c b/mm/mmap.c
index f901065c4c64..fc8e908a97ba 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -199,6 +199,8 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 	bool downgraded = false;
 	LIST_HEAD(uf);
 
+	brk = untagged_addr(brk);
+
 	if (down_write_killable(&mm->mmap_sem))
 		return -EINTR;
 
@@ -1571,6 +1573,8 @@ unsigned long ksys_mmap_pgoff(unsigned long addr, unsigned long len,
 	struct file *file = NULL;
 	unsigned long retval;
 
+	addr = untagged_addr(addr);
+
 	if (!(flags & MAP_ANONYMOUS)) {
 		audit_mmap_fd(fd, flags);
 		file = fget(fd);
@@ -2869,6 +2873,7 @@ EXPORT_SYMBOL(vm_munmap);
 
 SYSCALL_DEFINE2(munmap, unsigned long, addr, size_t, len)
 {
+	addr = untagged_addr(addr);
 	profile_munmap(addr);
 	return __vm_munmap(addr, len, true);
 }
@@ -2887,6 +2892,8 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 	unsigned long ret = -EINVAL;
 	struct file *file;
 
+	start = untagged_addr(start);
+
 	pr_warn_once("%s (%d) uses deprecated remap_file_pages() syscall. See Documentation/vm/remap_file_pages.rst.\n",
 		     current->comm, current->pid);
 
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 36cb358db170..9d79594dabee 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -578,6 +578,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 SYSCALL_DEFINE3(mprotect, unsigned long, start, size_t, len,
 		unsigned long, prot)
 {
+	start = untagged_addr(start);
 	return do_mprotect_pkey(start, len, prot, -1);
 }
 
@@ -586,6 +587,7 @@ SYSCALL_DEFINE3(mprotect, unsigned long, start, size_t, len,
 SYSCALL_DEFINE4(pkey_mprotect, unsigned long, start, size_t, len,
 		unsigned long, prot, int, pkey)
 {
+	start = untagged_addr(start);
 	return do_mprotect_pkey(start, len, prot, pkey);
 }
 
diff --git a/mm/mremap.c b/mm/mremap.c
index 3320616ed93f..cd0e79c6ce63 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -588,6 +588,8 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 	LIST_HEAD(uf_unmap_early);
 	LIST_HEAD(uf_unmap);
 
+	addr = untagged_addr(addr);
+
 	if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE))
 		return ret;
 
diff --git a/mm/msync.c b/mm/msync.c
index ef30a429623a..c3bd3e75f687 100644
--- a/mm/msync.c
+++ b/mm/msync.c
@@ -37,6 +37,8 @@ SYSCALL_DEFINE3(msync, unsigned long, start, size_t, len, int, flags)
 	int unmapped_error = 0;
 	int error = -EINVAL;
 
+	start = untagged_addr(start);
+
 	if (flags & ~(MS_ASYNC | MS_INVALIDATE | MS_SYNC))
 		goto out;
 	if (offset_in_page(start))
-- 
2.21.0.rc0.258.g878e2cd30e-goog
