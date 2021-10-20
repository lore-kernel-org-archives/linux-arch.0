Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01737C433EF
	for <linux-arch@archiver.kernel.org>; Wed, 20 Oct 2021 17:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD1B96128E
	for <linux-arch@archiver.kernel.org>; Wed, 20 Oct 2021 17:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbhJTRsZ (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 20 Oct 2021 13:48:25 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:43678 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbhJTRrs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Oct 2021 13:47:48 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:50770)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdFef-00EwRf-3j; Wed, 20 Oct 2021 11:45:33 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:47894 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdFec-001NdN-Ug; Wed, 20 Oct 2021 11:45:32 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Wed, 20 Oct 2021 12:44:05 -0500
Message-Id: <20211020174406.17889-19-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87y26nmwkb.fsf@disp2133>
References: <87y26nmwkb.fsf@disp2133>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1mdFec-001NdN-Ug;;;mid=<20211020174406.17889-19-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18lHLRrKyCVQ7AL97xlaRrOt/26tWMvpTQ=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 19/20] exit/rtl8712: Replace the macro thread_exit with a simple return 0
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The macro thread_exit is called is at the end of a function started
with kthread_run.  The code in kthread_run has arranged things so a
kernel thread can just return and do_exit will be called.

So just have the cmd_thread return instead of calling complete_and_exit.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 drivers/staging/rtl8712/osdep_service.h | 1 -
 drivers/staging/rtl8712/rtl8712_cmd.c   | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8712/osdep_service.h b/drivers/staging/rtl8712/osdep_service.h
index d33ddffb7ad9..0d9bb42cbc58 100644
--- a/drivers/staging/rtl8712/osdep_service.h
+++ b/drivers/staging/rtl8712/osdep_service.h
@@ -37,7 +37,6 @@ struct	__queue	{
 
 #define _pkt struct sk_buff
 #define _buffer unsigned char
-#define thread_exit() complete_and_exit(NULL, 0)
 
 #define _init_queue(pqueue)				\
 	do {						\
diff --git a/drivers/staging/rtl8712/rtl8712_cmd.c b/drivers/staging/rtl8712/rtl8712_cmd.c
index e9294e1ed06e..2326aae6709e 100644
--- a/drivers/staging/rtl8712/rtl8712_cmd.c
+++ b/drivers/staging/rtl8712/rtl8712_cmd.c
@@ -393,7 +393,7 @@ int r8712_cmd_thread(void *context)
 		r8712_free_cmd_obj(pcmd);
 	} while (1);
 	complete(&pcmdpriv->terminate_cmdthread_comp);
-	thread_exit();
+	return 0;
 }
 
 void r8712_event_handle(struct _adapter *padapter, __le32 *peventbuf)
-- 
2.20.1

