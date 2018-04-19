Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50452 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750964AbeDSGpJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 19 Apr 2018 02:45:09 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3J6YMXE017335
        for <linux-arch@vger.kernel.org>; Thu, 19 Apr 2018 02:45:08 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2hemtcke31-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 19 Apr 2018 02:45:08 -0400
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Thu, 19 Apr 2018 07:45:06 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [RFC][PATCH] s390: add arch_change_pid for arch updates after task pid change
Date: Thu, 19 Apr 2018 08:44:46 +0200
Message-Id: <1524120286-19066-1-git-send-email-schwidefsky@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>

The s390 architecture uses the task pid to tag the samples stored
by the sampling facility. The user space tool can use the tag to
distinguish the samples of different tasks. The pid is announced
to the sampling facility with the LPP instruction, the update of
the tag is done in __switch_to().

In a multi-threaded program any thread can call execve(). If this
is not done by the thread group leader, the de_thread() function
replaces the pid of the task that calls execve() with the pid of
thread group leader. If the task reaches user space again without
going over __switch_to() the sampling tag is still set to the old
pid.

Add the arch_change_pid function to re-issue the LPP to set the
new pid for the task in case of a thread ground leader change.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 arch/s390/include/asm/thread_info.h |  2 ++
 arch/s390/kernel/process.c          | 10 ++++++++++
 kernel/pid.c                        |  5 +++++
 3 files changed, 17 insertions(+)

diff --git a/arch/s390/include/asm/thread_info.h b/arch/s390/include/asm/thread_info.h
index 83ba575..6f99b2f 100644
--- a/arch/s390/include/asm/thread_info.h
+++ b/arch/s390/include/asm/thread_info.h
@@ -42,6 +42,8 @@ struct thread_info {
 	.flags		= 0,			\
 }
 
+enum pid_type;
+void arch_change_pid(struct task_struct *task, enum pid_type type);
 void arch_release_task_struct(struct task_struct *tsk);
 int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
 
diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
index 70576a2..1a716e7 100644
--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -29,6 +29,7 @@
 #include <linux/random.h>
 #include <linux/export.h>
 #include <linux/init_task.h>
+#include <asm/cpu_mf.h>
 #include <asm/io.h>
 #include <asm/processor.h>
 #include <asm/vtimer.h>
@@ -68,6 +69,15 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 	return 0;
 }
 
+void arch_change_pid(struct task_struct *task, enum pid_type type)
+{
+	if (type == PIDTYPE_PID && task == current) {
+		S390_lowcore.current_pid = current->pid;
+		if (test_facility(40))
+			lpp(&S390_lowcore.lpp);
+	}
+}
+
 int copy_thread_tls(unsigned long clone_flags, unsigned long new_stackp,
 		    unsigned long arg, struct task_struct *p, unsigned long tls)
 {
diff --git a/kernel/pid.c b/kernel/pid.c
index 157fe4b..d38ac18 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -299,11 +299,16 @@ void detach_pid(struct task_struct *task, enum pid_type type)
 	__change_pid(task, type, NULL);
 }
 
+void __weak arch_change_pid(struct task_struct *task, enum pid_type type)
+{
+}
+
 void change_pid(struct task_struct *task, enum pid_type type,
 		struct pid *pid)
 {
 	__change_pid(task, type, pid);
 	attach_pid(task, type);
+	arch_change_pid(task, type);
 }
 
 /* transfer_pid is an optimization of attach_pid(new), detach_pid(old) */
-- 
2.7.4
