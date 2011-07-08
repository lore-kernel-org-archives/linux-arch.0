From: David Howells <dhowells@redhat.com>
Subject: [PATCH [ver #2] 07/39] UAPI: Fix AHZ multiple inclusion when
 __KERNEL__ is removed
Date: Fri, 08 Jul 2011 15:24:03 +0100
Message-ID: <20110708142402.31344.28917.stgit@warthog.procyon.org.uk>
References: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42231 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752069Ab1GHOYq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 8 Jul 2011 10:24:46 -0400
In-Reply-To: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: rdunlap@xenotime.net, hpa@kernel.org, matthew@wil.cx, linux-arch@vger.kernel.org
Cc: dhowells@redhat.com, ralf@linux-mips.org

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/acct.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/include/linux/acct.h b/include/linux/acct.h
index 3e4737f..d537aa0 100644
--- a/include/linux/acct.h
+++ b/include/linux/acct.h
@@ -146,6 +146,9 @@ extern void acct_exit_ns(struct pid_namespace *);
  *
  */
 
+#undef ACCT_VERSION
+#undef AHZ
+
 #ifdef CONFIG_BSD_PROCESS_ACCT_V3
 #define ACCT_VERSION	3
 #define AHZ		100
