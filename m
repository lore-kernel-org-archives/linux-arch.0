From: David Howells <dhowells@redhat.com>
Subject: [PATCH [ver #2] 38/39] UAPI: Fix the page-types query program in the
 docs
Date: Fri, 08 Jul 2011 15:29:12 +0100
Message-ID: <20110708142911.31344.50243.stgit@warthog.procyon.org.uk>
References: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:27596 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752830Ab1GHO3u (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 8 Jul 2011 10:29:50 -0400
In-Reply-To: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: rdunlap@xenotime.net, hpa@kernel.org, matthew@wil.cx, linux-arch@vger.kernel.org
Cc: dhowells@redhat.com, ralf@linux-mips.org

Fix the page-types query program in Documentation/vm/ as that refers to the
magic numbers header file directly, but the magic numbers are now in the UAPI
headers.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 Documentation/vm/page-types.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/vm/page-types.c b/Documentation/vm/page-types.c
index 7445caa..8d6a54f 100644
--- a/Documentation/vm/page-types.c
+++ b/Documentation/vm/page-types.c
@@ -34,7 +34,7 @@
 #include <sys/fcntl.h>
 #include <sys/mount.h>
 #include <sys/statfs.h>
-#include "../../include/linux/magic.h"
+#include "../../include/uapi/linux/magic.h"
 
 
 #ifndef MAX_PATH
