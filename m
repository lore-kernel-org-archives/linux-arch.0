From: David Howells <dhowells@redhat.com>
Subject: [PATCH [ver #2] 26/39] UAPI: Fix linux/coda.h
Date: Fri, 08 Jul 2011 15:27:09 +0100
Message-ID: <20110708142709.31344.4887.stgit@warthog.procyon.org.uk>
References: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:17176 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752218Ab1GHO1s (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 8 Jul 2011 10:27:48 -0400
In-Reply-To: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: rdunlap@xenotime.net, hpa@kernel.org, matthew@wil.cx, linux-arch@vger.kernel.org
Cc: dhowells@redhat.com, ralf@linux-mips.org

Fix linux/coda.h to retain the #ifdef __KERNEL__ in struct coda_open_by_fd_out
in the userspace struct rather than splitting that member out into a separate
header.

This is done by placing a marker to manually control the splitter script.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/coda.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/coda.h b/include/linux/coda.h
index 5a2c1a0..2ae9dcd 100644
--- a/include/linux/coda.h
+++ b/include/linux/coda.h
@@ -618,7 +618,7 @@ struct coda_open_by_fd_out {
     struct coda_out_hdr oh;
     int fd;
 
-#ifdef __KERNEL__
+#ifdef __KERNEL__ // DISINTEGRATE: RETAIN
     struct file *fh; /* not passed from userspace but used in-kernel only */
 #endif
 };
