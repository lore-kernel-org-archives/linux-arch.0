From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [RFC PATCH REBASED 3/3] sched: Remove ARCH specific fpu_counter from task_struct
Date: Tue, 17 Sep 2013 11:47:19 +0530
Message-ID: <1379398639-27403-4-git-send-email-vgupta@synopsys.com>
References: <1379398639-27403-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1379398639-27403-1-git-send-email-vgupta@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

fpu_counter in task_struct was used only by sh/x86.
Both of these now carry it in ARCH specific thread_struct, hence this
can now be removed from generic task_struct, shrinking it slightly for
other arches.

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/sched.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 6682da3..78386c1 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1046,15 +1046,6 @@ struct task_struct {
 	struct hlist_head preempt_notifiers;
 #endif
 
-	/*
-	 * fpu_counter contains the number of consecutive context switches
-	 * that the FPU is used. If this is over a threshold, the lazy fpu
-	 * saving becomes unlazy to save the trap. This is an unsigned char
-	 * so that after 256 times the counter wraps and the behavior turns
-	 * lazy again; this to deal with bursty apps that only use FPU for
-	 * a short time
-	 */
-	unsigned char fpu_counter;
 #ifdef CONFIG_BLK_DEV_IO_TRACE
 	unsigned int btrace_seq;
 #endif
-- 
1.8.1.2
