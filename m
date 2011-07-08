From: David Howells <dhowells@redhat.com>
Subject: [PATCH [ver #2] 08/39] UAPI: ac_etime in linux/acct.h must keep its
 __KERNEL__ guards
Date: Fri, 08 Jul 2011 15:24:11 +0100
Message-ID: <20110708142411.31344.23335.stgit@warthog.procyon.org.uk>
References: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:16084 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752504Ab1GHOYu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 8 Jul 2011 10:24:50 -0400
In-Reply-To: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: rdunlap@xenotime.net, hpa@kernel.org, matthew@wil.cx, linux-arch@vger.kernel.org
Cc: dhowells@redhat.com, ralf@linux-mips.org

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
