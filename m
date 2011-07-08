From: David Howells <dhowells@redhat.com>
Subject: [PATCH [ver #2] 19/39] UAPI: Fix linux/input.h inclusion order
Date: Fri, 08 Jul 2011 15:26:01 +0100
Message-ID: <20110708142601.31344.36651.stgit@warthog.procyon.org.uk>
References: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47318 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751818Ab1GHO0r (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 8 Jul 2011 10:26:47 -0400
In-Reply-To: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: rdunlap@xenotime.net, hpa@kernel.org, matthew@wil.cx, linux-arch@vger.kernel.org
Cc: dhowells@redhat.com, ralf@linux-mips.org

Fix linux/input.h inclusion order to make sure that the inclusion of the
user-specific file happens after the inclusion of the header file that
provides struct timeval.

To get around this problem, place a marker specifically to indicate the point
at which the #include_next should be placed in the kernel-specific file.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/input.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/linux/input.h b/include/linux/input.h
index 771d6d8..ad6a33f 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -19,6 +19,8 @@
 #include <linux/types.h>
 #endif
 
+// DISINTEGRATE: INCLUDE UAPI HERE
+
 /*
  * The event structure itself
  */
