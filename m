Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7C3C433EF
	for <linux-arch@archiver.kernel.org>; Wed,  8 Dec 2021 20:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240270AbhLHUaE (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 8 Dec 2021 15:30:04 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:36914 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240268AbhLHUaE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Dec 2021 15:30:04 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:44574)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mv3WJ-004DBq-4D; Wed, 08 Dec 2021 13:26:31 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:39446 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mv3WH-00CjR6-CY; Wed, 08 Dec 2021 13:26:30 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Wed,  8 Dec 2021 14:25:28 -0600
Message-Id: <20211208202532.16409-6-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1mv3WH-00CjR6-CY;;;mid=<20211208202532.16409-6-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19fPqOMa5QVsjU3osyQefs3B3Wwj6X8s2g=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 06/10] exit: Implement kthread_exit
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The way the per task_struct exit_code is used by kernel threads is not
quite compatible how it is used by userspace applications.  The low
byte of the userspace exit_code value encodes the exit signal.  While
kthreads just use the value as an int holding ordinary kernel function
exit status like -EPERM.

Add kthread_exit to clearly separate the two kinds of uses.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/kthread.h |  1 +
 kernel/kthread.c        | 23 +++++++++++++++++++----
 tools/objtool/check.c   |  1 +
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index 346b0f269161..22c43d419687 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -70,6 +70,7 @@ void *kthread_probe_data(struct task_struct *k);
 int kthread_park(struct task_struct *k);
 void kthread_unpark(struct task_struct *k);
 void kthread_parkme(void);
+void kthread_exit(long result) __noreturn;
 
 int kthreadd(void *unused);
 extern struct task_struct *kthreadd_task;
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 7113003fab63..77b7c3f23f18 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -268,6 +268,21 @@ void kthread_parkme(void)
 }
 EXPORT_SYMBOL_GPL(kthread_parkme);
 
+/**
+ * kthread_exit - Cause the current kthread return @result to kthread_stop().
+ * @result: The integer value to return to kthread_stop().
+ *
+ * While kthread_exit can be called directly, it exists so that
+ * functions which do some additional work in non-modular code such as
+ * module_put_and_kthread_exit can be implemented.
+ *
+ * Does not return.
+ */
+void __noreturn kthread_exit(long result)
+{
+	do_exit(result);
+}
+
 static int kthread(void *_create)
 {
 	static const struct sched_param param = { .sched_priority = 0 };
@@ -286,13 +301,13 @@ static int kthread(void *_create)
 	done = xchg(&create->done, NULL);
 	if (!done) {
 		kfree(create);
-		do_exit(-EINTR);
+		kthread_exit(-EINTR);
 	}
 
 	if (!self) {
 		create->result = ERR_PTR(-ENOMEM);
 		complete(done);
-		do_exit(-ENOMEM);
+		kthread_exit(-ENOMEM);
 	}
 
 	self->threadfn = threadfn;
@@ -326,7 +341,7 @@ static int kthread(void *_create)
 		__kthread_parkme(self);
 		ret = threadfn(data);
 	}
-	do_exit(ret);
+	kthread_exit(ret);
 }
 
 /* called from kernel_clone() to get node information for about to be created task */
@@ -627,7 +642,7 @@ EXPORT_SYMBOL_GPL(kthread_park);
  * instead of calling wake_up_process(): the thread will exit without
  * calling threadfn().
  *
- * If threadfn() may call do_exit() itself, the caller must ensure
+ * If threadfn() may call kthread_exit() itself, the caller must ensure
  * task_struct can't go away.
  *
  * Returns the result of threadfn(), or %-EINTR if wake_up_process()
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e6ab5687770b..90108fe5610d 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -168,6 +168,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"panic",
 		"do_exit",
 		"do_task_dead",
+		"kthread_exit",
 		"make_task_dead",
 		"__module_put_and_exit",
 		"complete_and_exit",
-- 
2.29.2

