Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:48015 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932544AbWACVHl
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 3 Jan 2006 16:07:41 -0500
Subject: [PATCH 42/50] cris: fix KSTK_EIP
Message-Id: <E1EttNb-0008Ro-Ah@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 21:07:39 +0000
Sender: linux-arch-owner@vger.kernel.org
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

References: <20060103210515.5135@ftp.linux.org.uk>
In-Reply-To: <20060103210515.5135@ftp.linux.org.uk>

cris KSTK_EIP looked for pt_regs at the right offset but from the wrong
place - forgotten ->thread_info

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 include/asm-cris/arch-v10/processor.h |    2 +-
 include/asm-cris/arch-v32/processor.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

e176ef05ac06736721f63f36f7bebae153aa36e6
diff --git a/include/asm-cris/arch-v10/processor.h b/include/asm-cris/arch-v10/processor.h
index e23df8d..cc692c7 100644
--- a/include/asm-cris/arch-v10/processor.h
+++ b/include/asm-cris/arch-v10/processor.h
@@ -40,7 +40,7 @@ struct thread_struct {
 #define KSTK_EIP(tsk)	\
 ({			\
 	unsigned long eip = 0;   \
-	unsigned long regs = (unsigned long)user_regs(tsk); \
+	unsigned long regs = (unsigned long)task_pt_regs(tsk); \
 	if (regs > PAGE_SIZE && \
 		virt_addr_valid(regs)) \
 	eip = ((struct pt_regs *)regs)->irp; \
diff --git a/include/asm-cris/arch-v32/processor.h b/include/asm-cris/arch-v32/processor.h
index 8c939bf..32bf2e5 100644
--- a/include/asm-cris/arch-v32/processor.h
+++ b/include/asm-cris/arch-v32/processor.h
@@ -36,7 +36,7 @@ struct thread_struct {
 #define KSTK_EIP(tsk)		\
 ({				\
 	unsigned long eip = 0;	\
-	unsigned long regs = (unsigned long)user_regs(tsk); \
+	unsigned long regs = (unsigned long)task_pt_regs(tsk); \
 	if (regs > PAGE_SIZE && virt_addr_valid(regs))	    \
 		eip = ((struct pt_regs *)regs)->erp;	    \
 	eip; \
-- 
0.99.9.GIT

