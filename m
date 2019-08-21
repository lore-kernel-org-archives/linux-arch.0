Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:33452 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729657AbfHUQrp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Aug 2019 12:47:45 -0400
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v9 1/3] mm: untag user pointers in mmap/munmap/mremap/brk
Date: Wed, 21 Aug 2019 17:47:28 +0100
Message-ID: <20190821164730.47450-2-catalin.marinas@arm.com>
In-Reply-To: <20190821164730.47450-1-catalin.marinas@arm.com>
References: <20190821164730.47450-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Will Deacon <will@kernel.org>, Andrey Konovalov <andreyknvl@google.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Dave P Martin <Dave.Martin@arm.com>, Dave Hansen <dave.hansen@intel.com>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20190821164728.F-0dMyV2LyrRHsuKmcpOjUL-IZbq2Exy36dxyI-j0zk@z>

There isn't a good reason to differentiate between the user address
space layout modification syscalls and the other memory
permission/attributes ones (e.g. mprotect, madvise) w.r.t. the tagged
address ABI. Untag the user addresses on entry to these functions.

Acked-by: Will Deacon <will@kernel.org>
Acked-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 mm/mmap.c   | 5 +++++
 mm/mremap.c | 6 +-----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 7e8c3e8ae75f..b766b633b7ae 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -201,6 +201,8 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 	bool downgraded = false;
 	LIST_HEAD(uf);
 
+	brk = untagged_addr(brk);
+
 	if (down_write_killable(&mm->mmap_sem))
 		return -EINTR;
 
@@ -1573,6 +1575,8 @@ unsigned long ksys_mmap_pgoff(unsigned long addr, unsigned long len,
 	struct file *file = NULL;
 	unsigned long retval;
 
+	addr = untagged_addr(addr);
+
 	if (!(flags & MAP_ANONYMOUS)) {
 		audit_mmap_fd(fd, flags);
 		file = fget(fd);
@@ -2874,6 +2878,7 @@ EXPORT_SYMBOL(vm_munmap);
 
 SYSCALL_DEFINE2(munmap, unsigned long, addr, size_t, len)
 {
+	addr = untagged_addr(addr);
 	profile_munmap(addr);
 	return __vm_munmap(addr, len, true);
 }
diff --git a/mm/mremap.c b/mm/mremap.c
index 64c9a3b8be0a..1fc8a29fbe3f 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -606,12 +606,8 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 	LIST_HEAD(uf_unmap_early);
 	LIST_HEAD(uf_unmap);
 
-	/*
-	 * Architectures may interpret the tag passed to mmap as a background
-	 * colour for the corresponding vma. For mremap we don't allow tagged
-	 * new_addr to preserve similar behaviour to mmap.
-	 */
 	addr = untagged_addr(addr);
+	new_addr = untagged_addr(new_addr);
 
 	if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE))
 		return ret;
