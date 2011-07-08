From: David Howells <dhowells@redhat.com>
Subject: [PATCH [ver #2] 29/39] UAPI: Fix linux/ncp.h
Date: Fri, 08 Jul 2011 15:27:40 +0100
Message-ID: <20110708142740.31344.68607.stgit@warthog.procyon.org.uk>
References: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37298 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752238Ab1GHO2V (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 8 Jul 2011 10:28:21 -0400
In-Reply-To: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: rdunlap@xenotime.net, hpa@kernel.org, matthew@wil.cx, linux-arch@vger.kernel.org
Cc: dhowells@redhat.com, ralf@linux-mips.org

Fix linux/coda.h to retain the #ifdef __KERNEL__ in struct nw_info_struct in
the userspace struct rather than splitting that member out into a separate
header.

This is done by placing a marker to manually control the splitter script.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/ncp.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/ncp.h b/include/linux/ncp.h
index 99f0ade..4717262 100644
--- a/include/linux/ncp.h
+++ b/include/linux/ncp.h
@@ -155,7 +155,7 @@ struct nw_info_struct {
 	__u8 nameLen;
 	__u8 entryName[256];
 	/* libncp may depend on there being nothing after entryName */
-#ifdef __KERNEL__
+#ifdef __KERNEL__ // DISINTEGRATE: RETAIN
 	struct nw_nfs_info nfs;
 #endif
 } __attribute__((packed));
