Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2E5C433FE
	for <linux-arch@archiver.kernel.org>; Wed,  8 Dec 2021 20:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240248AbhLHU36 (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 8 Dec 2021 15:29:58 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:39984 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240246AbhLHU35 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Dec 2021 15:29:57 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:46716)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mv3WC-00GaO3-B9; Wed, 08 Dec 2021 13:26:24 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:39446 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mv3WA-00CjR6-Qr; Wed, 08 Dec 2021 13:26:23 -0700
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
Date:   Wed,  8 Dec 2021 14:25:26 -0600
Message-Id: <20211208202532.16409-4-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1mv3WA-00CjR6-Qr;;;mid=<20211208202532.16409-4-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19k2KsadM27boh2TGtU3PkWIqUfnIUyAbw=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 04/10] exit: Stop poorly open coding do_task_dead in make_task_dead
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When the kernel detects it is oops or otherwise force killing a task
while it exits the code poorly attempts to permanently stop the task
from scheduling.

I say poorly because it is possible for a task in TASK_UINTERRUPTIBLE
to be woken up.

As it makes no sense for the task to continue call do_task_dead
instead which actually does the work and permanently removes the task
from the scheduler.  Guaranteeing the task will never be woken
up again.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/exit.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index d0ec6f6b41cb..f975cd8a2ed8 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -886,8 +886,7 @@ void __noreturn make_task_dead(int signr)
 	if (unlikely(tsk->flags & PF_EXITING)) {
 		pr_alert("Fixing recursive fault but reboot is needed!\n");
 		futex_exit_recursive(tsk);
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule();
+		do_task_dead();
 	}
 
 	do_exit(signr);
-- 
2.29.2

