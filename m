Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:47000 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754143AbeENRPd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 14 May 2018 13:15:33 -0400
From: Dave Martin <Dave.Martin@arm.com>
Subject: [RFC PATCH 08/11] ia64: Remove unused task argument from prctl functions
Date: Mon, 14 May 2018 18:14:24 +0100
Message-ID: <1526318067-4964-9-git-send-email-Dave.Martin@arm.com>
In-Reply-To: <1526318067-4964-1-git-send-email-Dave.Martin@arm.com>
References: <1526318067-4964-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Message-ID: <20180514171424.aFyVRYab-NxahoSEO0TGu_LHotE0OEFHp1pYbPNXCK4@z>

Some ia64-specific prctl backends take a task argument that is
redundant, since the only thing ever passed is "current".

This patch gets rid of the redundant arguments.

No functional change.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/ia64/include/asm/processor.h | 8 ++++----
 kernel/sys.c                      | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/ia64/include/asm/processor.h b/arch/ia64/include/asm/processor.h
index 10061ccf..0489b80 100644
--- a/arch/ia64/include/asm/processor.h
+++ b/arch/ia64/include/asm/processor.h
@@ -259,15 +259,15 @@ typedef struct {
 		 (int __user *) (addr));							\
 })
 
-#define SET_FPEMU_CTL(task,value)								\
+#define SET_FPEMU_CTL(value)									\
 ({												\
-	(task)->thread.flags = (((task)->thread.flags & ~IA64_THREAD_FPEMU_MASK)		\
+	current->thread.flags = ((current->thread.flags & ~IA64_THREAD_FPEMU_MASK)		\
 			  | (((value) << IA64_THREAD_FPEMU_SHIFT) & IA64_THREAD_FPEMU_MASK));	\
 	0;											\
 })
-#define GET_FPEMU_CTL(task,addr)								\
+#define GET_FPEMU_CTL(addr)									\
 ({												\
-	put_user(((task)->thread.flags & IA64_THREAD_FPEMU_MASK) >> IA64_THREAD_FPEMU_SHIFT,	\
+	put_user((current->thread.flags & IA64_THREAD_FPEMU_MASK) >> IA64_THREAD_FPEMU_SHIFT,	\
 		 (int __user *) (addr));							\
 })
 
diff --git a/kernel/sys.c b/kernel/sys.c
index b154561..5549505 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -78,10 +78,10 @@
 # define GET_UNALIGN_CTL(a, b)	(-EINVAL)
 #endif
 #ifndef SET_FPEMU_CTL
-# define SET_FPEMU_CTL(a, b)	(-EINVAL)
+# define SET_FPEMU_CTL(a)	(-EINVAL)
 #endif
 #ifndef GET_FPEMU_CTL
-# define GET_FPEMU_CTL(a, b)	(-EINVAL)
+# define GET_FPEMU_CTL(a)	(-EINVAL)
 #endif
 
 /*
@@ -2247,10 +2247,10 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 		error = GET_UNALIGN_CTL(me, arg2);
 		break;
 	case PR_SET_FPEMU:
-		error = SET_FPEMU_CTL(me, arg2);
+		error = SET_FPEMU_CTL(arg2);
 		break;
 	case PR_GET_FPEMU:
-		error = GET_FPEMU_CTL(me, arg2);
+		error = GET_FPEMU_CTL(arg2);
 		break;
 	case PR_GET_TIMING:
 		error = PR_TIMING_STATISTICAL;
-- 
2.1.4
