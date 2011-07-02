From: David Howells <dhowells@redhat.com>
Subject: [PATCH 17/35] UAPI: Fix linux/input.h inclusion order
Date: Sat, 02 Jul 2011 12:10:00 +0100
Message-ID: <20110702111000.21948.86664.stgit@warthog.procyon.org.uk>
References: <20110702110716.21948.74214.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35051 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754282Ab1GBLKE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 2 Jul 2011 07:10:04 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p62BA4ZQ028538
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-arch@vger.kernel.org>; Sat, 2 Jul 2011 07:10:04 -0400
In-Reply-To: <20110702110716.21948.74214.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: dhowells@redhat.com

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
