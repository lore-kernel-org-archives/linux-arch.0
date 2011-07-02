From: David Howells <dhowells@redhat.com>
Subject: [PATCH 23/35] UAPI: Fix u_quad_t ordering problem in linux/coda.h
Date: Sat, 02 Jul 2011 12:10:54 +0100
Message-ID: <20110702111054.21948.82943.stgit@warthog.procyon.org.uk>
References: <20110702110716.21948.74214.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:4016 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754332Ab1GBLK5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 2 Jul 2011 07:10:57 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p62BAv84019429
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-arch@vger.kernel.org>; Sat, 2 Jul 2011 07:10:57 -0400
In-Reply-To: <20110702110716.21948.74214.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: dhowells@redhat.com

There's an ordering problem around the definition of u_quad_t in linux/coda.h:
the definition in the kernel-specific header is referred to in the
user-specific header data structures.  When compiling userspace, the
user-specific header provides an alternate version of u_quad_t.

To get around this problem, place a marker specifically to indicate the point
at which the #include_next should be placed in the kernel-specific file.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/coda.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/coda.h b/include/linux/coda.h
index 96c8769..5a2c1a0 100644
--- a/include/linux/coda.h
+++ b/include/linux/coda.h
@@ -111,6 +111,7 @@ typedef unsigned long long u_quad_t;
 #else
 #define cdev_t dev_t
 #endif
+// DISINTEGRATE: INCLUDE UAPI HERE
 
 #ifdef __CYGWIN32__
 struct timespec {
