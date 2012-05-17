Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:65435 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967768Ab2EQWOD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 17 May 2012 18:14:03 -0400
From: "H.J. Lu" <hjl.tools@gmail.com>
Subject: [PATCH 04/10] Use __kernel_long_t in struct msgbuf
Date: Thu, 17 May 2012 15:13:30 -0700
Message-ID: <1337292816-10839-5-git-send-email-hjl.tools@gmail.com>
In-Reply-To: <1337292816-10839-1-git-send-email-hjl.tools@gmail.com>
References: <1337292816-10839-1-git-send-email-hjl.tools@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: torvalds@linux-foundation.org, hpa@zytor.com, mingo@kernel.org, tglx@linutronix.de, "H.J. Lu" <hjl.tools@gmail.com>
Message-ID: <20120517221330.P6TWO5ebTJQDnqHdA6V5V0XNr1mB6WxdPxWOn3RvzTc@z>

From: "H.J. Lu" <hjl.tools@gmail.com>

Replace long with __kernel_long_t in struct msgbuf for user space.

Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
---
 include/linux/msg.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/msg.h b/include/linux/msg.h
index 56abf15..c5d21c1 100644
--- a/include/linux/msg.h
+++ b/include/linux/msg.h
@@ -33,8 +33,8 @@ struct msqid_ds {
 
 /* message buffer for msgsnd and msgrcv calls */
 struct msgbuf {
-	long mtype;         /* type of message */
-	char mtext[1];      /* message text */
+	__kernel_long_t mtype;	/* type of message */
+	char mtext[1];		/* message text */
 };
 
 /* buffer for msgctl calls IPC_INFO, MSG_INFO */
-- 
1.7.6.5

