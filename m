Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09976C433F5
	for <linux-arch@archiver.kernel.org>; Wed, 20 Oct 2021 17:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E88B56128E
	for <linux-arch@archiver.kernel.org>; Wed, 20 Oct 2021 17:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhJTRsO (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 20 Oct 2021 13:48:14 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:43642 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbhJTRrp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Oct 2021 13:47:45 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:50742)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdFec-00EwQg-0r; Wed, 20 Oct 2021 11:45:30 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:47894 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdFea-001NdN-DK; Wed, 20 Oct 2021 11:45:29 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Wed, 20 Oct 2021 12:44:04 -0500
Message-Id: <20211020174406.17889-18-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87y26nmwkb.fsf@disp2133>
References: <87y26nmwkb.fsf@disp2133>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1mdFea-001NdN-DK;;;mid=<20211020174406.17889-18-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/OEXAIXYi4uLUgO8NYQ5LoOkPqvwiFiu8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 18/20] exit/rtl8723bs: Replace the macro thread_exit with a simple return 0
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Every place thread_exit is called is at the end of a function started
with kthread_run.  The code in kthread_run has arranged things so a
kernel thread can just return and do_exit will be called.

So just have the threads return instead of calling complete_and_exit.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 drivers/staging/rtl8723bs/core/rtw_cmd.c                | 2 +-
 drivers/staging/rtl8723bs/core/rtw_xmit.c               | 2 +-
 drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c          | 2 +-
 drivers/staging/rtl8723bs/include/osdep_service_linux.h | 2 --
 4 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index d494c06dab96..8e69f9c10f5c 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -524,7 +524,7 @@ int rtw_cmd_thread(void *context)
 	complete(&pcmdpriv->terminate_cmdthread_comp);
 	atomic_set(&(pcmdpriv->cmdthd_running), false);
 
-	thread_exit();
+	return 0;
 }
 
 /*
diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index 79e4d7df1ef5..0c357bc2478c 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -2491,7 +2491,7 @@ int rtw_xmit_thread(void *context)
 
 	complete(&padapter->xmitpriv.terminate_xmitthread_comp);
 
-	thread_exit();
+	return 0;
 }
 
 void rtw_sctx_init(struct submit_ctx *sctx, int timeout_ms)
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
index 156d6aba18ca..2b9a41b12d1f 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
@@ -435,7 +435,7 @@ int rtl8723bs_xmit_thread(void *context)
 
 	complete(&pxmitpriv->SdioXmitTerminate);
 
-	thread_exit();
+	return 0;
 }
 
 s32 rtl8723bs_mgnt_xmit(
diff --git a/drivers/staging/rtl8723bs/include/osdep_service_linux.h b/drivers/staging/rtl8723bs/include/osdep_service_linux.h
index 3492ec1efd1e..188ed7e26550 100644
--- a/drivers/staging/rtl8723bs/include/osdep_service_linux.h
+++ b/drivers/staging/rtl8723bs/include/osdep_service_linux.h
@@ -45,8 +45,6 @@
 		spinlock_t	lock;
 	};
 
-	#define thread_exit() complete_and_exit(NULL, 0)
-
 static inline struct list_head *get_next(struct list_head	*list)
 {
 	return list->next;
-- 
2.20.1

