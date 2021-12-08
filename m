Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8CFC433FE
	for <linux-arch@archiver.kernel.org>; Wed,  8 Dec 2021 20:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240286AbhLHUaS (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 8 Dec 2021 15:30:18 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:36988 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240290AbhLHUaR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Dec 2021 15:30:17 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:44904)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mv3WW-004DD5-97; Wed, 08 Dec 2021 13:26:44 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:39446 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mv3WU-00CjR6-Sr; Wed, 08 Dec 2021 13:26:43 -0700
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
Date:   Wed,  8 Dec 2021 14:25:32 -0600
Message-Id: <20211208202532.16409-10-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1mv3WU-00CjR6-Sr;;;mid=<20211208202532.16409-10-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19UJIRM3fakm3QCfFZtxnTkDumBrYlYS6s=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 10/10] exit/kthread: Move the exit code for kernel threads into struct kthread
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The exit code of kernel threads has different semantics than the
exit_code of userspace tasks.  To avoid confusion and allow
the userspace implementation to change as needed move
the kernel thread exit code into struct kthread.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/kthread.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index 8e5f44bed027..9c6c532047c4 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -52,6 +52,7 @@ struct kthread_create_info
 struct kthread {
 	unsigned long flags;
 	unsigned int cpu;
+	int result;
 	int (*threadfn)(void *);
 	void *data;
 	mm_segment_t oldfs;
@@ -287,7 +288,9 @@ EXPORT_SYMBOL_GPL(kthread_parkme);
  */
 void __noreturn kthread_exit(long result)
 {
-	do_exit(result);
+	struct kthread *kthread = to_kthread(current);
+	kthread->result = result;
+	do_exit(0);
 }
 
 /**
@@ -679,7 +682,7 @@ int kthread_stop(struct task_struct *k)
 	kthread_unpark(k);
 	wake_up_process(k);
 	wait_for_completion(&kthread->exited);
-	ret = k->exit_code;
+	ret = kthread->result;
 	put_task_struct(k);
 
 	trace_sched_kthread_stop_ret(ret);
-- 
2.29.2

