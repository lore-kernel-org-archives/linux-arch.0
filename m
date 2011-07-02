From: David Howells <dhowells@redhat.com>
Subject: [PATCH 27/35] UAPI: Fix linux/ncp.h
Date: Sat, 02 Jul 2011 12:11:27 +0100
Message-ID: <20110702111126.21948.94263.stgit@warthog.procyon.org.uk>
References: <20110702110716.21948.74214.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47490 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751006Ab1GBLLa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 2 Jul 2011 07:11:30 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p62BBUGR025999
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-arch@vger.kernel.org>; Sat, 2 Jul 2011 07:11:30 -0400
In-Reply-To: <20110702110716.21948.74214.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: dhowells@redhat.com

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
