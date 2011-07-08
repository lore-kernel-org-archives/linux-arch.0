From: David Howells <dhowells@redhat.com>
Subject: [PATCH [ver #2] 18/39] UAPI: Fix linux/netfilter.h inclusion order
Date: Fri, 08 Jul 2011 15:25:51 +0100
Message-ID: <20110708142550.31344.29611.stgit@warthog.procyon.org.uk>
References: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36596 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751818Ab1GHO0d (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 8 Jul 2011 10:26:33 -0400
In-Reply-To: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: rdunlap@xenotime.net, hpa@kernel.org, matthew@wil.cx, linux-arch@vger.kernel.org
Cc: dhowells@redhat.com, ralf@linux-mips.org

Fix linux/netfilter.h inclusion order to make sure that the inclusion of the
user-specific file happens after the inclusion of the header file that
provides struct in_addr and struct in6_addr.

To get around this problem, place a marker specifically to indicate the point
at which the #include_next should be placed in the kernel-specific file.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/netfilter.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/linux/netfilter.h b/include/linux/netfilter.h
index 857f502..4faf53d 100644
--- a/include/linux/netfilter.h
+++ b/include/linux/netfilter.h
@@ -15,6 +15,8 @@
 #include <linux/compiler.h>
 #include <linux/sysctl.h>
 
+// DISINTEGRATE: INCLUDE UAPI HERE
+
 /* Responses from hook functions. */
 #define NF_DROP 0
 #define NF_ACCEPT 1
