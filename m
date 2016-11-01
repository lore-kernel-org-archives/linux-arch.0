Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:45616 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S947970AbcKAAIb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 31 Oct 2016 20:08:31 -0400
From: Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] mm: only enable sys_pkey* when ARCH_HAS_PKEYS
Date: Tue,  1 Nov 2016 00:08:24 +0000
Message-ID: <1477958904-9903-1-git-send-email-mark.rutland@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Hansen <dave.hansen@linux.intel.com>, Mel Gorman <mgorman@techsingularity.net>, Russell King <rmk+kernel@armlinux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, torvalds@linux-foundation.org
Message-ID: <20161101000824.GLCtWJ0l_BV2U4ATlSXlqy5zsIxNhNWVaEdkVuOgwZI@z>

When an architecture does not select CONFIG_ARCH_HAS_PKEYS, the pkey_alloc
syscall will return -ENOSPC for all (otherwise well-formed) requests, as the
generic implementation of mm_pkey_alloc() returns -1. The other pkey syscalls
perform some work before always failing, in a similar fashion.

This implies the absence of keys, but otherwise functional pkey support. This
is odd, since the architecture provides no such support. Instead, it would be
preferable to indicate that the syscall is not implemented, since this is
effectively the case.

This patch updates the pkey_* syscalls to return -ENOSYS on architectures
without pkey support.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-api@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: torvalds@linux-foundation.org
---
 mm/mprotect.c | 9 +++++++++
 1 file changed, 9 insertions(+)

Hi,

In eyeballing some recent commits I spotted 6127d124ee4eb9c3 ("ARM: wire up new
pkey syscalls"), and in looking into that, I realised that the common pkey code
looks somewhat suspicious.

Many architectures don't have user-modifiable pkey support, and for those, we
perform some unnecessary work before returning unclear error codes.

As the pkey went in this merge window, there's stil time to tighten that up.

Thanks,
Mark.

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 1193652..cda3abf 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -487,6 +487,9 @@ SYSCALL_DEFINE3(mprotect, unsigned long, start, size_t, len,
 SYSCALL_DEFINE4(pkey_mprotect, unsigned long, start, size_t, len,
 		unsigned long, prot, int, pkey)
 {
+	if (!IS_ENABLED(CONFIG_ARCH_HAS_PKEYS))
+		return -ENOSYS;
+
 	return do_mprotect_pkey(start, len, prot, pkey);
 }
 
@@ -495,6 +498,9 @@ SYSCALL_DEFINE2(pkey_alloc, unsigned long, flags, unsigned long, init_val)
 	int pkey;
 	int ret;
 
+	if (!IS_ENABLED(CONFIG_ARCH_HAS_PKEYS))
+		return -ENOSYS;
+
 	/* No flags supported yet. */
 	if (flags)
 		return -EINVAL;
@@ -524,6 +530,9 @@ SYSCALL_DEFINE1(pkey_free, int, pkey)
 {
 	int ret;
 
+	if (!IS_ENABLED(CONFIG_ARCH_HAS_PKEYS))
+		return -ENOSYS;
+
 	down_write(&current->mm->mmap_sem);
 	ret = mm_pkey_free(current->mm, pkey);
 	up_write(&current->mm->mmap_sem);
-- 
2.7.4

