From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: PAGE_ALIGN() compile breakage
Date: Fri, 25 Jul 2008 02:34:55 -0700
Message-ID: <20080725023455.dde3eb27.akpm@linux-foundation.org>
References: <20080725083943.GC19310@cs181140183.pp.htv.fi>
	<20080725015537.564e3397.akpm@linux-foundation.org>
	<20080725091455.GD19310@cs181140183.pp.htv.fi>
	<20080725092748.GF19310@cs181140183.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33282 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755159AbYGYJfg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 25 Jul 2008 05:35:36 -0400
In-Reply-To: <20080725092748.GF19310@cs181140183.pp.htv.fi>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Adrian Bunk <bunk@kernel.org>
Cc: Andrea Righi <righi.andrea@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 25 Jul 2008 12:27:48 +0300 Adrian Bunk <bunk@kernel.org> wrote:

> Further testing revealed that you should choose a file that also gets 
> compiled on MMU-less architectures:

We don't have one :(

I guess util.c will have to do.

diff -puN include/linux/sched.h~uninline-arch_pick_mmap_layout include/linux/sched.h
--- a/include/linux/sched.h~uninline-arch_pick_mmap_layout
+++ a/include/linux/sched.h
@@ -2139,16 +2139,7 @@ static inline void set_task_cpu(struct t
 
 #endif /* CONFIG_SMP */
 
-#ifdef HAVE_ARCH_PICK_MMAP_LAYOUT
 extern void arch_pick_mmap_layout(struct mm_struct *mm);
-#else
-static inline void arch_pick_mmap_layout(struct mm_struct *mm)
-{
-	mm->mmap_base = TASK_UNMAPPED_BASE;
-	mm->get_unmapped_area = arch_get_unmapped_area;
-	mm->unmap_area = arch_unmap_area;
-}
-#endif
 
 #ifdef CONFIG_TRACING
 extern void
diff -puN mm/util.c~uninline-arch_pick_mmap_layout mm/util.c
--- a/mm/util.c~uninline-arch_pick_mmap_layout
+++ a/mm/util.c
@@ -1,3 +1,4 @@
+#include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/module.h>
@@ -160,3 +161,12 @@ char *strndup_user(const char __user *s,
 	return p;
 }
 EXPORT_SYMBOL(strndup_user);
+
+#ifndef HAVE_ARCH_PICK_MMAP_LAYOUT
+void arch_pick_mmap_layout(struct mm_struct *mm)
+{
+	mm->mmap_base = TASK_UNMAPPED_BASE;
+	mm->get_unmapped_area = arch_get_unmapped_area;
+	mm->unmap_area = arch_unmap_area;
+}
+#endif
_


We should make arch_pick_mmap_layout __weak and nuke that ifdef.
