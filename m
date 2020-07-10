Return-Path: <SRS0=GDSS=AV=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbgGJN5U (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Jul 2020 09:57:20 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 6/6] exec: use force_uaccess_begin during exec and exit
Date: Fri, 10 Jul 2020 15:57:06 +0200
Message-ID: <20200710135706.537715-7-hch@lst.de>
In-Reply-To: <20200710135706.537715-1-hch@lst.de>
References: <20200710135706.537715-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20200710135706.-Wv83JNsfQOit0wmxrrytgKnBXZFwdSX-8tPc9C07f0@z>

Both exec and exit want to ensure that the uaccess routines actually do
access user pointers.  Use the newly added force_uaccess_begin helper
instead of an open coded set_fs for that to prepare for kernel builds
where set_fs() does not exist.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/exec.c     | 7 ++++++-
 kernel/exit.c | 2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index e6e8a9a7032784..769af470b69124 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1380,7 +1380,12 @@ int begin_new_exec(struct linux_binprm * bprm)
 	if (retval)
 		goto out_unlock;
 
-	set_fs(USER_DS);
+	/*
+	 * Ensure that the uaccess routines can actually operate on userspace
+	 * pointers:
+	 */
+	force_uaccess_begin();
+
 	me->flags &= ~(PF_RANDOMIZE | PF_FORKNOEXEC | PF_KTHREAD |
 					PF_NOFREEZE | PF_NO_SETAFFINITY);
 	flush_thread();
diff --git a/kernel/exit.c b/kernel/exit.c
index 727150f2810338..17d486a20f0dc6 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -731,7 +731,7 @@ void __noreturn do_exit(long code)
 	 * mm_release()->clear_child_tid() from writing to a user-controlled
 	 * kernel address.
 	 */
-	set_fs(USER_DS);
+	force_uaccess_begin();
 
 	if (unlikely(in_atomic())) {
 		pr_info("note: %s[%d] exited with preempt_count %d\n",
-- 
2.26.2
