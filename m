From: David Howells <dhowells@redhat.com>
Subject: [PATCH [ver #2] 25/39] UAPI: Fix u_quad_t ordering problem in
 linux/coda.h
Date: Fri, 08 Jul 2011 15:26:58 +0100
Message-ID: <20110708142658.31344.909.stgit@warthog.procyon.org.uk>
References: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:24122 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752218Ab1GHO1k (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 8 Jul 2011 10:27:40 -0400
In-Reply-To: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: rdunlap@xenotime.net, hpa@kernel.org, matthew@wil.cx, linux-arch@vger.kernel.org
Cc: dhowells@redhat.com, ralf@linux-mips.org

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
