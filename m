From: Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] thread_info: include <current.h> for THREAD_INFO_IN_TASK (WAS: [PATCH 2/3] sched/preempt: include asm/current.h)
Date: Fri, 14 Oct 2016 11:42:25 +0100
Message-ID: <1476441745-10765-1-git-send-email-mark.rutland@arm.com>
References: <20161014081638.GA4047@osiris>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:34376 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752378AbcJNKm4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 14 Oct 2016 06:42:56 -0400
In-Reply-To: <20161014081638.GA4047@osiris>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Mark Rutland <mark.rutland@arm.com>

When CONFIG_THREAD_INFO_IN_TASK is selected, the current_thread_info()
macro relies on current having been defined prior to its use. However,
not all users of current_thread_info() include <asm/current.h>, and thus
current is not guaranteed to be defined.

When CONFIG_THREAD_INFO_IN_TASK is not selected, it's possible that
get_current() / current are based upon current_thread_info(), and
<asm/current.h> includes <asm/thread_info.h>. Thus always including
<asm/current.h> would result in circular dependences on some platforms.

To ensure both cases work, this patch includes <asm/current.h>, but only
when CONFIG_THREAD_INFO_IN_TASK is selected.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 include/linux/thread_info.h | 1 +
 1 file changed, 1 insertion(+)

As discussed, it would be great if this could go in along with the patch to
make thread_info arch-specific again, to make merging the arch-specific parts
easier (for arm64 and s390).

Mark.

diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index 45f004e..521f84b 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -25,6 +25,7 @@ struct thread_info {
 #endif
 
 #ifdef CONFIG_THREAD_INFO_IN_TASK
+#include <asm/current.h>
 #define current_thread_info() ((struct thread_info *)current)
 #endif
 
-- 
1.9.1
