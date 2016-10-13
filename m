Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58421 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755522AbcJMTMb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 13 Oct 2016 15:12:31 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id u9DBrlIo086564
        for <linux-arch@vger.kernel.org>; Thu, 13 Oct 2016 07:57:19 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 26240wg4n3-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 13 Oct 2016 07:57:18 -0400
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Thu, 13 Oct 2016 12:57:16 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH 1/3] sched/core,x86: make struct thread_info arch specific again
Date: Thu, 13 Oct 2016 13:57:10 +0200
In-Reply-To: <20161013115712.29517-1-heiko.carstens@de.ibm.com>
References: <20161013115712.29517-1-heiko.carstens@de.ibm.com>
Message-ID: <20161013115712.29517-2-heiko.carstens@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
Message-ID: <20161013115710.TQOnwcCfiTewPjTmb2Opk_ujSLkLqW-re6AmGqkESI0@z>

commit c65eacbe290b ("sched/core: Allow putting thread_info into
task_struct") made struct thread_info a generic struct with only a
single flags member if THREAD_INFO_IN_TASK_STRUCT is selected.

This change however seems to be quite x86 centric, since at least the
generic preemption code (asm-generic/preempt.h) assumes that struct
thread_info also has a preempt_count member, which apparently was not
true for x86.

We could add a bit more ifdefs to solve this problem too, but it seems
to be much simpler to make struct thread_info arch specific
again. This also makes the conversion to THREAD_INFO_IN_TASK_STRUCT a
bit easier for architectures that have a couple of arch specific stuff
in their thread_info definition.

The arch specific stuff _could_ be moved to thread_struct. However
keeping them in thread_info makes it easier: accessing thread_info
members is simple, since it is at the beginning of the task_struct,
while the thread_struct is at the end. At least on s390 the offsets
needed to access members of the thread_struct (with task_struct as
base) are too large for various asm instructions.  This is not a
problem when keeping these members within thread_info.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 arch/x86/include/asm/thread_info.h |  9 +++++++++
 include/linux/thread_info.h        | 11 -----------
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 2aaca53c0974..ad6f5eb07a95 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -52,6 +52,15 @@ struct task_struct;
 #include <asm/cpufeature.h>
 #include <linux/atomic.h>
 
+struct thread_info {
+	unsigned long		flags;		/* low level flags */
+};
+
+#define INIT_THREAD_INFO(tsk)			\
+{						\
+	.flags		= 0,			\
+}
+
 #define init_stack		(init_thread_union.stack)
 
 #else /* !__ASSEMBLY__ */
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index 45f004e9cc59..2873baf5372a 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -14,17 +14,6 @@ struct timespec;
 struct compat_timespec;
 
 #ifdef CONFIG_THREAD_INFO_IN_TASK
-struct thread_info {
-	unsigned long		flags;		/* low level flags */
-};
-
-#define INIT_THREAD_INFO(tsk)			\
-{						\
-	.flags		= 0,			\
-}
-#endif
-
-#ifdef CONFIG_THREAD_INFO_IN_TASK
 #define current_thread_info() ((struct thread_info *)current)
 #endif
 
-- 
2.8.4

