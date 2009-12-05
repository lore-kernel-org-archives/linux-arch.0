From: Al Viro <viro@ftp.linux.org.uk>
Subject: [RFC][PATCH 10/18] Kill ancient crap in s390 compat mmap
Date: Sat, 05 Dec 2009 19:08:50 +0000
Message-ID: <E1NGzzv-0008Rf-0U@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:41317 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754075AbZLEUQT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 5 Dec 2009 15:16:19 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org


We've had TASK_SIZE set to 1<<31 for 31bit tasks since May 2004.
Before that old32_mmap() had to deal with do_mmap_pgoff() giving
it an address out of range.  It had tried to do that by checking
return value and doing do_munmap() (at wrong address, BTW).

IOW, that code had been dead for 5.5 years (and bogus - for 8).
Kill.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/s390/kernel/compat_linux.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kernel/compat_linux.c b/arch/s390/kernel/compat_linux.c
index 0debcec..c5a9fba 100644
--- a/arch/s390/kernel/compat_linux.c
+++ b/arch/s390/kernel/compat_linux.c
@@ -701,11 +701,6 @@ static inline long do_mmap2(
 
 	down_write(&current->mm->mmap_sem);
 	error = do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
-	if (!IS_ERR((void *) error) && error + len >= 0x80000000ULL) {
-		/* Result is out of bounds.  */
-		do_munmap(current->mm, addr, len);
-		error = -ENOMEM;
-	}
 	up_write(&current->mm->mmap_sem);
 
 	if (file)
-- 
1.5.6.5
