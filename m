From: David Howells <dhowells@redhat.com>
Subject: [PATCH 19/35] UAPI: Fix linux/auto_fs.h inclusion order
Date: Sat, 02 Jul 2011 12:10:19 +0100
Message-ID: <20110702111018.21948.90157.stgit@warthog.procyon.org.uk>
References: <20110702110716.21948.74214.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58510 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754332Ab1GBLKW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 2 Jul 2011 07:10:22 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p62BAMXS019357
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-arch@vger.kernel.org>; Sat, 2 Jul 2011 07:10:22 -0400
In-Reply-To: <20110702110716.21948.74214.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: dhowells@redhat.com

Fix linux/auto_fs.h inclusion order to make sure that the inclusion of the
user-specific file happens after the inclusion of the header file that
provides NAME_MAX.

To get around this problem, place a marker specifically to indicate the point
at which the #include_next should be placed in the kernel-specific file.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/auto_fs.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/linux/auto_fs.h b/include/linux/auto_fs.h
index da64e15..f9ca4e6 100644
--- a/include/linux/auto_fs.h
+++ b/include/linux/auto_fs.h
@@ -23,6 +23,8 @@
 #include <sys/ioctl.h>
 #endif /* __KERNEL__ */
 
+// DISINTEGRATE: INCLUDE UAPI HERE
+
 /* This file describes autofs v3 */
 #define AUTOFS_PROTO_VERSION	3
 
