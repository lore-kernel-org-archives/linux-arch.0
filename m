From: David Howells <dhowells@redhat.com>
Subject: [PATCH 05/35] UAPI: Fix AHZ multiple inclusion when __KERNEL__ is
 removed
Date: Sat, 02 Jul 2011 12:08:16 +0100
Message-ID: <20110702110815.21948.48762.stgit@warthog.procyon.org.uk>
References: <20110702110716.21948.74214.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36995 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753470Ab1GBLIS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 2 Jul 2011 07:08:18 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p62B8IXE015957
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-arch@vger.kernel.org>; Sat, 2 Jul 2011 07:08:18 -0400
In-Reply-To: <20110702110716.21948.74214.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: dhowells@redhat.com

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
