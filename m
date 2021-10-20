Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0A4C433F5
	for <linux-arch@archiver.kernel.org>; Wed, 20 Oct 2021 17:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17744611C7
	for <linux-arch@archiver.kernel.org>; Wed, 20 Oct 2021 17:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbhJTRro (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 20 Oct 2021 13:47:44 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:57160 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbhJTRr0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Oct 2021 13:47:26 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:53062)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdFeJ-002tON-9S; Wed, 20 Oct 2021 11:45:11 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:47894 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdFeH-001NdN-SY; Wed, 20 Oct 2021 11:45:10 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Wed, 20 Oct 2021 12:43:58 -0500
Message-Id: <20211020174406.17889-12-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87y26nmwkb.fsf@disp2133>
References: <87y26nmwkb.fsf@disp2133>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1mdFeH-001NdN-SY;;;mid=<20211020174406.17889-12-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/XapgcmttyvufMl0ikLC70m07ALj1c2To=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 12/20] exit/kthread: Have kernel threads return instead of calling do_exit
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In 2009 Oleg reworked[1] the kernel threads so that it is not
necessary to call do_exit if you are not using kthread_stop().  Remove
the explicit calls of do_exit and complete_and_exit (with a NULL
completion) that were previously necessary.

[1] 63706172f332 ("kthreads: rework kthread_stop()")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 drivers/firmware/stratix10-svc.c | 4 ++--
 drivers/soc/ti/wkup_m3_ipc.c     | 2 +-
 fs/ocfs2/journal.c               | 5 +----
 kernel/kthread.c                 | 2 +-
 net/batman-adv/tp_meter.c        | 2 +-
 5 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 2a7687911c09..29c0a616b317 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -520,7 +520,7 @@ static int svc_normal_to_secure_thread(void *data)
  * physical address of memory block reserved by secure monitor software at
  * secure world.
  *
- * svc_normal_to_secure_shm_thread() calls do_exit() directly since it is a
+ * svc_normal_to_secure_shm_thread() terminates directly since it is a
  * standlone thread for which no one will call kthread_stop() or return when
  * 'kthread_should_stop()' is true.
  */
@@ -544,7 +544,7 @@ static int svc_normal_to_secure_shm_thread(void *data)
 	}
 
 	complete(&sh_mem->sync_complete);
-	do_exit(0);
+	return 0;
 }
 
 /**
diff --git a/drivers/soc/ti/wkup_m3_ipc.c b/drivers/soc/ti/wkup_m3_ipc.c
index 09abd17065ba..0733443a2631 100644
--- a/drivers/soc/ti/wkup_m3_ipc.c
+++ b/drivers/soc/ti/wkup_m3_ipc.c
@@ -426,7 +426,7 @@ static void wkup_m3_rproc_boot_thread(struct wkup_m3_ipc *m3_ipc)
 	else
 		m3_ipc_state = m3_ipc;
 
-	do_exit(0);
+	return 0;
 }
 
 static int wkup_m3_ipc_probe(struct platform_device *pdev)
diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
index 4f15750aac5d..329986f12db3 100644
--- a/fs/ocfs2/journal.c
+++ b/fs/ocfs2/journal.c
@@ -1497,10 +1497,7 @@ static int __ocfs2_recovery_thread(void *arg)
 	if (quota_enabled)
 		kfree(rm_quota);
 
-	/* no one is callint kthread_stop() for us so the kthread() api
-	 * requires that we call do_exit().  And it isn't exported, but
-	 * complete_and_exit() seems to be a minimal wrapper around it. */
-	complete_and_exit(NULL, status);
+	return status;
 }
 
 void ocfs2_recovery_thread(struct ocfs2_super *osb, int node_num)
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 5b37a8567168..33e17beaa682 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -433,7 +433,7 @@ struct task_struct *__kthread_create_on_node(int (*threadfn)(void *data),
  * If thread is going to be bound on a particular cpu, give its node
  * in @node, to get NUMA affinity for kthread stack, or else give NUMA_NO_NODE.
  * When woken, the thread will run @threadfn() with @data as its
- * argument. @threadfn() can either call do_exit() directly if it is a
+ * argument. @threadfn() can either return directly if it is a
  * standalone thread for which no one will call kthread_stop(), or
  * return when 'kthread_should_stop()' is true (which means
  * kthread_stop() has been called).  The return value should be zero
diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 56b9fe97b3b4..1252540cde17 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -890,7 +890,7 @@ static int batadv_tp_send(void *arg)
 
 	batadv_tp_vars_put(tp_vars);
 
-	do_exit(0);
+	return 0;
 }
 
 /**
-- 
2.20.1

