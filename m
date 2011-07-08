From: David Howells <dhowells@redhat.com>
Subject: [PATCH [ver #2] 09/39] UAPI: Make linux/patchkey.h easier to parse
Date: Fri, 08 Jul 2011 15:24:20 +0100
Message-ID: <20110708142420.31344.27216.stgit@warthog.procyon.org.uk>
References: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:27208 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752229Ab1GHOZD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 8 Jul 2011 10:25:03 -0400
In-Reply-To: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: rdunlap@xenotime.net, hpa@kernel.org, matthew@wil.cx, linux-arch@vger.kernel.org
Cc: dhowells@redhat.com, ralf@linux-mips.org

Make linux/patchkey.h easier to parse by:

 (1) Switching the reinclusion guard and the indirect-inclusion checks in
     linux/patchkey.h to put the guard around the outside.

 (2) Making the #elif case associated with the __KERNEL__ guard a nested #if
     in a #else of the __KERNEL__ guard.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/patchkey.h |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/include/linux/patchkey.h b/include/linux/patchkey.h
index d974a6e..aefda0e 100644
--- a/include/linux/patchkey.h
+++ b/include/linux/patchkey.h
@@ -32,7 +32,8 @@
 #  else
 #    error "could not determine byte order"
 #  endif
-#elif defined(__BYTE_ORDER)
+#else
+#if defined(__BYTE_ORDER)
 #  if __BYTE_ORDER == __BIG_ENDIAN
 #    define _PATCHKEY(id) (0xfd00|id)
 #  elif __BYTE_ORDER == __LITTLE_ENDIAN
@@ -41,5 +42,6 @@
 #    error "could not determine byte order"
 #  endif
 #endif
+#endif
 
 #endif /* _LINUX_PATCHKEY_H */
