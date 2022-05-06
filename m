Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3066DC433F5
	for <linux-arch@archiver.kernel.org>; Fri,  6 May 2022 14:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442152AbiEFOTg (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Fri, 6 May 2022 10:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442207AbiEFOTe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 May 2022 10:19:34 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD566928D;
        Fri,  6 May 2022 07:15:47 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:56172)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nmykE-007CH6-TV; Fri, 06 May 2022 08:15:46 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:37210 helo=localhost.localdomain)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nmykD-007Cxx-P8; Fri, 06 May 2022 08:15:46 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-arch@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Fri,  6 May 2022 09:15:11 -0500
Message-Id: <20220506141512.516114-6-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87mtfu4up3.fsf@email.froward.int.ebiederm.org>
References: <87mtfu4up3.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1nmykD-007Cxx-P8;;;mid=<20220506141512.516114-6-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+i6APYhR/pOCN3BklB4+V7ylUJfo+qYO8=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 6/7] fork: Explicitly set PF_KTHREAD
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Instead of implicitly inheriting PF_KTHREAD from the parent process
examine arguments in kernel_clone_args to see if PF_KTHREAD should be
set.  This makes knowledge of which new threads are kernel threads
explicit.

This also makes it so that init and the user mode helper processes
no longer have PF_KTHREAD set.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/fork.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index 8e17c3fbce42..35645f57bd2f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2068,6 +2068,9 @@ static __latent_entropy struct task_struct *copy_process(
 	p = dup_task_struct(current, node);
 	if (!p)
 		goto fork_out;
+	p->flags &= ~PF_KTHREAD;
+	if (args->kthread)
+		p->flags |= PF_KTHREAD;
 	if (args->io_thread) {
 		/*
 		 * Mark us an IO worker, and block any signal that isn't
-- 
2.35.3

