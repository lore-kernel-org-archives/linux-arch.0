From: David Howells <dhowells@redhat.com>
Subject: [PATCH 15/17] UAPI: Fix AHZ multiple inclusion when __KERNEL__ is removed
Date: Tue, 13 Dec 2011 10:04:11 +0000
Message-ID: <1323770653-19177-16-git-send-email-dhowells@redhat.com>
References: <1323770653-19177-1-git-send-email-dhowells@redhat.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from warthog.procyon.org.uk ([90.155.74.18]:52105 "EHLO
	warthog.procyon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372Ab1LMKiv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 13 Dec 2011 05:38:51 -0500
In-Reply-To: <1323770653-19177-1-git-send-email-dhowells@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: sfr@canb.auug.org.au, torvalds@linux-foundation.org
Cc: arnd@arndb.de, dhowells@redhat.com, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

Fix AHZ multiple inclusion when __KERNEL__ is removed as part of the separation
of the userspace headers from the kernel headers.

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
-- 
1.7.7.4
