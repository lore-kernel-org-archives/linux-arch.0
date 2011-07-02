From: David Howells <dhowells@redhat.com>
Subject: [PATCH 06/35] UAPI: ac_etime in linux/acct.h must keep its __KERNEL__
 guards
Date: Sat, 02 Jul 2011 12:08:23 +0100
Message-ID: <20110702110823.21948.64283.stgit@warthog.procyon.org.uk>
References: <20110702110716.21948.74214.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43920 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753470Ab1GBLI1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 2 Jul 2011 07:08:27 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p62B8Qr6015973
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-arch@vger.kernel.org>; Sat, 2 Jul 2011 07:08:26 -0400
In-Reply-To: <20110702110716.21948.74214.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: dhowells@redhat.com

ac_etime in linux/acct.h must keep its __KERNEL__ guards.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/acct.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/acct.h b/include/linux/acct.h
index d537aa0..55e88b5 100644
--- a/include/linux/acct.h
+++ b/include/linux/acct.h
@@ -81,7 +81,7 @@ struct acct_v3
 	__u32		ac_pid;			/* Process ID */
 	__u32		ac_ppid;		/* Parent Process ID */
 	__u32		ac_btime;		/* Process Creation Time */
-#ifdef __KERNEL__
+#ifdef __KERNEL__ // DISINTEGRATE: RETAIN
 	__u32		ac_etime;		/* Elapsed Time */
 #else
 	float		ac_etime;		/* Elapsed Time */
